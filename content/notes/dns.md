---
title: "dns"
date: 2016-07-21 23:26
---
#DNS

+ [DNS 原理入门](http://www.ruanyifeng.com/blog/2016/06/dns.html)
+ 主机名.次级域名.顶级域名.根域名 即 host.sld.tld.root,host.second-level-domain.top-level-domain.root
+ DNS服务器根据域名的层级，进行分级查询。需要明确的是，每一级域名都有自己的NS记录，NS记录指向该级域名的域名服务器。这些服务器知道下一级域名的各种记录。所谓"分级查询"，就是从根域名开始，依次查询每一级域名的NS记录，直到查到最终的IP地址，过程大致如下。
  + 从"根域名服务器"查到"顶级域名服务器"的NS记录和A记录（IP地址）
  + 从"顶级域名服务器"查到"次级域名服务器"的NS记录和A记录（IP地址）
  + 从"次级域名服务器"查出"主机名"的IP地址
+ "根域名服务器"的NS记录和IP地址一般是不会变化的，所以内置在DNS服务器里面。目前，世界上一共有十三组根域名服务器，从A.ROOT-SERVERS.NET一直到M.ROOT-SERVERS.NET。

```bash
$ dig +trace math.stackexchange.com

; <<>> DiG 9.8.3-P1 <<>> +trace math.stackexchange.com
;; global options: +cmd
.			45647	IN	NS	d.root-servers.net.
.			45647	IN	NS	i.root-servers.net.
.			45647	IN	NS	f.root-servers.net.
.			45647	IN	NS	m.root-servers.net.
.			45647	IN	NS	e.root-servers.net.
.			45647	IN	NS	j.root-servers.net.
.			45647	IN	NS	g.root-servers.net.
.			45647	IN	NS	l.root-servers.net.
.			45647	IN	NS	b.root-servers.net.
.			45647	IN	NS	c.root-servers.net.
.			45647	IN	NS	k.root-servers.net.
.			45647	IN	NS	h.root-servers.net.
.			45647	IN	NS	a.root-servers.net.
;; Received 228 bytes from 192.168.31.1#53(192.168.31.1) in 129 ms

com.			172800	IN	NS	g.gtld-servers.net.
com.			172800	IN	NS	b.gtld-servers.net.
com.			172800	IN	NS	h.gtld-servers.net.
com.			172800	IN	NS	m.gtld-servers.net.
com.			172800	IN	NS	a.gtld-servers.net.
com.			172800	IN	NS	k.gtld-servers.net.
com.			172800	IN	NS	e.gtld-servers.net.
com.			172800	IN	NS	l.gtld-servers.net.
com.			172800	IN	NS	i.gtld-servers.net.
com.			172800	IN	NS	f.gtld-servers.net.
com.			172800	IN	NS	j.gtld-servers.net.
com.			172800	IN	NS	d.gtld-servers.net.
com.			172800	IN	NS	c.gtld-servers.net.
;; Received 500 bytes from 202.12.27.33#53(202.12.27.33) in 291 ms

stackexchange.com.	172800	IN	NS	ns-463.awsdns-57.com.
stackexchange.com.	172800	IN	NS	ns-925.awsdns-51.net.
stackexchange.com.	172800	IN	NS	ns-1029.awsdns-00.org.
stackexchange.com.	172800	IN	NS	ns-1832.awsdns-37.co.uk.
;; Received 209 bytes from 192.55.83.30#53(192.55.83.30) in 595 ms

math.stackexchange.com.	300	IN	A	151.101.193.69
math.stackexchange.com.	300	IN	A	151.101.129.69
math.stackexchange.com.	300	IN	A	151.101.65.69
math.stackexchange.com.	300	IN	A	151.101.1.69
stackexchange.com.	172800	IN	NS	ns-1029.awsdns-00.org.
stackexchange.com.	172800	IN	NS	ns-1832.awsdns-37.co.uk.
stackexchange.com.	172800	IN	NS	ns-463.awsdns-57.com.
stackexchange.com.	172800	IN	NS	ns-925.awsdns-51.net.
;; Received 241 bytes from 205.251.199.40#53(205.251.199.40) in 371 ms
```

+ DNS的记录类型
  + A：地址记录（Address），返回域名指向的IP地址。
  + NS：域名服务器记录（Name Server），返回保存下一级域名信息的服务器地址。该记录只能设置为域名，不能设置为IP地址。
  + MX：邮件记录（Mail eXchange），返回接收电子邮件的服务器地址。
  + CNAME：规范名称记录（Canonical Name），返回另一个域名，即当前查询的域名是另一个域名的跳转，详见下文。
  + PTR：逆向查询记录（Pointer Record），只用于从IP地址查询域名，详见下文。
+ 由于CNAME记录就是一个替换，所以域名一旦设置CNAME记录以后，就不能再设置其他记录了（比如A记录和MX记录），这是为了防止产生冲突。举例来说，foo.com指向bar.com，而两个域名各有自己的MX记录，如果两者不一致，就会产生问题。由于顶级域名通常要设置MX记录，所以一般不允许用户对顶级域名设置CNAME记录。

+ PTR记录用于从IP地址反查域名。dig命令的-x参数用于查询PTR记录。
+ host命令可以看作dig命令的简化版本，返回当前请求域名的各种记录。host命令也可以用于逆向查询，即从IP地址查询域名，等同于dig -x <ip>。
+ nslookup命令用于互动式地查询域名记录。
+ whois命令用来查看域名的注册情况。
