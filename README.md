# CorneECRevival

 Revival project of the Corne ECWL.

![Corneecrevival](https://github.com/Cipulot/CorneECRevival/blob/main/Docs/images/corne_hold.jpg?raw=true)

## Introduction

The Corne EC Revival is my personal effort to revive the original Corne ECWL by [sekigon-gonnoc](https://github.com/sekigon-gonnoc).

It boosts full compatibility with the original boards sold by gonnoc while also providing updated QMK support for the latest stable release and a modified set of plates and pcbs, making it compatible with "standard" Corne accessories.

## PCB and Plate

Contrary to the standard Corne, the Corne EC Revival PCBs are not interchangable between left and right half. Plates on the other hand can be used on both sides.

In the [PCB folder](https://github.com/Cipulot/CorneECRevival/blob/main/PCB) there are all the PCB and plate design files. gerber files are in the [Production folder](https://github.com/Cipulot/CorneECRevival/blob/main/Production).

The naming scheme reflects the mounting system supported:

* `OG_mounting_[partname]` supports "standard" Corne mounting points
* `[partname]` supports the original Corne ECWL mounting points

Furthermore, to allow for a greater support, both NIZ and Topre housing plates are available for both mounting point configurations.

To see images and further description of the PCB refer to the dedicated section in the Notion build log [here](https://cipulot.notion.site/PCB-Design-9a60de99e9044c61900d82e630ff782b).

## Production files

Gerber files are provided for all the pcbs of the project. BOM is also available to use. Placement files are WIP.

The prototypes were produced by JLC, therefore pretty much any PCB manufacturer can handle production without any problems.

## Firmware

The firmware folder contains 2 versions of the code based on different QMK releases:

* `EC Revival` based on the latest QMK stable
* `Original ECWL` based on gonnoc's fork, running on an older QMK branch

Both have precompiled `*.hex` files based on the code in their respective folders to easily get the board up and running.

## Copyright notice

This project is released under the MIT License. For the license, please refer to the LICENCE.md file.

