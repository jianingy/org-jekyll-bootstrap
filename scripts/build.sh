#!/bin/bash

# filename   : build.sh
# created at : 2013-04-24 11:18:47
# author     : Jianing Yang <jianingy.yang AT gmail DOT com>

root="$(readlink -e $(dirname $0)/..)"

if [ ! -x $root/gem/bin/jekyll ]; then
    . $root/scripts/activate-local-gem.sh
fi

mkdir -pv source
soruce_ready=0

while read site source dest; do
    echo BUILDING: $site
    if [[ -d source/$site ]]; then
        echo PULLING: $source
	pushd source/$site &>/dev/null
	git reset --hard
	if git pull origin master; then
	    source_ready=1
	fi
	popd &>/dev/null
    else
        echo CLONING: $source
	if git clone $source source/$site; then
	    source_ready=1
	fi
    fi

    if [[ "x$source_ready" == "x1" ]]; then
        echo GENERATING: $site
	lisp="(progn (add-new-blog \"$site\") (org-jekyll-export-project \"$site\"))"
	emacs -batch -q -l lisp/publish.el --eval "$lisp"
	pushd site/$site &>/dev/null
	jekyll --no-server --no-auto $dest
	popd &>/dev/null
    fi
done < ./manifest
