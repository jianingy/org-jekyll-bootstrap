#!/bin/bash

# filename   : setup-local-gem.sh
# created at : 2013-04-26 10:28:54
# author     : Jianing Yang <jianingy.yang AT gmail DOT com>

root="$(readlink -e $(dirname $0)/..)"

export GEM_HOME=$root/gem
export PATH="$root/gem/bin:$PATH"

if [ ! -x $root/gem/bin/jekyll ]; then
    echo INSTALL: jekyll
    gem install --no-user-install --no-rdoc --no-ri --install-dir "$root/gem" jekyll
fi

