---
title: "tcpdump"
date: 2014-11-03 10:46
---
+ 要用tcpdump抓包，请记住，一定要切换到root账户下，因为只有root才有权限将网卡变更为“混杂模式”。
+ -i选项：是interface的含义，是指我们有义务告诉tcpdump希望他去监听哪一个网卡。这在我们一台服务器有多块网卡时很有必要。
+ -nn选项：意思是说当tcpdump遇到协议号或端口号时，不要将这些号码转换成对应的协议名称或端口名称。比如，众所周知21端口是FTP端口，我们希望显示21，而非tcpdump自作聪明的将它显示成FTP。
+ -X选项：告诉tcpdump命令，需要把协议头和包内容都原原本本的显示出来（tcpdump会以16进制和ASCII的形式显示），这在进行协议分析时是绝对的利器。
+ ‘port 53’：这是告诉tcpdump不要看到啥就显示啥。我们只关心源端口或目的端口是53的数据包，其他的数据包别给我显示出来。
+ -c选项：是Count的含义，这设置了我们希望tcpdump帮我们抓几个包。我设置的是1，所以tcpdump不会帮我再多抓哪怕一个包回来。
+ -e选项 - 增加以太网帧头部信息输出
+ -l选项 - 使得输出变为行缓冲
+ -t选项 - 输出时不打印时间戳
+ -v选项 - 输出更详细的信息
+ -F选项 - 指定过滤表达式所在的文件
+ 可以给tcpdump传送“过滤表达式”来起到网络包过滤的作用，而且可以支持传入单个或多个过滤表达式，从这一点来说tcpdump还是很大肚能容的。当你传入的过滤表达式含有shell通配符时，别忘使用单引号把表达式括起来，以防shell自作主张的把含有通配符的表达式先进行了解释和通配。如果你希望自己研究“过滤表达式”，没问题，我会告诉你如何“进门”，方法就是：``man pcap-filter``,你会发现，过滤表达式大体可以分成三种过滤条件，“类型”、“方向”和“协议”，这三种条件的搭配组合就构成了我们的过滤表达式。

```bash
# tcpdump -i eth0 -c 10 'udp' 我只想抓UDP的包，不想被TCP的包打扰
# tcpdump -i eth0 'dst 8.8.8.8' 我想专门查看这个源机器和那个目的机器之间的网络包，不想被其他无关的机器打扰
# tcpdump -i eth0 -c 3 'dst port 53 or dst port 80' 我只想查目标机器端口是53或80的网络包，其他端口的我不关注
# tcpdump -i eth0 'host roclinux.cn' 我想抓到那些通过eth0网卡的，且来源是roclinux.cn服务器或者目标是roclinux.cn服务器的网络包
#tcpdump -i eth0 'host roclinux.cn and (baidu.com or qiyi.com)' 我想抓通过eth0网卡的，且roclinux.cn和baidu.com之间通讯的网络包，或者，roclinux.cn和qiyi.com之间通讯的网络包
#tcpdump 'port ftp or ftp-data' 我想获取使用ftp端口和ftp数据端口的网络包 在Linux系统中，/etc/services这个文件里面，就存储着所有知名服务和传输层端口的对应关系。这个对应关系是由IANA组织（the Internet Assigned Numbers Authority，互联网数字分配机构）来全权负责的，你可以到这个链接http://www.iana.org/assignments/port-numbers通过Web方式查到。如果你直接把/etc/services里的ftp对应的端口值从21改为了8888，那么tcpdump就会去抓端口含有8888的网络包了。
#tcpdump 'tcp[tcpflags] & tcp-syn != 0 and not dst host qiyi.com'我想获取roclinux.cn和baidu.com之间建立TCP三次握手中第一个网络包，即带有SYN标记位的网络包，另外，目的主机不能是qiyi.com
#tcpdump 'ip[2:2] > 576'打印IP包长超过576字节的网络包
#tcpdump 'ether[0] & 1 = 0 and ip[16] >= 224' 打印广播包或多播包，同时数据链路层不是通过以太网媒介进行的。
```
+ 使用-A选项，则tcpdump只会显示ASCII形式的数据包内容，不会再以十六进制形式显示；
+ 使用-XX选项，则tcpdump会从以太网部分就开始显示网络包内容，而不是仅从网络层协议开始显示。
+ ``tcpdump -D``tcpdump会列出所有可以选择的抓包对象。
+ 如果想查看哪些ICMP包中“目标不可达、主机不可达”的包，请使用这样的过滤表达式：``icmp[0:2]==0x0301``
+ 要提取TCP协议的SYN、ACK、FIN标识字段，语法是：

```bash 
tcp[tcpflags] & tcp-syn
tcp[tcpflags] & tcp-ack
tcp[tcpflags] & tcp-fin
```
+ 要提取TCP协议里的SYN-ACK数据包，不但可以使用上面的方法，也可以直接使用最本质的方法：``tcp[13]==18``
+ 如果要抓取一个区间内的端口，可以使用portrange语法：``tcpdump -i eth0 -nn 'portrange 52-55' -c 1  -XX``
+ 其实我们需要着重讲解的只有一种语法，即proto [ expr : size]，只要掌握了这个语法格式，相信大家就能看懂上面的三个稀奇古怪的表达式了。proto就是protocol的缩写，表示这里要指定的是某种协议的名称，比如ip、tcp、ether。其实proto这个位置，总共可以指定的协议类型有15个之多，包括：ether – 链路层协议,fddi – 链路层协议,tr – 链路层协议,wlan – 链路层协议,ppp – 链路层协议,slip – 链路层协议,link – 链路层协议,ip,arp,rarp,tcp,udp,icmp,ip6,radio.expr用来指定数据报偏移量，表示从某个协议的数据报的第多少位开始提取内容，默认的起始位置是0；而size表示从偏移量的位置开始提取多少个字节，可以设置为1、2、4。如果只设置了expr，而没有设置size，则默认提取1个字节。比如ip[2:2]，就表示提取出第3、4个字节；而ip[0]则表示提取ip协议头的第一个字节。在我们提取了特定内容之后，我们就需要设置我们的过滤条件了，我们可用的“比较操作符”包括：>，<，>=，<=，=，!=，总共有6个。好，掌握了上面内容之后，我可以很负责任的告诉你，你已经掌握了tcpdump过滤表达式的最重要语法了。我们先来小试牛刀，看一个例题：``ip[0] & 0xf != 5``IP协议的第0-4位，表示IP版本号，可以是IPv4（值为0100）或者IPv6（0110）；第5-8位表示首部长度，单位是“4字节”，如果首部长度为默认的20字节的话，此值应为5，即”0101″。ip[0]则是取这两个域的合体。0xf中的0x表示十六进制，f是十六进制数，转换成8位的二进制数是“0000 1111”。而5是一个十进制数，它转换成8位二进制数为”0000 0101″。有了上面这些分析，大家应该可以很清楚的知道，这个语句中!=的左侧部分就是提取IP包首部长度域，如果首部长度不等于5，就满足过滤条件。言下之意也就是说，要求IP包的首部中含有可选字段。大家可能已经有所体会，在写过滤表达式时，你需要把协议格式完全背在脑子里，才能把表达式写对。可这对大多数人来说，可能有些困难。为了让tcpdump工具更人性化一些，有一些常用的偏移量，可以通过一些名称来代替，比如icmptype表示ICMP协议的类型域、icmpcode表示ICMP的code域，tcpflags则表示TCP协议的标志字段域。更进一步的，对于ICMP的类型域，可以用这些名称具体指代：icmp-echoreply, icmp-unreach, icmp-sourcequench, icmp-redirect, icmp-echo, icmp-routeradvert, icmp-routersolicit, icmp-timxceed, icmp-paramprob, icmp-tstamp, icmp-tstampreply, icmp-ireq, icmp-ireqreply, icmp-maskreq, icmp-maskreply。而对于TCP协议的标志字段域，则可以细分为tcp-fin, tcp-syn, tcp-rst, tcp-push, tcp-ack, tcp-urg。如果一个过滤表达式有多个过滤条件，那么就需要使用逻辑符了，其中，!或not都可以表示“否定”，&&与and都可以表示“与”，而||与or都可以表示“或”。
