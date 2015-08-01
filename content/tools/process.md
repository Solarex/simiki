---
title: "process"
date: 2015-07-08 09:48
---
+ 任何进程都与文件关联；我们会用到lsof工具（list opened files），作用是列举系统中已经被打开的文件。在linux环境中，任何事物都是文件，设备是文件，目录是文件，甚至sockets也是文件。
+ 查询正在运行的进程信息``ps -ef``,查询归属于用户colin115的进程``ps -ef | grep colin115``或``ps -lu colin115``
+ 查询进程ID（适合只记得部分进程字段）``pgrep 查找进程``
+ 以完整的格式显示所有的进程``ps -ajx``
+ 查看端口占用的进程状态：``lsof -i:3306``
+ 查看用户username的进程所打开的文件``lsof -u username``
+ 查询init进程当前打开的文件``lsof -c init``
+ 查询指定的进程ID(23295)打开的文件``lsof -p 23295``
+ 查询指定目录下被进程开启的文件（使用+D 递归目录）：

```bash
Solarex at MacPro in ~/Workspace/Solarex/simiki on master*
$ lsof +d .
COMMAND   PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
bash    11057 Solarex  cwd    DIR    1,4      374 2069275 .
lsof    12016 Solarex  cwd    DIR    1,4      374 2069275 .
lsof    12017 Solarex  cwd    DIR    1,4      374 2069275 .
Solarex at MacPro in ~/Workspace/Solarex/simiki on master*
$ lsof +D ./
COMMAND     PID    USER   FD   TYPE DEVICE SIZE/OFF    NODE NAME
Sublime    1178 Solarex  cwd    DIR    1,4      748 4919490 ./content/tools
bash      11057 Solarex  cwd    DIR    1,4      374 2069275 .
lsof      12034 Solarex  cwd    DIR    1,4      374 2069275 .
lsof      12035 Solarex  cwd    DIR    1,4      374 2069275 .
```

+ ``kill PID``,``kill -9 PID``,``kill %job``杀死job工作
+ 使用命令pmap，来输出进程内存的状况，可以用来分析线程堆栈；``pmap PID``
+ 将用户colin115下的所有进程名以av_开头的进程终止:``ps -u colin115 |  awk '/av_/ {print "kill -9 " $1}' | sh``
+ 将用户colin115下所有进程名中包含HOST的进程终止:``ps -fe| grep colin115|grep HOST |awk '{print $2}' | xargs kill -9;``
+ ``ldd``在mac上有``otool -L <object file>``对应，``pmap pid``有``vmmap <pid>``对应
