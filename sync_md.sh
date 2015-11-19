#!/bin/bash
cd content
rm -rf *
rsync -avzP /Users/houruhou/Workspace/OpenSource/Blog+Wiki/wiki/content/* .
cd ..
#simiki generate
#simiki preview
