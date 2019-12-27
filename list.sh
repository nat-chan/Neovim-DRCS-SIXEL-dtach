#!/bin/bash

#|sort -r|head -1
curl -sL https://api.github.com/repos/neovim/neovim/releases         |grep -oP '(?<=tag_name": ")v[0-9.]*' > a
curl -sL https://api.github.com/repos/nat-chan/hello_actions/releases|grep -oP '(?<=tag_name": ")v[0-9.]*' > b
cat a b b|sort|uniq -u|tr . ' '|awk '$2 >= 4'|tr ' ' .|head -1
