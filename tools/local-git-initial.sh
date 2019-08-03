#!/bin/bash

NEW_REPO=repo-name
if [ "$1" != "" ]
then
    NEW_REPO=$1
fi

# start sshd service
# sudo systemctl start sshd.service
# cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys

mkdir -p $NEW_REPO.git/$NEW_REPO.git

cd  $NEW_REPO.git/$NEW_REPO.git

git init --bare

cd -

mkdir test

cd test

git init .

echo "# $NEW_REPO" > README.md

git add .

git commit -m "initial commit"

git remote add origin localhost:`pwd`/../$NEW_REPO.git/$NEW_REPO.git

git push -u origin master

cd -
git clone localhost:`pwd`/$NEW_REPO.git/$NEW_REPO.git
rm test -fr
