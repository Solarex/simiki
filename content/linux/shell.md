---
title: "shell"
date: 2014-06-11 23:31
---
## Bash Commands ##

+ ``tar xvjfm scripts.tar.bz2``, ``-m, --touch don't extract file modified time``, using time in host machine

+ ``curl -H "Content-Type: application/json" -d '{"object_kind":"merge_request","object_attributes":{"id":22,"target_branch":"master","source_branch":"master","source_project_id":57,"author_id":9,"assignee_id":null,"title":"Master Title","created_at":"2014-07-02T02:31:20.000Z","updated_at":"2014-07-02T02:36:33.008Z","milestone_id":null,"state":"closed","merge_status":"unchecked","target_project_id":55,"iid":7,"descrinption":"description_content"}}' http://10.0.6.122:9002/merge_request`` curl post

+ ``apt-get update/upgrade/dist-upgrade/autoclean/autoremove/clean/remove/purge``

+ ``dpkg-reconfigure foo``重新配置

+ ``echo "foo hold" | sudo dpkg --set-selections``

+ ``echo "foo install" | sudo dpkg --set-selections``

+ ``apt-cache search foo, dpkg -l foo*``, ``apt-cache show foo , dpkg --print-avail foo``

+ ``dpkg -L foo``

+ ``dpkg --get-selections``

+ ``dlocate foo, dpkg -S foo`` foo文件来自哪个包

+ ``apt-file search foo`` 哪些安装包提供foo文件,不仅仅包含系统中已经安装的

+ ``dpkg -c foo.deb`` foo.deb 包含哪些文件

+ ``apt-cache dumpavail``显示所有可用安装包,以及他们各自的详细信息

+ ``apt-cache pkgnames`` 快速列出已安装软件包名称

+ apt使用代理:``echo "export http_proxy=http://127.0.0.1:8087" >> ~/.bashrc``,``echo 'Acquire::http::proxy http://127.0.0.1:8087' >> /etc/apt/apt.conf ``

+ Win:``tasklist /svc``,``taskkill /pid 1965``,``taskkill /f /im QQ.exe``

+ ``tar xvf sth.tgz -C uncompress_folder``

+ ``updatedb -l 0 -o db_file -U source_directory`` , ``locate sth -d db_file``

+ find out the working directory of a running process,``pwdx <pid>``,``lsof -p <pid> | grep cwd``,``readlink /proc/<pid>/cwd``

+ format json in vim,``%!python -m json.tool``


