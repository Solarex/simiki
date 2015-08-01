---
title: "user"
date: 2015-07-14 20:41
---
+ 为用户创建相应的帐号和用户目录/home/username ``useradd -m username``
+ 为用户设置密码 ``passwd username``
+ 删除用户 ``userdel -r username``不带选项使用 userdel，只会删除用户。用户的家目录将仍会在/home目录下。要完全的删除用户信息，使用-r选项；
+ 帐号切换 登录帐号为userA用户状态下，切换到userB用户帐号工作:``su userB``
+ 默认情况下，添加用户操作也会相应的增加一个同名的组，用户属于同名组； 查看当前用户所属的组:``groups``，一个用户可以属于多个组，将用户加入到组:``usermod -G groupNmame username``，变更用户所属的根组(将用加入到新的组，并从原有的组中除去）:``usermod -g groupName username``
+ 系统的所有用户及所有组信息分别记录在两个文件中：/etc/passwd , /etc/group 默认情况下这两个文件对所有用户可读，可以用来查看所有的用户和组。
