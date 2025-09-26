# Corne EEC (Corne Extended Electrostatic Capacitive)

A Corne-based electrostatic capacitive (EC) keyboard featuring a number row and one additional thumb key.

> [!WARNING]
> I am not an electrical engineer. PCB design may not be optimized and could contain bugs. Use this project at your own risk.

![rendering.png](img/rendering.png)
![keyboard_img](img/right_keyboard.jpg)

## Features
* Corne-like design with a number row and 4 thumb keys, totaling 28 keys per half.
* Onboard STM32G431KBT6 MCU and USB-C with ESD protection.
* No through-hole components.
* ~~Extra PCB connectivity via a 1x06 FFC connector~~ **Rev2's FFC connector located upside down.**

## Firmware

The Rust-based firmware is hosted in a separate repository: [daehyeok/corne-eec-rs](https://github.com/daehyeok/corne-eec-rs).

## Credit

# Credit & Reference.

* [tomsmalley/custom-topre-guide](https://github.com/tomsmalley/custom-topre-guide): An invaluable resource for understanding custom Topre-style keyboards.
* [Cipulot](https://github.com/Cipulot)'s multiple PCB and firmware projects: A great source of inspiration for keyboard hardware and firmware development.
*  This project is forked from [Cipulot/CorneECRevival](https://github.com/Cipulot/CorneECRevival).

## Copyright

This project is released under the MIT License. Refer to the `LICENCE.md` file for details.
