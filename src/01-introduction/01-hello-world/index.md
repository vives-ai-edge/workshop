# Hello World Example

Source: TinyML (Machine Learning with TensorFlow Lite on Arduino and Ultra-Low-Power Microcontrollers) by Pete Warden & Daniel Situnayake

## Goal
We want to calculate the sine of x and use its output to control the timing of a flashing LED on our microcontroller.
Instead of using mathematic functions to calculate the sine of x we can train a model that takes x (going from 0 to 2&pi;) and outputs the corresponding sine value (which lays between -1 and 1).

![](../../../img/hello_world_tf.svg)

## Prerequisites

Open a Jupyter-Notebook instance using the command line and typing:

```shell
jupyter-notebook
```

If this doesn't work, try a reboot or typing `source ~/.profile` and try again.

The console should give you a URL with a token attached to it where the notebook is located. Open this URL with Chromium.
Download [`train_hello_world_model.ipynb`](https://github.com/tensorflow/tflite-micro/blob/main/tensorflow/lite/micro/examples/hello_world/train/train_hello_world_model.ipynb) from the Tensorflow lite micro examples, save or copy/paste the file to the directory where jupyter-notebook is running. The file should now be visible in the jupyter notebook. Open the file `train_hello_world_model.ipynb`.

:::tip Installing dependencies
In the chapter _Setup Environment_ the tensorflow dependency `tensorflow=2.4.0` is installed. This step might take a long time to complete. I if you are following the workshop on a prepared system, this dependency is already installed for you, and you can skip this step by commenting it out by prepending a `#` character at the beginning of the line.

```pyton
# ! pip install tensorflow==2.4.0
```

:::

## Steps

An overview is given of the steps that are taken to create the dataset, train the model and export the model parameters. A more in-depth explanation of the code and the functions is embedded in the Jupyter Notebook.

One can run the whole notebook by using the ![Run all](../../../img/jupyter_arrow.png) symbol, or by going through it step by step by pressing `ctrl+Enter`.

1. Obtain a simple dataset
   * Generate data
   * Add noise
   * Split the data
2. Train a small model
   * Design the neural network
   * Train the neural network
   * Plot and observe the metrics
3. Train a larger model
   * Design the neural network
   * Train the neural network
   * Plot and observe the metrics
4. Generate a Tensorflow Lite model
   * Generate model without quantisation
   * Generate model with quantisation
   * Compare the model performance
5. Generate a Tensorflow Lite for Microcontrollers model
6. [Deploy to a Microcontroller](../02-training-a-model/index.md)

The training dataset can be adjusted to your liking, but keep in mind that the program running on the microcontroller will have to be adjusted accordingly!

## Next steps

Running the notebook will have created a new folder named `models`. In that folder you can find `model.cc` which is a C++ file that contains an array with the quantized weights of the model you created and trained. In the next steps we are going to use that file to infere the model on the Sensortile microcontroller.
