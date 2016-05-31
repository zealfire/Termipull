#!/bin/bash

# extracting password from other file, this is for security purpose
file="constants.sh"     #the file where you keep your string name

PASSWORD=$(cat "$file")

# find the current branch
FLAG=$(git symbolic-ref HEAD | cut -d/ -f3)

# enter the commit message
read -r -p "Enter the commit message: " commit_message
COMMIT_MESSAGE="'$commit_message'"


# making the commit
TEST_OUT=$(git commit -m "$COMMIT_MESSAGE")

# pushing the changes to repository
TEST_OUT=$(git push origin "$FLAG")

# extracting the name of project
GITPROJECT=$(grep 'url =' .git/config | sed -n 1p | cut -d/ -f5| cut -d. -f1)

#extracting the name of user
GITUSER=$(git config user.name)

# appending name of project to user name
SOURCE_FULL_NAME="$GITUSER/$GITPROJECT"

# extracting the name of project
DEST_GITPROJECT=$(grep 'url =' .git/config | sed -n 2p | cut -d/ -f5| cut -d. -f1)

#extracting the name of user
DEST_GITUSER=$(grep 'url =' .git/config | sed -n 2p | cut -d/ -f4)

# appending name of project to user name
DEST_FULL_NAME="$DEST_GITUSER/$DEST_GITPROJECT"

# enter the title of commit
read -r -p "Enter the title of commit: " title
TITLE="'$title'"

# enter the description of commit
read -r -p "Enter the description of commit: " description
DESCRIPTION="'$description'"

# the password entered by you in constants.sh would be use here to make a  pull request
GITPULLREQ=$(curl -X POST -H "Content-Type: application/json" -u "$GITUSER":"$PASSWORD"  https://api.bitbucket.org/2.0/repositories/"$DEST_FULL_NAME"/pullrequests   -d '
 {
     "title": "'"$TITLE"'",
     "description": "'"$DESCRIPTION"'",
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
