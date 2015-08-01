---
title: "sed&awk"
date: 2014-06-11 23:51
---
+ ``sed 's/text/replace_text/' file``   //替换每一行的第一处匹配的text
+ ``sed 's/text/replace_text/g' file``,``sed -i 's/text/repalce_text/g' file``
+ ``sed '/^$/d' file``,移除空白行
+ ``$>echo this is en example | sed 's/\w+/[&]/g' $>[this]  [is] [en] [example]``已匹配的字符串通过标记&来引用.
+ ``sed 's/hello\([0-9]\)/\1/'``第一个匹配的括号内容使用标记 1 来引用
+ ``sed 's/$var/HLLOE/'``sed通常用单引号来引用,也可使用双引号，使用双引号后，双引号会对表达式求值:

```bash
p=patten
r=replaced
echo "line con a patten" | sed "s/$p/$r/g"
$>line con a replaced
```
+ 字符串插入字符：将文本中每行内容（ABCDEF） 转换为 ABC/DEF ``sed 's/^.\{3\}/&\//g' file``
+ awk脚本结构,``awk ' BEGIN{ statements } statements2 END{ statements } '``执行begin中语句块；从文件或stdin中读入一行，然后执行statements2，重复这个过程，直到文件全部被读取完毕；执行end语句块；
+ 使用不带参数的print时，会打印当前行``echo -e "line1\nline2" | awk 'BEGIN{print "start"} {print } END{ print "End" }'``
+ NR:表示记录数量，在执行过程中对应当前行号；NF:表示字段数量，在执行过程总对应当前行的字段数；$0:这个变量包含执行过程中当前行的文本内容；$1:第一个字段的文本内容；$2:第二个字段的文本内容；
+ 打印每一行的第二和第三个字段 ``awk '{print $2, $3}' file``，统计文件的行数，``awk ' END {print NR}' file``,累加每一行的第一个字段``echo -e "1\n 2\n 3\n 4\n" | awk 'BEGIN{num = 0 ;print "begin";} {sum += $1;} END {print "=="; print sum }'``
+ 用样式对awk处理的行进行过滤

```bash
awk 'NR < 5' #行号小于5
awk 'NR==1,NR==4 {print}' file #行号等于1和4的打印出来
awk '/linux/' #包含linux文本的行（可以用正则表达式来指定，超级强大）
awk '!/linux/' #不包含linux文本的行
```

+ 设置定界符,使用-F来设置定界符（默认为空格）:``awk -F: '{print $NF}' /etc/passwd``
+ 使用getline，将外部shell命令的输出读入到变量cmdout中:``echo | awk '{"grep root /etc/passwd" | getline cmdout; print cmdout }'``
+ 在awk中使用循环

```bash
for(i=0;i<10;i++){print $i;}
for(i in array){print array[i];}
```

+ 以逆序的形式打印行：(tac命令的实现）:

```bash
seq 9| \
awk '{lifo[NR] = $0; lno=NR} \
END{ for(;lno>-1;lno--){print lifo[lno];}
} '
```

+ awk结合grep找到指定的服务，然后将其kill掉``ps -fe| grep msv8 | grep -v MFORWARD | awk '{print $2}' | xargs kill -9;``
+ awk实现head、tail命令,head,``awk 'NR<=10{print}' filename``,tail,``awk '{buffer[NR%10] = $0;} END{for(i=0;i<11;i++){ print buffer[i %10]} } ' filename``
+ 打印指定列``ls -lrt | awk '{print $6}'``,``ls -lrt | cut -f6``
+ 打印处于``start_pattern`` 和``end_pattern``之间的文本:``awk '/start_pattern/, /end_pattern/' filename``,``seq 100 | awk '/13/,/15/'``,``cat /etc/passwd| awk '/mai.*mail/,/news.*news/'``
+ awk常用内建函数,index(string,search_string):返回search_string在string中出现的位置,sub(regex,replacement_str,string):将正则匹配到的第一处内容替换为replacement_str;,match(regex,string):检查正则表达式是否能够匹配字符串；length(string)：返回字符串长度

+ 迭代文件中的每一行

```bash
while read line;
do
echo $line;
done < file.txt

改成子shell:
cat file.txt | (while read line;do echo $line;done)
改写成awk:
cat file.txt| awk '{print}'
```

+ 迭代每一个字符

```bash
${string:start_pos:num_of_chars}：从字符串中提取一个字符；(bash文本切片）

${#word}:返回变量word的长度

for((i=0;i<${#word};i++))
do
echo ${word:i:1);
done

以ASCII字符显示文件:

$od -c filename
```