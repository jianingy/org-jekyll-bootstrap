#!/bin/bash

# filename   : build.sh
# created at : 2013-04-24 11:18:47
# author     : Jianing Yang <jianingy.yang AT gmail DOT com>


mkdir -pv source
export PATH=$PWD/gem/bin:$PATH
export GEM_PATH=$PWD/gem:$GEM_HOME
#echo PATH=$PATH GEM_PATH=$GEM_PATH
soruce_ready=0
pub_directory="/var/www/html/"

while read site source; do
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
	/usr/local/bin/emacs -batch -q -l lisp/publish.el --eval "$lisp"
	pushd site/$site &>/dev/null
	jekyll --no-server --no-auto $pub_directory/$site/wwwroot
	popd &>/dev/null
    fi
done < ./manifest
