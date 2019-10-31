## Contributing to the Project  

To keep things organized and follow general development practices, please make all contributions on your own unique branch, then when you would like to add your changes to the project, simply create a Pull Request!  

1. Follow the steps outlined in [README.md](https://github.com/dwatherton/Capstone-Project/blob/master/README.md) to get the project running locally.  

2. Once you have sucessfully ran the project, create a branch to do your work in (Make sure you are on the "master" branch when you do this! Created branches are an exact copy of the branch you are on when you create them).  
>* Type `git branch <BRANCH_NAME>` (green) into the PyCharm terminal. You can type `git branch -v` (yellow) to see all branches that exist, as well as the currently active branch (red).   

>![git branch](https://imgur.com/1xOlgbN.png)

3. Checkout the branch you just created.  
>* Type `git checkout <BRANCH_NAME>` into the PyCharm terminal. You will be shown that the branch has been switched to.   

>![git checkout](https://imgur.com/5136Pfz.png)

4. Make changes you would like reflected in the projects code.  
>* Create, modify, or remove files/code on the new branch.  

>![make changes](https://imgur.com/GZgcBt4.png)

5. After making your changes, check which files have been modified and which files are tracked.  
>* Type `git status` (green) into the PyCharm terminal to view changes, and check if they are tracked or untracked (yellow). All changed files will appear (red).  

>![git status](https://imgur.com/nhNTOaD.png)

6. Any files listed above that have red font color need to be added to git to be tracked.  
>* Type `git add <FILE_NAME>` (green) into the PyCharm terminal for each file you'd like to commit (yellow). Make sure to type the FILE_NAME exactly as it appears (red)! If you'd like to add all of the files that were listed to be tracked you can use `git add *`, though sometimes it will add files you did not intend to. As a rule of thumb, don't add a file if you did not intend for it to be changed.  

>![git add](https://imgur.com/xuTRM94.png)

7. After adding files to git to be tracked, commit your changes.  
>* Type `git commit -m "<ENTER_YOUR_COMMIT_MESSAGE_HERE>"` into the PyCharm terminal.  

>![commit](https://imgur.com/nw4b786.png)

8. At this point you have saved changes LOCALLY, for changes to be made to the main repository (master branch), you will need to push the branch up to GitHub and create a pull request.  
>* Type `git push origin <BRANCH_NAME>` into the PyCharm terminal to push the branch up to GitHub (You can [click here](https://github.com/dwatherton/Capstone-Project/branches) to verify the branch is on GitHub.  

>![push](https://imgur.com/B1KRTTs.png)

>![branches](https://imgur.com/SZ7ahPY.png)

9. Now that the branch is up on GitHub, [create a pull request](https://github.com/dwatherton/Capstone-Project/compare?expand=1)!  
>* Make sure that the base branch is master (red), and that the compare branch is the branch you have done your work on (yellow). You can view the changes, and if they can be automatically merged (green), then click "Create Pull Request" (blue)!  

>![pull request](https://imgur.com/hiyFd6l.png)

#### That's all it takes to contribute! Once you have created a Pull Request, it will be reviewed and merged given everything looks alright!  

#  

**Important Note: It's a good idea to keep your local branches up-to-date so that when you create a branch and/or get ready to add and commit changes, only your changes are tracked. In some cases, creating a Pull Request on an out-of-date branch can result in the changes showing that code has been deleted, when in reality it hasn't been deleted, the branch's git history is just behind the repositories master branch history.**  

#

>If your branch is out-of-date, but you have made changes and are ready to commit, follow these steps to update your master branch and merge the updates to the out-of-date branch:

#### Update your local master branch

1. `git checkout master` to checkout the local master branch
2. `git fetch origin` to fetch remote changes made to the repository
3. `git merge origin/master` to merge remote changes into your local master branch

#### Update the out-of-date branch

1. `git checkout BRANCH_NAME` to checkout the out-of-date branch
2. `git merge master` to merge the out-of-date branch to include the remote changes that were merged into your local master branch
3. `git push origin BRANCH_NAME` to push the updated branch with your changes made on it to GitHub

