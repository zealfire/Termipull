#!/bin/bash

# find all the branch
all_branches=$(echo "$(git branch)" 2>&1)

# find the current branch
branch_name = $(echo "$all_branches"|grep -P '(?<=\*)[ ](.)*(?=)' -o 2>&1)
printf "$branch_name"

# enter the commit message
echo "enter the commit message: "
read commit_message

do to the commit
commit_result=$(echo "$(git commit -m $commit_message)" 2>&1) 
printf "$commit_result"

# pushing the changes to repository
push_result=$(echo "$(git push origin $branch_name)" 2>&1) 
printf "$push_result"

# making a pull request
