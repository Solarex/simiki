---
title: "adb"
date: 2014-06-11 23:31
---
##adb
+ ADB是一个通用的命令行工具来供你和Android模拟器或者Android设备交互。ADB是Client/Server架构，包括3个部分。Client，运行在开发机上。可以在shell中运行adb命令来调用它。Server，运行在开发机后台，Server管理Client和运行在模拟器或者Android设备上的adb daemon的通信。Daemon，运行在Android模拟器或者Android设备上的后台程序。
+ When you start an adb client, the client first checks whether there is an adb server process already running. If there isn't, it starts the server process. When the server starts, it binds to local TCP port 5037 and listens for commands sent from adb clients—all adb clients use port 5037 to communicate with the adb server.启动一个adb client时，client首先检查是否有adb server在运行，如果没有就起adb server进程。server进程起来的时候会绑定到5037端口，监听所有从adb client发送过来的命令。The server then sets up connections to all running emulator/device instances. It locates emulator/device instances by scanning odd-numbered ports in the range 5555 to 5585, the range used by emulators/devices. Where the server finds an adb daemon, it sets up a connection to that port. Note that each emulator/device instance acquires a pair of sequential ports — an even-numbered port for console connections and an odd-numbered port for adb connections.adb server通过扫描5555到5585以内的奇数端口来定位Android模拟器和Android设备，然后和它们建立通信。如果adb server在端口中发现了adb daemon，他会建立和那个端口的连接。每个Android模拟器和Android设备需要一对连续的端口，一个偶数端口用来console connection，一个奇数端口用来adb connection。(server与client通信的端口是是5037,adb server会与emulator交互的，使用的端口有两个，一个是5554专门用于与Emulator实例的连接，那么数据可以从Emulator转发给IDE控制台了，另一个则是5555，专门与adb daemon连接为后面调试使用。http://www.cnblogs.com/carmanloneliness/archive/2013/04/16/3023299.html)
+ ``adb emu -s emulator-5554 kill``
## android adb tools help ##
+ ``adb devices``
+ ``adb install test.apk``
+ ``adb uninstall org.solarex.test``
+ ``adb logcat [option] [filter-specs]`` Prints log data to the screen.
+ ``adb bugreport`` Prints ``dumpsys``, ``dumpstate``, and ``logcat`` data to the screen, for the purposes of bug reporting.
+ ``adb jdwp`` Prints a list of available JDWP processes on a given device.You can use the forward ``jdwp:<pid>`` port-forwarding specification to connect to a specific JDWP process. For example:``adb forward tcp:8000 jdwp:472``,``jdb -attach localhost:8000``
+ ``adb pull <remote> <local>``,``adb pull /data/system/packages.xml .``
+ ``adb push <local> <remote>``
+ ``adb forward <local> <remote>``Forwards socket connections from a specified local port to a specified remote port on the emulator/device instance.Port specifications can use these schemes:``tcp:<portnum>``,``local:<UNIX domain socket name>``,``dev:<character device name>``,``jdwp:<pid>``.转发本地端口通信到远程模拟器或者Android设备上的端口。
+ ``adb ppp <tty> [parm]…``Run PPP over USB.``<tty>`` — the tty for PPP stream. For example ``dev:/dev/omap_csmi_ttyl``.``[parm]…`` — zero or more PPP/PPPD options, such as defaultroute, local, notty, etc.Note that you should not automatically start a PPP connection.
+ ``adb get-serialno``
+ ``adb get-state``
+ ``adb wait-for-device``
+ adb shell,Adb provides a Unix shell that you can use to run a variety of commands on an emulator or connected device. The command binaries are stored in the file system of the emulator or device, at ``/system/bin/``.

## adb shell am (ActivityManager) ##

```bash
# am help
usage: am [subcommand] [options]
usage: am start [-D] [-W] [-P <FILE>] [--start-profiler <FILE>] [-S] <INTENT>
am startservice <INTENT>
am force-stop <PACKAGE>
am broadcast <INTENT>
am instrument [-r] [-e <NAME> <VALUE>] [-p <FILE>] [-w]
[--no-window-animation] <COMPONENT>
am profile [looper] start <PROCESS> <FILE>
am profile [looper] stop [<PROCESS>]
am dumpheap [flags] <PROCESS> <FILE>
am monitor [--gdb <port>]
am screen-compat [on|off] <PACKAGE>
am display-size [reset|MxN]

am start: start an Activity.  Options are:
-D: enable debugging
-W: wait for launch to complete
--start-profiler <FILE>: start profiler and send results to <FILE>
-P <FILE>: like above, but profiling stops when app goes idle
-S: force stop the target app before starting the activity

am startservice: start a Service.

am force-stop: force stop everything associated with <PACKAGE>.

am broadcast: send a broadcast Intent.

am instrument: start an Instrumentation.  Typically this target <COMPONENT>
is the form <TEST_PACKAGE>/<RUNNER_CLASS>.  Options are:
-r: print raw results (otherwise decode REPORT_KEY_STREAMRESULT).  Use with
[-e perf true] to generate raw output for performance measurements.
-e <NAME> <VALUE>: set argument <NAME> to <VALUE>.  For test runners a
common form is [-e <testrunner_flag> <value>[,<value>...]].
-p <FILE>: write profiling data to <FILE>
-w: wait for instrumentation to finish before returning.  Required for
test runners.
--no-window-animation: turn off window animations will running.

am profile: start and stop profiler on a process.

am dumpheap: dump the heap of a process.  Options are:
-n: dump native heap instead of managed heap

am monitor: start monitoring for crashes or ANRs.
--gdb: start gdbserv on the given port at crash/ANR

am screen-compat: control screen compatibility mode of <PACKAGE>.

am display-size: override display size.

<INTENT> specifications include these flags and arguments:
[-a <ACTION>] [-d <DATA_URI>] [-t <MIME_TYPE>]
[-c <CATEGORY> [-c <CATEGORY>] ...]
[-e|--es <EXTRA_KEY> <EXTRA_STRING_VALUE> ...]
[--esn <EXTRA_KEY> ...]
[--ez <EXTRA_KEY> <EXTRA_BOOLEAN_VALUE> ...]
[--ei <EXTRA_KEY> <EXTRA_INT_VALUE> ...]
[--el <EXTRA_KEY> <EXTRA_LONG_VALUE> ...]
[--eu <EXTRA_KEY> <EXTRA_URI_VALUE> ...]
[--eia <EXTRA_KEY> <EXTRA_INT_VALUE>[,<EXTRA_INT_VALUE...]]
[--ela <EXTRA_KEY> <EXTRA_LONG_VALUE>[,<EXTRA_LONG_VALUE...]]
[-n <COMPONENT>] [-f <FLAGS>]
[--grant-read-uri-permission] [--grant-write-uri-permission]
[--debug-log-resolution] [--exclude-stopped-packages]
[--include-stopped-packages]
[--activity-brought-to-front] [--activity-clear-top]
[--activity-clear-when-task-reset] [--activity-exclude-from-recents]
[--activity-launched-from-history] [--activity-multiple-task]
[--activity-no-animation] [--activity-no-history]
[--activity-no-user-action] [--activity-previous-is-top]
[--activity-reorder-to-front] [--activity-reset-task-if-needed]
[--activity-single-top] [--activity-clear-task]
[--activity-task-on-home]
[--receiver-registered-only] [--receiver-replace-pending]
[<URI> | <PACKAGE> | <COMPONENT>]

Error: Unknown command: help
```

## adb shell pm (PackageManager) ##

```bash
# pm help
Error: unknown command 'help'
usage: pm list packages [-f] [-d] [-e] [-s] [-e] [-u] [FILTER]
pm list permission-groups
pm list permissions [-g] [-f] [-d] [-u] [GROUP]
pm list instrumentation [-f] [TARGET-PACKAGE]
pm list features
pm list libraries
pm path PACKAGE
pm install [-l] [-r] [-t] [-i INSTALLER_PACKAGE_NAME] [-s] [-f] PATH
pm uninstall [-k] PACKAGE
pm clear PACKAGE
pm enable PACKAGE_OR_COMPONENT
pm disable PACKAGE_OR_COMPONENT
pm disable-user PACKAGE_OR_COMPONENT
pm set-install-location [0/auto] [1/internal] [2/external]
pm get-install-location
pm createUser USER_NAME
pm removeUser USER_ID

pm list packages: prints all packages, optionally only
those whose package name contains the text in FILTER.  Options:
-f: see their associated file.
-d: filter to only show disbled packages.
-e: filter to only show enabled packages.
-s: filter to only show system packages.
-3: filter to only show third party packages.
-u: also include uninstalled packages.

pm list permission-groups: prints all known permission groups.

pm list permissions: prints all known permissions, optionally only
those in GROUP.  Options:
-g: organize by group.
-f: print all information.
-s: short summary.
-d: only list dangerous permissions.
-u: list only the permissions users will see.

pm list instrumentation: use to list all test packages; optionally
supply <TARGET-PACKAGE> to list the test packages for a particular
application.  Options:
-f: list the .apk file for the test package.

pm list features: prints all features of the system.

pm path: print the path to the .apk of the given PACKAGE.

pm install: installs a package to the system.  Options:
-l: install the package with FORWARD_LOCK.
-r: reinstall an exisiting app, keeping its data.
-t: allow test .apks to be installed.
-i: specify the installer package name.
-s: install package on sdcard.
-f: install package on internal flash.

pm uninstall: removes a package from the system. Options:
-k: keep the data and cache directories around after package removal.

pm clear: deletes all data associated with a package.

pm enable, disable, disable-user: these commands change the enabled state
of a given package or component (written as "package/class").

pm get-install-location: returns the current install location.
0 [auto]: Let system decide the best location
1 [internal]: Install on internal device storage
2 [external]: Install on external media

pm set-install-location: changes the default install location.
NOTE: this is only intended for debugging; using this can cause
applications to break and other undersireable behavior.
0 [auto]: Let system decide the best location
1 [internal]: Install on internal device storage
2 [external]: Install on external media
```
