#!/bin/bash
PATCH_PATH=
LOCAL_GIT_NAME=

function usage()
{
    echo $0 patch_path local_git_name
}

if [ "$1" == "" ]
then
    usage
    exit;
fi
PATCH_PATH=$1

if [ "$2" == "" ]
then
    usage
    exit;
fi
LOCAL_GIT_PATH=$2

mkdir $LOCAL_GIT_PATH
git -C $LOCAL_GIT_PATH init .

# find $PATCH_PATH -name "*.patch" | xargs  ls -c | xargs git -C $LOCAL_GIT_PATH  am

for i in `grep -r "Date:" $PATCH_PATH | awk -F "Date: " '{print $2 ":" $1}' | sort | awk -F "/" '{print $2}' | cut -d : -f1`
do
    echo $i
    git -C $LOCAL_GIT_PATH am `pwd`/$PATCH_PATH/$i
done

git clone localhost:`pwd`/$LOCAL_GIT_PATH/`ls $LOCAL_GIT_PATH| grep ".git"`
