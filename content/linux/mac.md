---
title: "MAC Skills"
date: 2015-08-30 23:31
---

+ ``defaults write com.apple.screencapture location ~/Pictures/ScreenShots;killall SystemUIServer``,change default screen capture folder

+ ``diskutil list``

+ ``diskutil unmountDisk force /dev/disk2``

+ [charles破解 sn 注册码](http://www.gfzj.us/2014/12/20/charlse-sn-download.html)，[Charles Web Debugging Proxy Hacking](http://www.gfzj.us/tech/2015/06/24/charles-hacking.html)

+ pdf背景色改变，RGB，199 237 204，由于windows每一项的最大值是255，若以1为最大值，则这个颜色的值为：0.78 0.93 0.8，skim的颜色管理支持 RGBa格式，并且是以1为最大值，关闭skim。打开终端，输入``defaults write -app skim SKPageBackgroundColor -array 0.78 0.93 0.8 1``

+ mac command lines

+ ``mitmproxy -a IP_ADDR -p PORT —-no-upstream-cert``代理时不校验ssl证书

+ Use the following Terminal command to reset the DNS cache in OS X v10.10.4 or later:``sudo killall -HUP mDNSResponder``

+ sips
  + ``sips --resampleWidth <width in pixel> --resampleHeight <height in pixels> /pat/to/pic``
  + ``sips -Z 320 iamge_file_name``裁剪时固定图片宽度，高度自适应
  + ``sips -z 400 300 iamge_file_name``裁剪时指定图片宽与高

  + ``sips -r 90 image_file_name`` 旋转图片，上面的命令将图片顺时针旋转90度，相信机智的你已经想到逆时针90度应该是-90了。没错，顺时针用正数表示，逆时针可以用负数表示。你可以进行任意角度和方向的旋转。

  + ``sips -f horizontal image_file_name`` 翻转图片，上面命令可以对图片进行水平翻转，-f支持水平和垂直两种翻转，水平（horizontal），垂直（vertical）。

  + ``sips -s format jpeg input.png -o output.jpg``，修改图片格式，使用-s参数可以修改图片格式为指定值，sips支持jpeg | tiff | png | gif | jp2 | pict | bmp | qtif | psd | sgi | tga共11种格式。并且-s除了能修改文件格式外，还能修改图片的其它meta数据，具体可以通过man sips查看。

  + ``sips -g pixelWidth -g pixelHeight image_file_name`` 上面命令可以获取图片的长宽高信息，与-s参数一样，-g也支持更多的meta值，可以参见man sips的信息

+ [java applet security in mac](https://www.java.com/en/download/faq/exception_sitelist.xml),``system preferences``-->``java``-->``security``-->``exception list``

+ ``alias server='python -m SimpleHTTPServer || python -m http.server``,``alias show='defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder'``,``alias hidden='defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder``'``alias port='port(){ lsof -i tcp:$@;};port $1'``
+ ``function port() { lsof -i tcp:$1 }``,``function ports() { lsof -Pni4 | grep LISTEN }``

+ brew

  + ``brew list``,``brew list --pinned``

  + ``brew search git``,``brew install git``,``brew update && brew upgrade``

  + ``brew cleanup``

  + ``brew cask search sogouinput``

  + ``brew cask install sogouinput``

+ ``system_profiler SPUSBDataType``得到所有USB设备信息，``system_profiler SPNetworkDataType``得到所有网络信息

+ disable AndroidFileTransfer agent

  + http://android.stackexchange.com/questions/33504/stop-android-file-transfer-popping-up

  + ``rm -r ~/Library/Application\ Support/Google/Android\ File\Transfer/Android\ File\ Transfer\ Agent.app``

  + ``cd /Applications/Android\ File\ Transfer.app/Contents/Resources && mv Android\ File\ Transfer\ Agent.app Android\ File\ Transfer\Agent.app.disable``

  + remove AFT from login items,System preferences --> Users&Groups --> user --> login items

+ Your services (the ones that are local to your account,automator) are in the folder: ``~/Library/Services``.
