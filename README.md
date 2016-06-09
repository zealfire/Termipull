# Termipull
A bash script to automate the process of making a pull request.

Currently the script being developed would work only for repositories hosted on bitbucket,
mainly because in my daily work I have to create a pull request to repos hosted on same.


In order to avoid entering your username and password everytime you want to push a commit, you can either use this link https://confluence.atlassian.com/bitbucket/set-up-ssh-for-git-728138079.html or instead run this command:


git config --global credential.helper 'cache --timeout 3600'

# How to use
Copy both commit.sh and constants.sh to project's folder.

In constants.sh enter your password to bitbucket, no need to enter a newline (only passwords need to be enter, remove the comment currently present).

Once you have added the changes which you want to push, simply run commit.sh file.

For any problems faced please raise an issue.

Work in progress...
