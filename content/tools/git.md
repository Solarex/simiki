---
title: "git"
date: 2014-06-11 23:28
---
## git config

```
[user]
	name = Solarex
	email = rh.hou.work@gmail.com
[core]
	editor = vim
[color]
	ui = auto
[alias]
	lg = log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --
[commit]
    template = ~/.git_commit.template
```

## git flow

```
远程创建一个主分支，本地每人创建功能分支，日常工作流程如下：

去自己的工作分支
$ git checkout work

工作
....

提交工作分支的修改
$ git commit -a

回到主分支
$ git checkout master

获取远程最新的修改，此时不会产生冲突
$ git pull

回到工作分支
$ git checkout work

用rebase合并主干的修改，如果有冲突在此时解决
$ git rebase master

回到主分支
$ git checkout master

合并工作分支的修改，此时不会产生冲突。
$ git merge work

提交到远程主干
$ git push
```

# git 恢复备份

```
git clone --mirror $(url}/{repo}
pushd ${repo}
git remote update
popd
```

# git 命令

+ ``git remote show origin``，查看远程分支

+ ``git remote prune origin``，删除远程已经不存在的分支，stale状态

+ ``git remote set-url origin git@192.168.6.70:res_dev_group/test.git`` 变更项目地址

+ ``git commit --amend``，修改最近的一次提交

+ ``git commit --amend --reset-author``重置最后一次提交的author

+ ``git log --follow -p file``，查看文件历史版本

+ ``git cherry-pick commit-id``，"复制"一个提交节点并在当前分支做一次完全一样的新提交。

+ ``git clone -o meizu ssh://*****``,change remote origin to meizu

+ [visual-git-guide](https://marklodato.github.io/visual-git-guide/index-zh-cn.html)

+ ``git config --global diff.external /path/to/meld.sh``


```bash
#!/bin/bash
meld "$2" "$5" >/dev/null >2&1
```

+ ``git config --global diff.external /path/to/opendiff.sh``,``git config --global --unset diff.external``

```bash
#!/bin/bash
/usr/bin/opendiff "$2" "$5" -merge "$1"
```

+ ‘matching’参数是 Git 1.x 的默认行为，其意是如果你执行 git push 但没有指定分支，它将 push 所有你本地的分支到远程仓库中对应匹配的分支。而 Git 2.x 默认的是 simple，意味着执行 git push 没有指定分支时，只有当前分支会被 push 到你使用 git pull 获取的代码。

```bash
git config --global push.default matching
```

+ ``git submodule add 仓库地址 路径``仓库地址是指子模块仓库地址，路径指将子模块放置在当前工程下的路径。路径不能以 / 结尾（会造成修改不生效）、不能是现有工程已有的目录（不能順利 Clone）
  命令执行完成，会在当前工程根路径下生成一个名为“.gitmodules”的文件，其中记录了子模块的信息。添加完成以后，再将子模块所在的文件夹添加到工程中即可。

+ submodule的删除稍微麻烦点：首先，要在“.gitmodules”文件中删除相应配置信息。然后，执行git rm –cached命令将子模块所在的文件从git中删除。下载的工程带有submodule当使用git clone下来的工程中带有submodule时，初始的时候，submodule的内容并不会自动下载下来的，此时，只需执行如下命令：

```bash
git submodule update --init --recursive
```

+   ``git subtree add --prefix emacs/.emacs.d git@github.com:jcouyang/.emacs.d.git master —squash``,``git remote add emacs git@github.com:jcouyang/.emacs.d.git``,``git subtree push --prefix emacs/.emacs.d emacs master``
+   ​