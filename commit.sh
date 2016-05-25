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

# enter your username and password over here
GITPULLREQ=$(curl -X POST -H "Content-Type: application/json" -u username:password   https://api.bitbucket.org/2.0/repositories/username/project_name/pullrequests   -d '
 {
     "title": "title",
     "description": "Merge from upstream.",
     "source": {
         "branch": {
             "name": "'"$FLAG"'"
         },
         "repository": {
             "full_name": "username/project_name"
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
