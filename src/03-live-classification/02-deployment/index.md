# Deployment

In the Edge Impulse menu, go to the *Deployment*-tab.

![Deployment button](./img/ei_deployment_button.png)

Instead of running the neural network in Edge Impulse with the *Live Classification* method and the *edge-impulse-data-forwarder*, we are now going to run the model directly on the Sensortile microcontroller. Therefore we need to extract the model from Edge Impulse by using the deployment functionality.

## Downloading the impulse as a library

Edge Impulse gives us several methods to deploy the impulse or the neural network to your device of choice. Two main methods are available:

1. Create a library which we can use in our development tool of choice.
2. Build the firmware directly for a specific device.

Under *create library* we can see several commonly used development tools and their corresponding library exports, such as Arduino, Cube.MX from STM, TensorRT from Nivida etc.

![All libraries](./img/ei_deployment_all.png)

Under *build firmware* we can see several hardware edge-devices which are directly supported by the Edge Impulse framework. For example the ST, Arduino and Nordic development boards.

![Firwmare devices](./img/ei_firmware_devices.png)

As our device is not listed in the device list, we are going to download the *optimized* source code *create a library*. Because we are using the mbed tools to compile and deploy our code to the Sensortile, we are going to specify the *C++ library* export. In this way we can use the exported files as normal C++ libraries in our mbed project.

![Cpp select](./img/ei_deployment_cpp.png)

Selecting the library type does not give us a library yet. Scroll down the page to see more options. Edge Impulse gives us the choice to use their optimisation tool "EON" to improve the size of the model even more.

:::tip Edge Impulse EON Compiler

The EON compiler is not a completely new runtime, it still uses Tensorflow Lite for Microcontrollers under the hood and is also the reason why the latency numbers will be exactly the same with and without enabling the EON compiler. Tensorflow Lite for Microcontrollers has a generic model interpreter and interpretes and runs the model at runtime. EON will compile the neural network to C++ source code so it can be directly run on the microcontroller without first interpreting it. By compiling the neural network to source code the interpreter is not necessary, more data can be placed in ROM memory and the linker will know exactly which operations are being used. In this way a lot more code can be eliminated and less resources are used. More information can be found [here](https://www.edgeimpulse.com/blog/introducing-eon).

:::

As can be seen in the figure below we now have four options to export the library:

- Disabled EON compiler & Unoptimized (float32) model
- Disabled EON compiler & Quantised (int8) model
- Enabled EON compiler & Unoptimized (float32) model
- Enabled EON compiler & Quantised (int8) model

![EON Compiler](./img/ei_optimize_EON.png)

To see the performance difference we can press the **Analyze optimizations** button. The result will show the performance difference in RAM, latency and the confusion matrix.

![Choose smallest](./img/ei_optimised_int8.png)

If the device its memory space allows it, any version can be build and downloaded. In our case, we are going to select the EON enabled and quantised model for deployment on the Sensortile. After selecting the right version, press the **Build** button on the bottom of the page.

![Built](./img/ei_built.png)

After building the library files, a notification should come up on Edge Impulse and a download should be ready to save to our file system. Download the file in the `/home/pi/Downloads` folder. After completing the download, the file should be visible at the bottom of the Chromium webpage like this:

![Downloaded file](./img/ei_file.png)

We can browse to the Downloads folder by using File Manager in Raspbian. The zip-file should be inside the folder. If not, please retry downloading the library or search for it in another folder.

![Download folder](./img/ei_downloads_folder.png)

Export the contents of the zip-folder to the folder `/home/pi/workshop-ai-edge/AB-writing-standalone-inference-mbed` by either

- Double-clicking the zip-folder and drag-and-drop its contents to the folder OR
- by right-clicking the zip-folder and selecting the right folder to export the files to.

After extracting the files to the standalone mbed project folder, the contents should look like this:

![Extract to project](./img/ei_mbed_folder.png)

:::tip Some missing folders

It is possible that there is no BUILD and \_\_pycache\_\_ folder, this is normal (these are created by compiling the code).

:::

## Compiling the code

We now have a mbed-project which is ready to be compiled and place on the Sensortile. The code in the `src` folder has been prepared to accept an impulse with raw features and uses the same code to capture the accelerometer values from the component.



![Classification!](./img/ei_classified_on_microcontroller.png)
