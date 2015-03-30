---
title: "mplayer"
date: 2014-10-01 11:13
---
+ mplayer
  + ``m`` mute
  + ``b,j`` 切换字幕
  + ``f`` fullscreen
  + ``p``或者``space`` pause
  + ``mplayer -playlist music.lst``
  + ``mplayer -cache 8192 -playlist <file or url>``
  + ``mplayer -loop 3 <somefile>``
  + ``mplayer -loop 0 <somefile>`` 循环播放
  + ``mplayer -speed 2.0 <somefile>``快速播放
  + ``mplayer -vo jpeg <somefile>`` 将视频输出为一系列图片
  + ``mplayer -ao pcm:file=<audioname>.wav <somefile>``提取音频
  + ``~/.mplayer/config``,``/etc/mplayer/config``
  + 使用ASCII方式查看视频,有两个库支持该特性:``aa``,``caca``.``aa``只能是黑白,``libcaca``支持彩色``mplayer -vo aa <somefile>``,``mplayer -vo caca <somefile>``

