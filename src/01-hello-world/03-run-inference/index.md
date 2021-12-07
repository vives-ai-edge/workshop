# Run Inference

## mbed

## Targets

### Nucleo L476RG

### SensorTile

## Application

Now we are ready to run the model on an embedded device. In this case we will run the it on a Cortex-M4 microcontroller from ST. The STM42L476RG is provided on a [NUCLEO L476RG](https://www.st.com/en/evaluation-tools/nucleo-l476rg.html) development board. We can use the included Stlink v2 debugger to flash the device.

The NUCLEO provides Arduino and Morpho compatible headers to make it easy to connect and expand functionality. The microcontroller is a 32bit ARM Cortex M4 with a 80Mhz clock.

<!-- LED for feedback -->

<!-- UART for comms  -->

You can follow along and find the full code of the project on GitHub: [vives-ai-edge/tensorflow-lite-micro-hello-world-mbed](https://github.com/vives-ai-edge/tensorflow-lite-micro-hello-world-mbed)

### Mbed project setup

In order to get the mbed tool up and running, some configuration must be added to the project. Mbed uses a `mbed_app.json` file for every project that contain custom configuration for that project. For this example to work we need to add some configuration.

Executing tensorflow and allocating the model will need memory on the microcontroller. By default mbed-os allocates some memory to the main thread. In order to have enough free memory on the stack, the main stack size might need to be changed. For this example a value of `65kb` is more than enough.


```json
"config": {
    "main-stack-size": {
        "value": 65536
    }
},

The application does not need the whole RTOS runtime. The `bare-metal` runtime provides all the needed resources to run the tensorflow library. 

Not having the RTOS available means you need to take care of timings and timers yourself. Luckally mbed provides the `events` library as a separate module. This will enable us to use an `EventQueue` that can take care of timed execution of the appliation.

The last requirement is the _USB driver_ library that provides USB functionality. This enables us to enumerate a USB Serial device using the USB cable. This is needed for the Sensortile as no UART pins or interface is provided on the small board.

```json
"requires": ["bare-metal", "events", "drivers-usb"]
```

Tensorflow needs some proprocessor directives enabled to compile the application.

```json
"macros": [
    "NDEBUG",
    "TF_LITE_DISABLE_X86_NEON",
    "TF_LITE_STATIC_MEMORY"
],
```

The last thing that needs to be configured for easy debugging are some setting for the UART. The _baudrate_ could be set to 115200 baud.

Mbed does not load the `std` library by default. This is a measure mainly to free up flasch and memory for features that might not be used. In our case we want to leverage some features of the standard library for formatted printing like `printf` and be able to print floating point numbers with `printf`.

```json
"target_overrides": {
    "*": {
        "platform.stdio-baud-rate": 115200,
        "target.printf_lib": "std",
        "platform.minimal-printf-enable-floating-point": false,
        "target.device_has_add": [
            "USBDEVICE"
        ]
    }
```

With the `mbed_app.json` settings file configured, the compiler and runtime will have the correct information to run the example. Lets take a look at the implementation.

### Model and libraries

The first thing we need to to is to load the correct libraries for mbed and Tensorflow using `#include`.

This is also the time to load the model using the generated `model.h` file. This files contains the `char array` representation of the model.

_Using_ the `tflite` namespace will make the implementation less verbose and easier to read or understand.

An `EventQueue` object is created as well. This will help later when implementing a timer in order to run the inferencing in a repetitive and timed interval.

```cpp
#include "mbed.h"

#include "tensorflow/lite/micro/all_ops_resolver.h"
#include "tensorflow/lite/micro/micro_interpreter.h"

#include "model.h"

using namespace tflite;

EventQueue queue;
```

### USB Serial for Sensortile

The Nucleo L476RG and Sensortile use the same microcontroller, but differ allot in hardware features. The Sensortile lacks the UART to USB converter that is provided on the Nucleo using the ST-Link. In order to be able to communicate with, and get the values of the Sensortile, the USB port can be used.

The default `STD_OUT` for the `printf` needs to be redirected to the USB Serial device. This can be done using the `mbed_override_console()` function.

Now we can use the normal and global `printf` function in our application and communicate over the USB Serial device.

```cpp
//*** Comment next line out if target IS a sensortile ***//
// #define TARGET_SENSORTILE

#ifdef TARGET_SENSORTILE
  #include "USBSerial.h"

  USBSerial serial(false);

  FileHandle *mbed::mbed_override_console(int) {
    return &serial;
  }
#endif
```

### Application constants

The application works by generating a `x` value on every iteration. The `x` must represent value that ranges from 0 to (2 x Pi). So first we need to define Pi and the upper limit value `xrange`. These values where used when training the model.

In order to generate some `x` values, we need to define how many inferences we want in a full cycle. A cycle is includes the full range of 0 to 2 x Pi. In this case we choose to have `100` inferences in a full cycle.

The only thing that last is to count the inferences, so we can keep track on what number to generate next.

```cpp
const float Pi = 3.14159265359f;
const float xrange = 2.f * Pi;
const int InferencesPerCycle = 100;
int inference_count = 0;
```

### Tensorflow and the model

Now we are ready to load the `model`. The model contains the flatbuffer C data array representation of the generated model.

In order to use Tensorflow Lite Micro, an interpreter is used to convert the model at runtime. The interpreter needs memory to execute, which is defined in the `tensor_arena` array.

In this case a memory arena of 2468 bytes is created, with some extra size.

In order to supply and receive values from the model, an input and output `Tensor` object is needed.

The last thing to do is to allocate some memmory for that the Tensorflow interpreter can use to do its work.

```cpp
// Structure that contains the generated tensorflow model
const Model* model = GetModel(g_model);

// Interpreter, input and output structures
MicroInterpreter* interpreter = nullptr;
TfLiteTensor* input = nullptr;
TfLiteTensor* output = nullptr;

// Allocate memory for the tensors
const int ModelArenaSize = 2468;
const int ExtraArenaSize = 560 + 16 + 100;
const int TensorArenaSize = ModelArenaSize + ExtraArenaSize;
uint8_t tensor_arena[TensorArenaSize];
```

### Output and feedback

In order to debug, or get feedback of the from the application, two interfaces can be used.

First the led can be used to indicate the current result or `Y` value that is calculated by the model. The Nucleo provides a led that is attached to a PWM output. This enables dimming of the led, depending of a value between `0.0` and `1.0`.

The Sensortile does not provide a led on a PWM output, but only on a GPIO. This means we are not able to dim the led in an efficient way. We can solve this by only turning the led on or off depending of the resulting value.

Other than the visual feedback on a led, more information can be provided using the UART or Serial port. In this case `printf()` is used to nicelly format a string. The floating point numbers are converter to a fixed length, and are padded in order to form a constanct column.

```cpp
// Led to indicate the resulted values
PwmOut nucleo_led(LED1);
DigitalOut sensortile_led((PinName)0x6C);


void setLed(float value) {
  nucleo_led = abs(value);
  sensortile_led = value < 0.0f ? 0 : 1;
}

void printValues(float x, float y) {
  printf("x_value: % 2.3f, y_value: % 02.3f\n", x, y);
}
```

### Generating the next X value

```cpp
float generateNextXValue() {
    float position = (float) inference_count / InferencesPerCycle;
    float x_value =  position * xrange;
    inference_count = (inference_count + 1) % InferencesPerCycle;
    return x_value;
}
```

### Inference implementation

```cpp
float inference(float x) {
  input->data.f[0] = x;
  interpreter->Invoke();
  return output->data.f[0];
}
```

### Infer a single time

```cpp
void run_once() {
    float x_value = generateNextXValue();

    float y_value = inference(x_value);

    setLed(y_value);
    printValues(x_value, y_value);
}
```

### Bringing it all together

```cpp
int main(void) {
  static AllOpsResolver resolver;
  static MicroInterpreter static_interpreter(model, resolver, tensor_arena, TensorArenaSize, NULL);
  interpreter = &static_interpreter;
  interpreter->AllocateTensors();

  input = interpreter->input(0);
  output = interpreter->output(0);

  queue.call_every(10ms, run_once);
  queue.dispatch_forever();
}
```

---


```cpp
#include "mbed.h"

#include "tensorflow/lite/micro/all_ops_resolver.h"
#include "tensorflow/lite/micro/micro_interpreter.h"
#include "tensorflow/lite/schema/schema_generated.h"

#include "model.h"

using namespace tflite;
```

```cpp
// This constant represents the range of x values our model was trained on,
// which is from 0 to (2 * Pi). We approximate Pi to avoid requiring additional
// libraries.
const float Pi = 3.14159265359f;
const float kXrange = 2.f * Pi;

// This constant determines the number of inferences to perform across the range
// of x values defined above. Since each inference takes time, the higher this
// number, the more time it will take to run through the entire range. The value
// of this constant can be tuned so that one full cycle takes a desired amount
// of time. Since different devices take different amounts of time to perform
// inference, this value should be defined per-device.
const int InferencesPerCycle = 100;
```

```cpp
  // Map the model into a usable data structure. This doesn't involve any
  // copying or parsing, it's a very lightweight operation.

const Model* model = GetModel(g_model);

MicroInterpreter* interpreter = nullptr;
TfLiteTensor* input = nullptr;
TfLiteTensor* output = nullptr;
int inference_count = 0;
```

```cpp
// Create an area of memory to use for input, output, and intermediate arrays.
// Minimum arena size, at the time of writing. After allocating tensors
// you can retrieve this value by invoking interpreter.arena_used_bytes().
const int ModelArenaSize = 2468;
// Extra headroom for model + alignment + future interpreter changes.
const int ExtraArenaSize = 560 + 16 + 100;
const int TensorArenaSize = ModelArenaSize + ExtraArenaSize;
uint8_t tensor_arena[TensorArenaSize];
```

```cpp
PwmOut led(LED1);
```

```cpp
void setLed(float value) {
  led = abs(value);
}
```

```cpp
// Output the results.
// Log the current X and Y values

void printValues(float x, float y) {
  printf("x_value: % 2.3f, y_value: % 02.3f\n", x, y);
}
```

```cpp
float inference(float x) {
  // Place our calculated x value in the model's input tensor
  input->data.f[0] = x;

  // // Run inference, and report any error
  // TfLiteStatus invoke_status = interpreter->Invoke();
  // if (invoke_status != kTfLiteOk) {
  //   printf("Invoke failed on x_val: %f\n", x);
  //   return -1.0;
  // }

  interpreter->Invoke();

  // Read the predicted y value from the model's output tensor
  return output->data.f[0];
}
```

```cpp
// Calculate an x value to feed into the model. We compare the current
    // inference_count to the number of inferences per cycle to determine
    // our position within the range of possible x values the model was
    // trained on, and use this to calculate a value.
float generateNextPosition() {
    float position = (float) inference_count / InferencesPerCycle;
    float y_value =  position * xrange;
    // Increment the inference_counter, and reset it if we have reached
    // the total number per cycle
    inference_count = (inference_count + 1) % InferencesPerCycle;
    return y_value;
}
```

```cpp
int main(void) {
  // if (model->version() != TFLITE_SCHEMA_VERSION) {

  //   printf("Model provided is schema version %d not equal "
  //         "to supported version %d.",
  //         (int) model->version(), (int) TFLITE_SCHEMA_VERSION);
  //   return;
  // }

  // This pulls in all the operation implementations we need.
  // NOLINTNEXTLINE(runtime-global-variables)
  static AllOpsResolver resolver;

  // Build an interpreter to run the model with.
  static MicroInterpreter static_interpreter(
      model, resolver, tensor_arena, TensorArenaSize, NULL);
  interpreter = &static_interpreter;

  // Allocate memory from the tensor_arena for the model's tensors.
  TfLiteStatus allocate_status = interpreter->AllocateTensors();
  // if (allocate_status != kTfLiteOk) {
  //   printf("AllocateTensors() failed");
  //   return;
  // }

  // Obtain pointers to the model's input and output tensors.
  input = interpreter->input(0);
  output = interpreter->output(0);

  while(true) {
      //...
  }
}
```

```cpp
while (true) {
    float x_value = generateNextPosition();
    float y_value = inference(x_value);

    setLed(y_value);
    printValues(x_value, y_value);
}
```
