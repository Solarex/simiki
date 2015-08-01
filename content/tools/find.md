---
title: "find"
date: 2014-06-11 23:29
---
+ ``find . \( -name "*.txt" -o -name "*.pdf" \) -print``,``find . -regex  ".*\(\.txt|\.pdf\)$"``, ``-iregex``不区分大小写
+ ``find . ! -name "*.txt" -print``,否定参数 ,查找所有非txt文本
+ ``-atime``,访问时间,单位是天，分钟单位则是``-amin``,``-mtime ``修改时间 （内容被修改）,``-ctime`` 变化时间 （元数据或权限变化）
+ ``find . -type f -perm 644 -print``,``find . -type f -size +2k``,``find . -type f -user weber -print``,``find . -type f -mtime +10 -name "*.txt" -exec cp {} OLD \;``,``find . -type f -user root -exec chown weber {} \; ``
+ ``-print``的定界符默认使用’\n’作为文件的定界符；``-print0`` 使用’\0’作为文件的定界符，这样就可以搜索包含空格的文件；
