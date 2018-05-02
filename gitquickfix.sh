#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# ASK FOR CONFIRMATION
printf "${RED}"
read -p "WARNING: this will COMPLETELY ERASE your master branch and make it sync with main repository one, are you sure you want to continue(y/n)?" -n 1 -r
printf "${NC}"
echo ""
if [[ ! $REPLY =~ ^[Yy]$ ]] ; then
    echo "OK You bailed!"
    exit 0
fi

printf "${GREEN}You are couregeous!!! Let's go!"

git checkout HEAD
git branch master_new
git checkout master_new
git branch -d master
git checkout -b master
git branch -d master_new
git push --set-upstream origin master
git push -f
