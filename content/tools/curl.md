---
title: "curl"
date: 2014-06-11 23:49
---
## cURL ##
- http://curl.haxx.se/
- HTTP1.1支持7种请求方法：GET、POST、HEAD、OPTIONS、PUT、DELETE和TARCE。而服务器也可以自定义请求命令供客户端使用。具体请参考HTTP的RFC文档。
- HTTP 请求行(Request Line)
    - GET主要用于取得URL指定的资源信息，也可用来提交表单。GET提交的信息实际上是附加在url之后作为URL的一部分。
    - POST主要用于提交表单，尤其是提交大批量的表单数据。POST方法克服了GET方法的一些缺点。通过POST方法提交表单数据时，数据不是作为URL请求的一部分而是作为标准数据传送给Web服务器，这就克服了GET方法中的信息无法加密和数据量太小的缺点。
- HTTP 请求头(Request Header)
    - HTTP请求头中主要包含关于请求本身或者客户端的有用信息，比如浏览器的类型、浏览器语言、编码、压缩算法等信息。服务器上的动态脚本如PHP等可以利用请求头信息生成动态的网页内容。最常用的是``User-Agent``字段和``Referer``字段，分别用于指定客户端类型和来源页面。最末行额外多出的一对``\r\n``表示一个空白行，此空白行表示HTTP请求头结束，以下部分为请求正文。
- HTTP请求正文(Message Body)
    - HTTP请求正文经常为空，除非需要向服务端提交信息，如在使用POST向网站提交表单的时候。
- HTTP响应行(Response Status Line)
    - 响应行以服务端使用的HTTP协议版本号开始，后加响应状态码，表示请求结果状态，如``HTTP/1.1 200 OK``。
- HTTP响应头(Response Header)
    - 响应头与请求头十分相似，也是由几行“属性:值”对组成。其中包含关于服务器的有用信息、响应数据等。
- HTTP响应正文(Message Body)
    - 如果请求成功，响应正文中将包含请求的数据，如图片文件的二进制数据、HTML文件等。一旦响应正文传输完毕，服务端又没有使用HTTP 1.1版本的Keep-Alive请求，HTTP连接将会断开。
- Cookie
    - Cookie是服务器为了辨别用户身份、进行session跟踪用户识别，而储存在客户端的数据。用以判断在HTTP传输中的状态，从而弥补HTTP协议无状态的缺陷。当客户端向服务端发起请求时，浏览器会自动将cookie信息添加在HTTP请求头中。
- curl [options] [URL...]
    - ``-o/--output <file>`` 保存网页到文件
    - ``-s/--silent``静默模式，不打印进度条信息。
    - ``-v/--verbose``查看通信过程，调试。更详细的调试信息可以使用``--trace-ascii``选项。
    - ``-A/--user-agent``指定User-Agent字段。如果一个网站对浏览器的限制也很严格的话，那我们甚至可以通过修改User-Agent伪装成百度蜘蛛或者googlebot突破限制，因为基于SEO的考虑，网站对搜索引擎蜘蛛的限制很小。
    - ``-e/--referer <URL>``设置Referer,指定HTTP请求头中的Referer字段，即来源网页。为了防盗链，很多网页尤其是图片等可下载资源会检测Referer字段，对于非自己站内的来源全部屏蔽掉，此时我们就需要这个参数。
    - ``-D/--dump-header <file>``保存协议头信息，头部信息中包含最常使用的cookie信息。
    - ``-b/--cookie <name=data>/<file>``指定cookie，``-b``后可直接加``-D``保存的文件，curl会自动从中读取出cookie值，而且``-b``选项不会修改此文件。结合``-D``和``-b``参数，即可完成cookie的保存和后续使用。
    - ``-L/--location``自动跟踪重定向。
    - Chrome Developer Tools，Network标签用于显示数据包，对于协议的分析，我们最常用此标签。选中Network标签左下角的“Preserve Log upon Navigation”，此选项的作用在于当当前页面跳转到其他网页时，保存原来的日志记录。默认不保存，比如在登陆成功一个网站后，自动跳转到其他网页，这样登陆网站过程中的记录都不保存。我们就没有办法对登陆过程进行具体分析。Developer Tools的搜索功能搜索不到，可以右键数据包”save all as har“保存为har文件，用记事本打开即可查找。但是不能批量保存，比较繁琐。更简单的解决方式是使用wireshark抓包，wireshark的字符串搜索可以搜索到。
    - ``-d/--data <data>``指定HTTP请求时发送的数据（主要为POST请求），使用和用户通过浏览器提交表单时一样的方式。使用的``content-type``是``application/x-www-form-urlencoded``。相当于``--data-ascii``。发送纯粹二进制的数据（data purely binary），需要使用``--data-binary``。URL-encode编码要发送的数据，需要使用``--data-urlencode``。当有多个``-d``时，curl会自动将发送的数据段是用“&”符号拼接，如：``-d name=Adeploy -d age=100``将自动拼接为``name=Adeploy&age=100``作为post数据块（post chunk）发送。如果想指定文件中的内容，可以使用``-d @filename``的形式。如文件foobar中内容为``name=Adeploy``，使用``-d @foobar``即可达到``-d name=Adeploy``一样的效果（只有第一个=作为特殊字符）。**从文件读入时要注意=、@等特殊字符的异常情况。**而``-d @-``可以指定要发送的内容来自标准输入（stdin）。如执行``curl -d @- http://127.0.0.1/welcome.php``，在终端输入数据后回车、Ctrl+D后达到相同效果。对于文件的使用，对于其他类似选项适用。但``-d/--data``不会对数据进行url编码，而实际场景中我们最常用的还是发送url编码后的数据。
    - ``--data-urlencode <data>``使用URL-encode编码要发送的数据。除此之外，其余同-d。-d选项默认是不会对要发送数据进行编码的，在旧版本没有``--data-urlencode``选项的curl时，要发送编码的数据，必须手动对数据进行编码，或者将数据存放在编码的文件中。``--data-urlencode``同样可以使用``@``指定从文件中输入。而且可以使用``name@filename``的形式。如使用``--data-urlencode name@foobar``，文件foobar中内容为Adeploy，即可达到``--data-urlencode name=Adeploy``的效果。这在-d选项中是不行的。需要注意的是此用法不会对name进行编码，所以需要预先编码好name字段。实际场景中一般name字段都是固定的，so it's not too much trouble.
    - ``--data-binary <data>``发送指定的不做任何处理的数据（This posts data exactly as specified with no extra processing whatsoever），其余同-d。
    - ``-G/--get``和``-d/--data``、``--data-binary``一块使用时，表示强制使用GET的方式提交表单。和``-I/--head`` 一块使用时，表示把提交的数据加在url中，而不是加在数据头中。
    - Examples
        - ``curl -s -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -o welcome.html -e http://127.0.0.1/post.php -d "name=Adeploy;age=100" http://127.0.0.1/welcome.php`` same as ``curl -s -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -o welcome.html -e http://127.0.0.1/post.php -d name=Adeploy -d age=100 http://127.0.0.1/welcome.php``
        - ``curl -s -A "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.0)" -o welcome.html -e http://127.0.0.1/post.php -G -d name=Adeploy -d age=100 http://127.0.0.1/welcome.php``
    - ``-F/--form <name=content>``使用Content-Type  ``multi‐part/form-data``的方式提交数据，可用于上传二进制文件。
        + 一般使用``-F file=@filename``的形式，其中file为文件表单的name，filename为文件名。@后面的文件作为文件上传处理。
        + 对于<后的文件，curl会读取其内容，而不会作为文件上传。类似``-d``选项中``@``的作用。如``curl -F name=<foobar.txt -Fage=100 http://127.0.0.1/welcome.php``，foobar.txt内容为Adeploy，则此命令与以下命令等价：``curl -F name=Adeploy -Fage=100 http://127.0.0.1/welcome.php``，而``-F @foobar.txt``表示将foobar.txt作为文件上传。
        + -F不进行url编码，``-F``与``-d``类似，都是不对数据进行urlencode编码，而且``-F``不能与``-d``或``--data-urlencode``共用。因此如果上传文件的同时还需要提交其他需要urlencode编码的字段（如中文用户名），就会出现问题。除手动编码外，实用的解决办法是自己编写urlencode函数。调用即可。
        + 使用"type="指定``Content-Type``，如``curl -F "web=@index.html;type=text/html" url.com``将index.html以``text/html``的Content-Type上传。
        + 使用"filename="修改上传文件的名字，如``curl -F "file=@localfile;filename=nameinpost" url.com``上传localfile并修改文件名字为nameinpost。
        + ``--form-string <name=string>``，基本同-F，但是此参数后面跟"@"、"<"、";type="时，不做特殊含义解析。
        + ``-T/--upload-file <file>``使用HTTP的PUT方法上传文件，需要目标URL支持HTTP的PUT方法。可以与``-d``、``--data-urlencode``、``-F``同时使用。
    - ``-x/--proxy <proxyhost[:port]>``使用指定的HTTP代理。如果未指定端口，默认端口为1080。此选项优先级高于环境变量中的代理设置。因此当环境变量中设置使用代理时，可以指定代理为“”而跳过代理。所有通过HTTP代理的操作都会被显示的转化为HTTP，因此某些协议的特殊操作可能无法正常使用。此问题可以通过使用``-p/--proxytunnel``选项构建基于代理的通信隧道得到解决。如果有多个-x使用，只有最后一个有效。
    - ``-U/--proxy-user <user:password>``指定用于HTTP代理认证的用户名密码。curl语句如下：``curl -x proxy.xxx.com:8080 -U username:password -e http://www.ip138.com/ http://iframe.ip138.com/city.asp``此语句等价于使用内嵌用户名密码的形式：``curl -x 'http://username:password@proxy.xxx.com:8080' -e http://www.ip138.com/ http://iframe.ip138.com/city.asp``，curl中每个需要用户名+密码的参数，你都可以只指定用户名，curl会自动提示你输入密码，这样更安全。用户名密码中如果有shell特殊字符，如$、引号等，建议放在单引号中，这样不会转义。特殊字符经常造成难以察觉的错误。如密码为$password，则执行：``curl -x http://username:$password@proxy.xxx.com -e http://www.ip138.com/ http://iframe.ip138.com/city.asp``会提示密码错误，因为shell把$password理解为取变量password的值了。同-x，如果有多个-U使用，只有最后一个有效。
    - HTTP认证方式 http://www.adeploy.com/2012/08/17/http-auth-schemes.html
        + ``--proxy-anyauth``让curl自动选择合适的认证方法。这时curl会先发出一次请求来查询认证类型。
        + ``--proxy-basic``让curl使用HTTP基本认证（HTTP  Basic authentication）模式与代理服务器通信。这是默认模式。此模式下用户名密码作为明文传递。
        + ``--proxy-digest``使用HTTP摘要认证（HTTP Digest authentication）。此模式避免将密码作为明文在网络上传递，相对提高了HTTP认证的安全性。
        + ``--proxy-negotiate``使用HTTP协商认证（HTTP Negotiate authentication）。
        + ``--proxy-ntlm``使用HTTP NTLM认证（HTTP NTLM authentication）。
        + ``--socks4 <host[:port]>``因为socks代理与``-x``选项指定的代理冲突，因此指定socks后，会覆盖掉之前使用-x指定的代理。同``-x``，如果多次指定socks代理，只有最后一次有效。在7.21.7版本之后，可以使用``-x socks4://`` 代替此参数。 
        + ``--socks4a <host[:port]>``socks4a是socks4的扩展，主要增加了域名解析，其余相同。``--socks4a``参数指定使用代理服务器解析域名，其余使用方法相同。在7.21.7版本之后，可以使用``-x socks4a://`` 代替。
        + ``--socks5 <host[:port]>``socks5在socks4的基础上增加了各种验证的支持。参数使用方法相同。在7.21.7版本之后，可以使用``-x socks5://`` 代替。
        + ``--socks5-hostname <host[:port]>``基本同``--socks5``参数，但是此参数指定使用代理服务器解析域名，而不是本地解析。而``--socks5``是使用本地域名解析。在7.21.7版本之后，可以使用``-x socks5h://`` 代替。
        + ``--socks5-gssapi-service <servicename>``设置使用gssapi的socks5代理服务器的服务名。
        + ``--socks5-gssapi-nec``设置对NEC代理服务器的兼容性。
        + ``--noproxy <no-proxy-list>``指定不使用环境变量中代理的host列表。
    - ENV(Environment Variable)
        + ``http_proxy/https_proxy/ftp_proxy/all_proxy [protocol://]<host>[:port]``
        + ``no_proxy <comma-separated list of hosts>``
    - 下载文件
        + ``-#/--progress-bar``查看下载进度条。
        + ``-o/--output <file>``下载并保存至文件file。可同时下载多个URL，每个``-o``对应一个URL。
        + ``-O/--remote-name``下载并从url中提取文件名。多个URL的情况同-o选项相同：``curl -O -O http://www.xxx.com/a.html http://www.xxx.com/b.html``或者``curl -O http://www.xxx.com/a.html -O http://www.xxx.com/b.html``都会将两个URL分别保存在a.html和b.html中。
        + ``-C/--continue-at <offset>``断点续传。offset参数指定跳过多少bytes。``-C -``指定自动检测断点续传开始位置。
        + ``-r/--range <range>``分块下载，指定每块下载的字节范围。
        + ``--limit-rate <speed>``限速下载。默认单位为bytes/s，'k'或'K'指定使用单位KB/s，可以使用'm'或'M'指定使用单位MB/s，'g'或'G'指定使用单位GB/s。
        + ``-Y/--speed-limit``限制最低下载速度，``-Y/--speed-limit``选择优先级更高。因此如果``-Y/--speed-limit``指定的值高于限制的速度，那么限制的速度回被突破，以保证最低下载速度有效。
        + ``-y/--speed-time <time>``,``-Y/--speed-limit <speed>``,网速太慢时取消下载。``-Y``指定最低速度。使用``-y``指定超时时间而未指定最低速度时，最低速度默认为1.``-y``指定超时时间，即低于最低速度多次时间时取消下载。使用``-Y``指定最低速度而未指定超时时间时，超时时间默认为30。
        + ``-z/--time-cond <date expression>``只在更新时下载。
        + 批量下载，通过使用正则表达式，可以对有一定规律的文件批量下载。``curl "http://10.1.1.103/{a,b}/[1-7].php" -o "#1_#2.php"``{}、[]类似于正则表达式中的语法，用以取得多个文件。#加数字的形式用以取得正则表达式的当前值。``
    - Https(Cert)
        + ``-E/--cert <certificate[:password]>``导入证书。curl默认使用PEM格式的证书。一般我们从浏览器导出的cert都是X.509格式。可以使用openssl转化为PEM格式。
        + ``--cert-type <type>``指定证书类型，可以为PEM、 DER 或 ENG类型。
        + ``--cacert <CA certificate>``指定使用的CA证书。CA证书必须是PEM格式。curl通过读取环境变量``CURL_CA_BUNDLE``的值作为CA证书库（CA cert bundle）的路径。此选项优先级高于此环境变量被使用。
        + ``--capath <CA certificate directory>``指定使用的CA证书路径目录。证书必须为PEM格式，且此目录已被curl自带的``c_rehash``工具处理过。在需要指定多个CA证书的时候，使用``--capath``指定CA目录更高效。
        + ``-k/--insecure``指定允许使用不安全的ssl连接传输。所有的连接都是试图通过使用默认安装的CA证书库（CA certificate bundle）来验证是安全的。非安全的连接默认是不允许的。
        + ``--key <key>``指定私钥文件名。``--key-type <type>``指定私钥文件类型，可以为DER、PEM 或 ENG。默认使用PEM。
        + http://curl.haxx.se/docs/sslcerts.html
    - FTP
        + ``curl -u ftpuser:ftppass -T myfile.txt ftp://ftp.testserver.com``
        + FTP有两种基本模式：PASV和PORT，也即主动模式和被动模式。在二者基础上分别有两种扩展：ERSV和EPRT。curl默认使用EPSV模式。
        + ``curl --verbose ftp://ftp_server/ --user user``会看到curl执行了EPSV命令。``--eprt``参数显式指定使用EPRT模式。使用``--disable-epsv``选项禁用EPSV而使用PASV。使用``-P/--ftp-port <address>``选项指定使用EPRT，其中address参数可以指定为“-”，指定使用FTP控制连接相同的地址。

```bash
#!/bin/sh
export http_proxy=http://127.0.0.1:8086
export no_proxy=ip138.com
curl -e http://www.ip138.com/ http://iframe.ip138.com/city.asp
```
