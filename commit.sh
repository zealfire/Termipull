#!/bin/bash

# find the current branch
FLAG=$(git symbolic-ref HEAD | cut -d/ -f3)
printf "$FLAG\n"

# enter the commit message
read -r -p "Enter the commit message: " commit_message

# do to the commit
TEST_OUT=$(echo "$(git commit -m $commit_message)" 2>&1) 
printf "$TEST_OUT\n"

# pushing the changes to repository
TEST_OUT=$(echo "$(git push origin $FLAG)" 2>&1)

printf "$FLAG\n"

GITPROJECT=$(grep 'url =' .git/config | sed -n 1p | cut -d/ -f5| cut -d. -f1)
GITUSER=$(git config user.name)
SOURCE_FULL_NAME="$GITUSER/$GITPROJECT"
# enter your username and password over here to make a pull request
GITPULLREQ=$(curl -X POST -H "Content-Type: application/json" -u username:password   https://api.bitbucket.org/2.0/repositories/username/project_name/pullrequests   -d '
 {
     "title": "title",
     "description": "Merge from upstream.",
     "source": {
         "branch": {
             "name": "'"$FLAG"'"
         },
         "repository": {
             "full_name": "'"$SOURCE_FULL_NAME"'"
         }
     },
     "destination": {
         "branch": {
             "name": "master"
         }
     },
     "close_source_branch": true
 }
')

printf "\n\n$GITPULLREQ\n"
