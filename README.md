# Corne EEC (Corne Extended Electrostatic Capacitive)
 Corne based EC keyboard with number row and one additional thumb key.
 
 **I'm not electrical engineer. Use this project at your own risk.**
 
## Features
* Corne like design, but have number row and 4 thumb keys. Total 28 keys on each halves.
* Onboard STM32G0B1KET MCU, USB-C with ESD protection
* No 0402-sized or smaller SMD(Except optional SOD-323 sized ESD chip, It's stil not diffcult to hand soldering).
* Extra PCB can be connected through 1x10 FFC connector(0.5mm pitch. 8 GPIO with 3.3v power line). I will add encoder and LCD display later.

## Firmware (WIP)

 The Rust-based firmware will be released in a different repository.
 I'm not interested in using QMK. but STM32G0B1 may be compatible with QMK.

## Credit
 This project forked from [Cipulot/CorneECRevival](https://github.com/Cipulot/CorneECRevival).
 
 Design and selecting component based on [Cipulot](https://github.com/Cipulot)'s awesome works. 
 He released multiple EC keyboard PCBs, including popular layouts such as HHKB, EC60, and Corne.
 If you need a reference for designing your own board, Check his repos.
 

## Copyright

This project is released under the MIT License. For the license, please refer to the LICENCE.md file.
