---
title: "android"
date: 2014-06-18 04:43
---
## android ##
+ ``android list target``
+ ``android create project --target <target-id> --name MyFirstApp 
--path <path-to-workspace>/MyFirstApp --activity MainActivity 
--package com.example.myfirstapp``
+ ``ant debug``,``adb install bin/MyFirstApp-debug.apk``
+ ``android create avd -n <name> -t <targetID> -p path/to/my/avd -c <size>[K|M] [-<option> <value>] ... ``
+ ``mksdcard -l <label> <size> <file>``
+ ``android move avd -n <name> [-<option> <value>] ...``,move or rename an AVD
+ ``android update avd -n <name>``
+ ``android delete avd -n <name>``
+ ``emulator -avd <avd_name> [<options>]``,eg,``emulator -avd WVGA800 -scale 96dpi -dpi-device 160``,``emulator -avd <avd_name>  -wipe-data``

### Using Emulator ###
