---
title: "node"
date: 2016-05-25 12:01
---
+ [Installing, Listing and Uninstalling packages using npm](http://javascript.tutorialhorizon.com/2014/09/21/installing-listing-and-uninstalling-packages-using-npm/)

+ ``npm install -g packagename``,``npm uninstall -g packagename``

+ ``npm install -g gitbook-cli --save``

+ ``gitbook versions``,``gitbook versions:install 2.6.7``,``gitbook versions:uninstall 2.6.7``,``gitbook init``,``gitbook install plugin``,``gitbook serve``,``gitbook serve --port 8001``,``gitbook build``,``gitbook pdf book pdf``

+ ``npm list -g --depth=0``,``npm root -g``,``npm view <module_name> versions``,``npm view <module_name> version``,``npm outdated -g --depth=0``,``npm install -g <module_name> --save``,``npm update -g <module_name>``,``npm list``,``npm list --depth=0``,``npm list -g --depth=0``,``npm uninstall -g <module_name>``

+ ``npm prune``Some­times after installing pack­ages, you real­ize that you dont really need some of them and you delete those entries from your package.json. Although those pack­ages will not be installed again on run­ning an npm install, you still need to remove them from your node_modules folder at least once. To remove all such unused pack­ages from your node_modules, you can run the command

+ ``npm prune --production``If you just want to delete all of your installed devDe­pen­den­cies while retain­ing their entry in the package.json file, you can do that using the command

+ ``npm install -g express --save``The above com­mand not only installs the lat­est ver­sion of the pack­age ‘express’ for you but it also updates your package.json file and adds the pack­age name and the installed ver­sion num­ber to your depen­den­cies map.This way, the next time you clone your pack­age, or delete your node_modules folder and then issue the npm install com­mand, npm will install exact same ver­sions of your pack­ages that were spec­i­fied in your pack­age json there­fore pre­vent­ing your code from break­ing due to updates to packages.

+ The next inter­est­ing hap­pens when you real­ize that you actu­ally have two kinds of pack­ages — ones that are required for your appli­ca­tions to run and oth­ers that you use as tools that help you dur­ing devel­op­ment — such as ``jshint``, ``grunt``, ``grunt tasks``, mini­fi­ca­tion, ``sass com­pil­ers`` etc etc.Since these pack­ages are only required by the devel­oper, they dont need to be installed by some­one else that might use your pack­age in the future. The rea­son why it is impor­tant to make this dis­tinc­tion is because when some­one else who men­tions your pack­age as depen­dency in their project issues an ``npm install``, npm will also go ahead and install all the pack­ages spec­i­fied in your ‘depen­den­cies’. npm can­not dis­tin­guish between manda­tory pack­ages and development-only pack­ages. Well at least not unless you tell it to.The cor­rect way to spec­ify devel­op­ment only pack­ages is by list­ing them in your ``package.json`` under the key ‘devDe­pen­den­cies’. And just like before, you don’t need to remem­ber the pack­age ver­sion num­bers of these pack­ages. You can install them by sim­ply run­ning the npm install com­mand with the ``–save-dev`` option as shown,``npm install grunt --save-dev``.Just like the ``–save`` option, the ``–save-dev`` option updates your package.json file but this time it adds an entry to your ``devDe­pen­den­cies`` map thereby help­ing you make a clear dis­tinc­tion between required-to-run pack­ages and development-only packages.

+ If you just want to delete all of your installed devDe­pen­den­cies while retain­ing their entry in the package.json file, you can do that using the command.``npm prune --production``After this com­mand, the only pack­ages left in your node_modules direc­tory will be the ones that are spec­i­fied in your depen­den­cies map.
+ Some­times after installing pack­ages, you real­ize that you dont really need some of them and you delete those entries from your package.json. Although those pack­ages will not be installed again on run­ning an npm install, you still need to remove them from your node_modules folder at least once. To remove all such unused pack­ages from your node_modules, you can run the command``npm prune``.

+ If at any time, you want unin­stall a mod­ule, you can do that by the command``npm uninstall packagename``And just like the ``npm install`` com­mand, the ``unin­stall`` com­mand also takes accepts ``–g``, ``–save`` and ``–save-dev`` to remove ``global mod­ules`` and update the ``pack­age depen­den­cies`` or ``devDe­pen­den­cies`` respectively.
