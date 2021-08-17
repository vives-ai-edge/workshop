# Hello World Example

Source: TinyML (Machine Learning with TensorFlow Lite on Arduino and Ultra-Low-Power Microcontrollers) by Pete Warden & Daniel Situnayake

## Goal
We want to calculate the sine of x and use its output to control the timing of a flashing LED on our microcontroller.
Instead of using mathematic functions to calculate the sine of x we can train a model that takes x (going from 0 to 2&pi;) and outputs the corresponding sine value (which lays between -1 and 1).

## Steps
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
6. Deploy to a Microcontroller
