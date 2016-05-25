---
title: "httpry"
date: 2014-11-03 09:35
---
+ 数据包嗅工具tcpdump被广泛用于实时数据包的导出，但是你需要设置过滤规则来捕获HTTP流量，甚至它的原始输出通常不能方便的停在HTTP协议层。

+ httpry捕获HTTP数据包，并且将HTTP协议层的数据内容以可读形式列举出来。

+ ``sudo httpry -i <network-interface>``httpry就会监听指定的网络接口，并且实时的显示捕获到的HTTP请求/相应。

+ 在大多数情况下，由于发送与接到的数据包过多导致刷屏很快，难以分析。这时候你肯定想将捕获到的数据包保存下来以便离线分析。可以使用'b'或'-o'选项保存数据包。'-b'选项将数据包以二进制文件的形式保存下来，这样可以使用httpry软件打开文件以浏览。另一方面，'-o'选项将数据以可读的字符文件形式保存下来。``sudo httpry -i eth0 -b output.dump``以二进制形式保存文件,``httpry -r output.dump``浏览所保存的HTTP数据包文件,``sudo httpry -i eth0 -o output.txt``将httpry数据以字符文件保存

+ 如果你想监视指定的HTTP方法（如：GET，POST，PUT，HEAD，CONNECT等），使用'-m'选项：``sudo httpry -i eth0 -m get,head``

+ 如果你下载了httpry的源码，你会发现源码下有一些Perl脚本，这些脚本用于分析httpry输出。脚本位于目录httpry/scripts/plugins。如果你想写一个定制的httpry输出分析器，则这些脚可以作为很好的例子。其中一些有如下的功能：hostnames: 显示唯一主机名列表,find_proxies: 探测web代理,search_terms: 查找及统计在搜索服务里面的搜索词,content_analysis: 查找含有指定关键的URL,xml_output: 将输出转换为XML形式,log_summary: 生成日志汇总,db_dump: 将日志文件数据保存数据库。

+ 在使用这些脚本之前，首先使用'-o'选项运行httpry。当获取到输出文件后，立即使用如下命令执行脚本：``cd httpry/scripts && perl parse_log.pl -d ./plugins <httpry-output-file>``

+ [REF](http://xmodulo.com/2014/08/sniff-http-traffic-command-line-linux.html)
