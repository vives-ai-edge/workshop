# AI@EDGE Workshop

Course materials for AI@EDGE workshop.

## Raspberry Pi OS image

This workshop is optimised to run on a [Raspberry Pi 400](https://www.raspberrypi.com/products/raspberry-pi-400/) or any other [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) device.
Make sure to install the 64-bit Raspberry OS (Buster version from 2021.05.07).
The image can be downloaded [here](https://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2021-05-28/2021-05-07-raspios-buster-arm64.zip).
Use [Raspberry Pi Imager](https://www.raspberrypi.com/software/), [Win32DiskImager](https://sourceforge.net/projects/win32diskimager/) or [BalenaEtcher](https://www.balena.io/etcher/) to flash the SD card.
Change the keyboard layout to your preference, in the workshop case: `French` (azerty).

## Install software packages

Setup script to install all requirements and dependencies to do the AI@EDGE workshop. Make sure you have an internet connection when doing this!

```shell
bash <(curl -sL ai-edge-workshop.netlify.app/setup.sh)
```

:::warning Installing all prerequisites can take a long time
Some parts of the script can take quite a while (installation of `setup.py` `bdist_wheel` of `h5py`, `numpy`, etc) to install. The setup may take up to 1 to 2 hours to complete, depending on your system.
:::

:::danger Possible errors

When running the setup script it is possible that there are some errors and warnings indicated by red text. This is normal due to compatibility issues with the current Raspberry Pi OS. Fortunately we don't need those dependencies for the examples in the workshop and these errors can be **ignored**.

:::

## Hardware requirements

Necessary hardware to do the workshop:

- [Raspberry Pi 4](https://www.raspberrypi.com/products/raspberry-pi-4-model-b/) or [Raspberry Pi 400](https://www.raspberrypi.com/products/raspberry-pi-400/) with Screen, Mouse, Keyboard, SD card with the correct OS. Only [Raspbian buster 64 bit](http://downloads.raspberrypi.org/raspios_arm64/images/raspios_arm64-2021-05-28/) is supported.
- [Nucleo-L476RG](https://www.st.com/en/evaluation-tools/nucleo-l476rg.html) or any other STM board with [programmer](https://www.st.com/en/development-tools/st-link-v2.html) and USB cable
- [STM Sensortile](https://www.st.com/en/evaluation-tools/steval-stlkt01v1.html) with programming cable, cradle, USB cable
- Mounting system to mount the Sensortile to a pen ([3D printed holder](https://github.com/vives-ai-edge/AB-writing-cradle))

![Workshop hardware setup](../img/workshop_setup.jpg)

## Project files

All project files can be found in the repository of the AI@EDGE workshop. The files are cloned in the "Documents" directory when running the installation script.

## Getting started

We are getting started with a small example which goes through all the steps from data creation to running your model on a microcontroller in the [introduction](/01-hello-world/01-introduction/).

## Issues

Feel free to submit issues and enhancement requests.

## Contributing

Please refer to each project's style and contribution guidelines for submitting patches and additions. In general, we follow the "fork-and-pull" Git workflow.

 1. **Fork** the repo on GitHub
 2. **Clone** the project to your own machine
 3. **Commit** changes to your own branch
 4. **Push** your work back up to your fork
 5. Submit a **Pull request** so that we can review your changes

NOTE: Be sure to merge the latest from "upstream" before making a pull request!

## License

This work is licensed under a
[Creative Commons Attribution-ShareAlike 4.0 International License][cc-by-sa].

[![CC BY-SA 4.0][cc-by-sa-image]][cc-by-sa]

[cc-by-sa]: http://creativecommons.org/licenses/by-sa/4.0/
[cc-by-sa-image]: https://licensebuttons.net/l/by-sa/4.0/88x31.png
