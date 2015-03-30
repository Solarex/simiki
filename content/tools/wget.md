---
title: "wget"
date: 2014-06-11 23:49
---
+ ``wget -m -k -x http://examples.com``
+ ``wget -c http://examples.com/package.iso`` 断点续传
+ ``wget -i download.lst`` 批量下载
+ ``wget -m -k -H http://examples.com`` 镜像一个网站,若图片资源在别的站点,可以使用``-H``选项
+ ``wget -r -np -nd  http://example.com/ubuntu/packages`` 下载制定目录中所有文件,``-np``不遍历父目录,``-nd``不在本机重新创建目录结构
+ ``wget -r -np -nd --accept=iso,zip http://example.com/ubuntu/packages``仅下载制定目录下制定扩展名的文件,可以制定多个扩展名,用逗号分开即可
