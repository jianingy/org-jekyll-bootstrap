#!/bin/bash

# filename   : setup-local-gem.sh
# created at : 2013-04-26 10:28:54
# author     : Jianing Yang <jianingy.yang AT gmail DOT com>

root="$(readlink -e $(dirname $0)/..)"

gem install --no-user-install -i "$root/gem" jekyll

GEM_PATH=$root/gem
PATH="$root/gem/bin:$PATH"
