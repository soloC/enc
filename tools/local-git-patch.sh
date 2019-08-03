#!/bin/bash
LOCAL_GIT_PATH=

function usage()
{
    echo $0 local_git_name
}

if [ "$1" == "" ]
then
    usage
    exit;
fi
LOCAL_GIT_PATH=$1

find $LOCAL_GIT_PATH -name "*.patch" | xargs rm -fr

git -C $LOCAL_GIT_PATH add .
git -C $LOCAL_GIT_PATH commit -m "update `date +%Y%m%d%H%M%S`"

# first upload should use `git -C $LOCAL_GIT_PATH --root`
git -C $LOCAL_GIT_PATH format-patch HEAD^
