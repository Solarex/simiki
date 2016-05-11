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
+ [install old version android build tools/tools/platform tools](http://stackoverflow.com/questions/26016770/how-to-install-old-version-of-android-build-tools-from-command-line),``android list sdk --all``,``android update sdk -u -a -t [NO_OF_ITEM_TO_BE_INSTALLED]``,Example: if I wanted to install andorid sdk build tools revision 23.0.1, I would type in:``android update sdk -u -a -t 7``,``-u (--no-ui)  # Headless mode, -a (--all)    # Includes all packages, included the obsolete ones, -t (--filter) # in this example we have filtered by package index, i.e. 5 ``
+ ``mksdcard -l <label> <size> <file>``
+ ``android move avd -n <name> [-<option> <value>] ...``,move or rename an AVD
+ ``android update avd -n <name>``
+ ``android delete avd -n <name>``
+ ``emulator -avd <avd_name> [<options>]``,eg,``emulator -avd WVGA800 -scale 96dpi -dpi-device 160``,``emulator -avd <avd_name>  -wipe-data``
+ ``adb shell service list``
+ ``adb shell dumpsys activity/cpuinfo/battery``
+ ``adb shell dumpsys | grep "DUMP OF SERVICE"``
+ ``adb shell dumpsys window -h``,``adb shell dumpsys activity -h``,``adb shell dumpsys meminfo -h``,``adb shell dumpsys package -h``,``adb shell dumpsys batteryinfo -h``

### Using Emulator ###
