---
title: "Vim"
date: 2014-06-11 23:52
---
+ ``:%s/old/new/gc``,``:1,$s/old/new/gc``,``:10,100s/old/new/gc``

+ ``:g/pattern/s/old/new/g``,:g会影响文件的每一行,末尾的g表示会影响一行中的每个模式,第一个g表示命令对文件中所有行起作用,pattern用于识别发生替换的行,遇到包含pattern的行,ex将old替换成new,最后的g表示在那一行中对每一个匹配模式进行替换,若用于搜索的模式和要进行替换的模式相同,不必重复输入``:g/pattern/s//new/g``

+ ``g/pattern/d``满足搜索模式的行删除

+ ex命令``d``(delete),``m``(move),``co/t``(copy)

+ ``:3,18d``,``:20,30m43``讲20-30行移动到43行之后,``:20,30co100``(``:20,30t100``)将20-30行复制到100行后

+ ``:=``列出文件总行数,``:.=``列出当前行行号,``:/pattern/=``列出pattern第一次出现时的行号

+ ``:.,$d``,``:20,.m$``,``:%d``,``%t$``,``.,.+20d``删除当前行和从当前行到20行之间的文本

+ ``22,$m.-2``将22行到末尾的行移动到当前行两行之前

+ ``.,+20#``显示行号

+ ``-,+t0``复制3行(光标上面一行到光标下面一行)到文件开头

+ 搜索模式

  + ``:/pattern/d``

  + ``:/pattern/+d``删除下一个包含pattern的行的下一行

  + ``:/pattern1/,/pattern2/d``从第一个包含pattern1的行删除到第一个包含pattern2的行

  + ``.,/pattern/m23``从当前行到第一个包含pattern的行之间的文本放到23行之后

  + ``:100;+5p``用分好代替逗号时,第一个行地址会被当做光标当前地址

  + ``:/pattern/;+10p``显示出包含制定模式的下一行以及后续的10行

  + ``:g/pattern/p``

  + ``:20,30g/pattern/p``

+ 合并ex命令,``1,3d|s/their/they/``删除第一行到第三行,并在当前行做替换,即原来的第4行,``1,5m10|g/pattern/nu``讲第一行到第五行移动到10行之后,接着显示所有包含pattern的行,包括行号

+ ``set wrapmargin,ignorecase,wrapscan,magic,autoindent,showmatch,tabstop,shiftwidth,number,list/autowrite``

+ ``ab hi hello``hi是hello的缩写,``unab hi``

+ ``od -c``按下特殊符号后查看功能键内容

+ ``zA,zC,zD,z0``折叠命令``:set foldenable,:set foldmethod=syntax``

+ ``:tabnew filename, :tabclose, :tabonly``

+ ``:syntax enable, :syntax on, :set syntax=sh``

+ ``:coloscheme desert``

+ ``:highlight comment, :highlight identifier, :highlight identifiers guifg=red``

+ ``set runtimepath+=~/.vim/after/syntax``
