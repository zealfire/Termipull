#!/bin/bash

# find the current branch
FLAG=$(git symbolic-ref HEAD | cut -d/ -f3)
printf "$FLAG\n"

# enter the commit message
echo "enter the commit message:"
read commit_message

# do to the commit
TEST_OUT=$(echo "$(git commit -m $commit_message)" 2>&1) 
printf "$TEST_OUT\n"

# pushing the changes to repository
TEST_OUT=$(echo "$(git push origin $FLAG)" 2>&1)

printf "$FLAG\n"

GITPULLREQ=$(curl -X POST -H "Content-Type: application/json" -u username:password   https://api.bitbucket.org/2.0/repositories/zealfire_/test_repo/pullrequests   -d '
 {
     "title": "title",
     "description": "Merge from upstream.",
     "source": {
         "branch": {
             "name": "'"$FLAG"'"
         },
         "repository": {
             "full_name": "zealfire_/test_repo"
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
# enter your username and password over here

# create a pull request
# $(echo "$(git request-pull master origin $FLAG)" 2>&1)