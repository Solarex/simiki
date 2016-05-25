---
title: "pyenv"
date: 2016-05-25 12:02
---
+ pyenv help

```
$ pyenv --help
Usage: pyenv <command> [<args>]

Some useful pyenv commands are:
   commands    List all available pyenv commands
   local       Set or show the local application-specific Python version
   global      Set or show the global Python version
   shell       Set or show the shell-specific Python version
   install     Install a Python version using python-build
   uninstall   Uninstall a specific Python version
   rehash      Rehash pyenv shims (run this after installing executables)
   version     Show the current Python version and its origin
   versions    List all Python versions available to pyenv
   which       Display the full path to an executable
   whence      List all Python versions that contain the given executable

See `pyenv help <command>' for information on a specific command.
For full documentation, see: https://github.com/yyuu/pyenv#readme
```

+ ``brew install pyenv``

+ ``echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.bashrc``,``echo 'export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.bashrc``,``echo 'eval "$(pyenv init -)"' >> ~/.bashrc``,``source ~/.bashrc``


+ ``pyenv install --list``


+ ``pyenv global``

+ ``pyenv versions``

+ ``pyenv install 3.5.0``

+ ``git clone https://github.com/yyuu/pyenv-virtualenv.git ~/.pyenv/plugins/pyenv-virtualenv && source ~/.bashrc``

+ ``pyenv virtualenv 3.5.0 simiki``,``pyenv activate simiki``,``pip list/freeze``,``pyenv deactivate simiki``

+ ``pip uninstall <package>``


