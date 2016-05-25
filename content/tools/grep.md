---
title: "grep"
date: 2014-06-11 23:51
---
+ ``grep -e "class" -e "vitural" file``,匹配多个模式

+ 工程目录中utf-8格式和gb2312格式两种文件，要查找字的是中文,查找到中文的utf-8编码和gb2312编码分别是E4B8ADE69687和D6D0CEC4，``grep -rnP "\xE4\xB8\xAD\xE6\x96\x87|\xD6\xD0\xCE\xC4" *``,汉字编码查询：http://bm.kdd.cc/
