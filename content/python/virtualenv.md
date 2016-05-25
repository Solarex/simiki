---
title: "virtualenv"
date: 2014-06-11 23:29
---
## virtualenv & virtualenvwrapper ##

### set up virtualenv ###
+ ``virtualenv``用于创建独立的Python环境，多个Python相互独立，互不影响

+ ``virtualenvwrapper``是``virtualenv``的扩展包，方便管理虚拟环境

+ ``sudo apt-get install python-virtualenv``


### virtualenv ###

+ ``virtualenv [--no-site-packages]  env_name``

+ ``cd env_name && source ./bin/activate``

+ ``deactivate``


### virtualenvwrapper ###

+ ``mkdir $HOME/.virtualenvs && echo 'export WORKON_HOME=$HOME/.virtualenvs' >> ~/.bashrc && source ~/.bashrc``

+ ``lsvirtualenv``

+ ``mkvirtualenv env_name``

+ ``workon env_name``

+ ``rmvirtualenv env_name``

+ ``deactivate``


