---
title: "AndroidStudio插件"
date: 2017-05-13 00:06
---
https://mp.weixin.qq.com/s?__biz=MzI3MDE0NzYwNA==&mid=2651433634&idx=1&sn=e5f65d8a0a2b85f7c22d8ccd4cf96a39&scene=1&srcid=0721vQcDls3Ak34dZY1y3h7o&key=77421cf58af4a653e4f55f04cf114492e73a17a2a7d56a0e523c62f16c003b19cdab0cf3a902023d7cbe2af60a58c71d&ascene=0&uin=MjAyNzY1NTU%3D&devicetype=iMac+MacBookPro12%2C1+OSX+OSX+10.11.3+build(15D21)&version=11020201&pass_ticket=ihQKTSTYwhIquv1%2B6HyhJs3I0vZz0qtIoTVci3l%2BikU%3D

+ GsonFormat 快速将json字符串转换成一个Java Bean，免去我们根据json字符串手写对应Java Bean的过程。
+ Android ButterKnife Zelezny 配合ButterKnife实现注解，从此不用写findViewById，想着就爽啊。在Activity，Fragment，Adapter中选中布局xml的资源id自动生成butterknife注解。
+ Android Code Generator 根据布局文件快速生成对应的Activity，Fragment，Adapter，Menu。
+ Android Parcelable code generator JavaBean序列化，快速实现Parcelable接口。
+ Android Methods Count 显示依赖库中得方法数
+ Lifecycle Sorter可以根据Activity或者fragment的生命周期对其生命周期方法位置进行先后排序，快捷键Ctrl + alt + K
+ CodeGlance 在右边可以预览代码，实现快速定位
+ findBugs-IDEA 查找bug的插件，Android Studio也提供了代码审查的功能（Analyze-Inspect Code…）
+ ADB WIFI使用wifi无线调试你的app，无需root权限
+ AndroidPixelDimenGenerator Android Studio自动生成dimen.xml文件插件
+ JsonOnlineViewer 在Android Studio中请求、调试接口
+ Android Styler根据xml自动生成style代码的插件 
+ Android Drawable Importer这是一个非常强大的图片导入插件。它导入Android图标与Material图标的Drawable ，批量导入Drawable ，多源导入Drawable（即导入某张图片各种dpi对应的图片）
+ SelectorChapek for Android 通过资源文件命名自动生成Selector文件。
+ GenerateSerialVersionUID 实现Serializable序列化bean
+ genymotion
+ LeakCanary
+ Android Postfix Completion帮助你在开发阶段方便的检测出内存泄露的问题，使用起来更简单方便。
+ Android Postfix Completion可根据后缀快速完成代码，这个属于拓展吧，系统已经有这些功能，如sout、notnull等，这个插件在原有的基础上增添了一些新的功能，我更想做的是通过原作者的代码自己定制功能，那就更爽了
+ Android Holo Colors Generator通过自定义Holo主题颜色生成对应的Drawable和布局文件
+ dagger-intellij-plugindagger可视化辅助工具
+ GradleDependenciesHelperPlugin maven gradle 依赖支持自动补全
+ RemoveButterKnife ButterKnife这个第三方库每次更新之后，绑定view的注解都会改变，从bind,到inject，再到bindview，搞得很多人都不敢升级，一旦升级，就会有巨量的代码需要手动修改，非常痛苦.当我们有一些非常棒的代码需要拿到其他项目使用，但是我们发现，那个项目对第三方库的使用是有限制的，我们不能使用butterknife，这时候，我们又得从注解改回findviewbyid.针对上面的两种情况，如果view比较少还好说，如果有几十个view，那么我们一个个的手动删除注解，写findviewbyid语句，简直是一场噩梦（别问我为什么知道这是噩梦）.所以，这种有规律又重复简单的工作为什么不能用一个插件来实现呢？于是RemoveButterKnife的想法就出现了。
+ AndroidProguardPlugin 一键生成项目混淆代码插件，值得你安装~(不过目前可能有些第三方项目的混淆还未添加完全)
+ otto-intellij-plugin otto事件导航工具。
+ eventbus-intellij-plugin eventbus导航插件
+ idea-markdown markdown插件
+ Sexy Editor 设置AS代码编辑区的背景图首先点击界面的设置按钮 进入设置界面，选中Plugins,右边选择 Browser … ，输入Sexy … 下面自动弹出候选插件，右边点击Install 安装
+ folding-plugin 布局文件分组的插件
+ Android-DPI-Calculator DPI计算插件
+ gradle-retrolambda 在java 6 7中使用 lambda表达式插件 修改编译的jdk为java8
+ Android Studio Prettify 可以将代码中的字符串写在string.xml文件中选中字符串鼠标右键选择图中所示
+ Material Theme UI 添加Material主题到你的AS
+ .ignore 我 们都知道在Git 中想要过滤掉一些不想提交的文件，可以把相应的文件添加到.gitignore 中，而.gitignore 这个Android Studio 插件根据不同的语言来选择模板，就不用自己在费事添加一些文件了，而且还有自动补全功能，过滤文件再也不要复制文件名了。我们做项目的时候，并不是所有文 件都是要提交的，比如构建的build 文件夹，本地配置文件，每个Module 生成的iml 文件，但是我们每次add，commit 都会不小心把它们添加上去，而gitignore 就是解决这种痛点的，如果你不想提交的文件，就可以在创建项目的时候将这个文件中添加即可，将一些通用的东西屏蔽掉。
+ CheckStyle-IDEA CheckStyle-IDEA 是一个检查代码风格的插件，比如像命名约定，Javadoc，类设计等方面进行代码规范和风格的检查，你们可以遵从像Google Oracle 的Java 代码指南 ，当然也可以按照自己的规则来设置配置文件，从而有效约束你自己更好地遵循代码编写规范。
+ Markdown Navigator Markdown插件
+ ECTranslation Android Studio Plugin,Translate English to Chinese. Android Studio 翻译插件,可以将英文翻译为中文。
+ PermissionsDispatcher plugin自动生成6.0权限的代码
+ WakaTime 记录你在IDE上的工作时间
+ AndroidWiFiADB无线调试应用
+ AndroidLocalizationer 可用于将项目中的 string 资源自动翻译为其他语言的 Android Studio/IntelliJ IDEA 插件



