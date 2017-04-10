---
title: "Android Studio Skills"
date: 2015-05-05 11:49
---
##AS shortcuts(XWindow)
+ 格式化代码 main->Code->Reformat Code  Ctrl+Alt+L
+ 复制行 main->Edit->Duplicate Line Ctrl+D
+ 删除行 main->Edit Actions->Delete Line Ctrl+Y
+ 上下移动行 main->Code->Move Line Down/Up Alt+Shift+Up/Down
+ 查找引用 main->Edit->Find->Find Usage Alt+F7
+ 查找下一个 main->Edit->Find->Find Next F3
+ 查找上一个 main->Edit->Find->Find Previous Shift+F3
+ 从路径中查找 main->Edit->Find->Find in path Ctrl+Shift+F
+ 行注释 Ctrl+/
+ 块注释 Ctrl+Shift+/
+ 重命名 main->Refactor->Rename Shift+F6
+ 提取方法 main->Refactor->Extract->Method Ctrl+Alt+M
+ 查找文本 Ctrl+F
+ 替换文本 Ctrl+R
+ 查找类 main->Navigate->Class Ctrl+N
+ 查找文件 main->Navigate->File Ctrl+Shift+N
+ 大小写切换 main->Edit->Toggle Case Ctrl+Shift+U
+ 方法折叠/展开 main->Code->Folding->Expand/Collapse Ctrl+加号/减号
+ 折叠/展开所有的方法 main->Code->Folding->ExpandAll/CollapseAll Ctrl+Shift+加号/减号
+ 隐藏所有面板 main->Window->Active Tool Window->Hide All Tool Window Ctrl+Shift+F12
+ 列选择/块选择 Alt+选择代码块进行操作
+ 代码提示不区分大小写 Preferences->Editor->General->Code Completion->Case sensitive completion 选择None
+ 鼠标显示悬浮提示 Preferences->Editor->General->other->勾选show quick document on mouse over
+ ``enter``补全``tab``补全替换掉错误的

+ ``esc``编辑窗口获取焦点，``shift+esc``关闭其他窗口，编辑窗口获取焦点，e.g. find usage --> shift+esc

+ ``f12``重新打开刚才关闭的工具窗口

+ ``ctrl+tab``窗口切换，编辑窗口+工具窗口``ctrl+e``recently opened files ``ctrl+shift+e``recently opened tool windows

+ ``ctrl+shift+f12``关闭所有工具窗口

+ ``ctrl+p``方法参数提示

+ ``ctrl+alt+v``自动生成变量并补全变量类型

+ ``ctrl+alt+p``将方法中声明的局部变量提取到方法参数中供外部传入

+ ``ctal+alt+m``将选中代码抽取成方法``ctrl+alt+n``反向

+ ``shift+ctrl+alt+t``弹出重构菜单

+ ``shift+f6``修改变量名、方法名、类名

+ ``alt+f1``弹出文件菜单，可以在finder中定位文件

+ ``shift+方向键``拓展选择

+ ``ctrl+alt+t``surround with菜单

+ ``ctrl+alt+h``显示调用方法树

+ ``cmd+0``(user-defined)navigate back ``ctrl+alt+向右``navigate forward

+ ``ctrl+b``，``ctrl+click``跳转到声明，``ctrl+alt+b``跳转到实现，``ctrl+shift+b``跳转到类型实现声明

+ ``ctrl+u``跳转到父类

+ ``alt+上下方向键``在内部类和方法声明之间跳转

+ ``ctrl+f12``显示file structure

+ ``ctrl+shift+i`` quick definition lookup

+ ``ctrl+shift+plus/minus`` 展开折叠代码段

+ ``ctrl+shift+a`` find actions

+ ``alt+shift+up/down`` move line up/down

+ ``ctrl+y`` delete line or selections

+ ``ctrl+d`` duplicate lines

+ ``ctrl+w/ctrl+shift+w`` expand/shrink selections

+ ``ctrl+j``inset live template / snippet

+ ``ctrl+shift+enter``complete statments

+ ``ctrl+shift+backspace`` last edition location

+ ``ctrl+shift+j`` join lines

+ ``cmd+5``toggle breakpoints ``alt+cmd+5`` view all breakpoints

+ ``shift+f6`` rename

+ ``ctrl+f4``关闭窗口

+ line wrap,``Preferences --> Editor --> Code Style``,set ``Right margin (columns)`` to ``120``,``Preferences --> Editor --> Code Style --> Java --> Wrapping and Braces --> Ensure right margin is not exceeed`` checked,``code --> Reformat code``



##shortcuts

+ [quick_start](http://confluence.jetbrains.com/display/IntelliJIDEA/Quick+Start)

+ [ref](http://www.techrepublic.com/article/four-handy-android-studio-shortcuts-for-eclipse-users/)

+ tips&tricks,[0](http://www.developerphil.com/android-studio-tips-tricks-moving-around/),[1](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-1/),[2](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-2/),[3](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-3/),[4](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-4/),[5](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-5/),[6](http://www.developerphil.com/android-studio-tips-of-the-day-roundup-6/)

+ posts,[快捷键](http://www.jcodecraeer.com/a/anzhuokaifa/androidkaifa/2014/1108/1935.html),[加速构建](http://www.jcodecraeer.com/a/anzhuokaifa/Android_Studio/2015/0324/2637.html),[使用gradle构建Android程序](https://rinvay.github.io/android/2015/04/09/Build-Android-with-Gradle/),[导入开源库到基于Android Studio构建的项目中](http://blog.isming.me/2014/12/12/import-library-to-android-studio/),[使用gradle构建android项目（续）](http://blog.isming.me/2014/11/21/use-gradle-new/),[使用Gradle构建Android项目](http://blog.isming.me/2014/05/20/android4gradle/),[AndroidStudio配置本地gradle]

+ 如果网速不行想跳过这步的可以在bin目录的idea.properties增加一行：disable.android.first.run=true就行了，mac平台的右键安装包->Show Package Contents 就找到bin目录了

+ ``cmd+shift+f``,search

+ ``Ctrl+P``方法参数提示

+ ``Ctrl+空格``代码提示 

+ ``Ctrl＋Shift＋Space``在很多时候都能够给出Smart提示

+ ``Ctrl+Alt+Space``类名或接口名提示



+ ``tasks.withType(JavaCompile){}``,[https://stackoverflow.com/questions/24668746/after-upgrading-to-gradle-2-0-could-not-find-property-compile-on-root-project](https://stackoverflow.com/questions/24668746/after-upgrading-to-gradle-2-0-could-not-find-property-compile-on-root-project)




