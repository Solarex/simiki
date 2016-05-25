---
title: "rsync"
date: 2014-06-11 23:48
---
## rsync ##

+ ``rsync -avzP -e ssh remoteuser@remotehost:/remote/dir /this/dir/``

+ [ref0](http://troy.jdmz.net/rsync/index.html),[ref1](http://www.tecmint.com/rsync-local-remote-file-synchronization-commands/)

+ ``rsync options source destination``

+ options

  + ``-v``,verbose

  + ``-r``,recursively

  + ``-a``,archive mode

  + ``-z``,compress file data

  + ``-h``,human-readable,output numbers in a human-readable format

+ If a file or directory not exist at the source, but already exists at the destination, you might want to delete that existing file/directory at the target while syncing .

+ ``rsync --remove-source-files -zvh backup.tar /tmp/backups/``

+ ``rsync --dry-run --remove-source-files -zvh backup.tar /tmp/backups/``

+ ``rsync -zvhW backup.tar /tmp/backups/backup.tar backup.tar``,Also, by default rsync syncs changed blocks and bytes only, if you want explicitly want to sync whole file then you use ‘-W‘ option with it.

