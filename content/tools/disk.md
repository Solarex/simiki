---
title: "disk"
date: 2015-07-08 09:43
---
+ 查看磁盘空间利用大小:``df -h``,-h: human缩写，以易读的方式显示结果（即带单位：比如M/G，如果不加这个参数，显示的数字以B为单位）

+ 查看当前目录所占空间大小:``du -sh``

+ 查看当前目录下所有子文件夹排序后的大小


```bash
for i in `ls`;do du -sh $i ; done | sort
du -sh `ls` | sort
```

+ 用tar实现文件夹同步，排除部分文件不同步:``tar --exclude '*.svn' -cvf - /path/to/source | ( cd /path/to/target; tar -xf -)``
