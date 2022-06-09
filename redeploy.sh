#!/bin/bash

url_prefix="git@github.com:Meknassih/"
url_suffix=".git"

if [ $# -lt 2 ]
then
        echo "Usage: redeploy <repo name> <npm command>"
        echo "repo name will be inserted in '$url_prefix<here>$url_suffix'"
        echo "npm command will be run like this 'npm run <here>'"
        exit 1
fi


npm_command=$2

if [ $PWD != "/home/node/www" ]
then
        cd /home/node/www
fi
echo "Working in '$PWD'"

url=$url_prefix$1$url_suffix

if [ -d "$1" ]
then
    echo "Local repo '$1' exists, pulling..."
    cd $1
    git pull
    npm i
    npm run $2 &
else
    echo "Local repo '$1' does not exist, cloning from '$url'..."
    git clone $url
    cd $1
    npm i
    npm run $2 &
fi

exit 0
