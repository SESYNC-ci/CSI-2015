# Code versioning using Git



# Getting Started

1. Login to gitlab.sesync.org

   The screen you are seeing is the main welcome screen for gitlab. This shows you a list of projects you've subscribed to as well as recent updates.

2. Find our Git lesson repo

   In the upper right, search for 'git' and click on the ci_training/git_lessons link.

* This is a group that is part of the ci_training group at sesync. You can create (and we encourage you to) your own group and store your working group's projects in there.
* The repository link on the right gives you a quick link you can copy to other programs when you want to use the repository. There are two ways to access, ssh and http. If you're using a repository a lot, we recommend setting up ssh access to keep you from being asked for a password each time.
* The activity list shows what has been recently updated.
* Click on the commit and you'll see a list of what was changed during that revision.
** Term: revision, the delta between two different saves.

3. Fork a copy of the repository

   Click 'Fork' in the upper right and choose your own account when prompted.

   Term: 'Fork'. Forking allows you to create a personal copy of a repository. If you'd like, you can merge changes by pulling changes back into the master repository. For more information on what a complete workflow looks like using hte fork model, see the resources for Gitflow at the bottom.

   In most cases, your group will be working out of a single remote repository, so 'forking' will only be necessary if you're creating a local copy of some other code that you will be modifying.

## Create a local copy of your project

   Cloning is the process of creating a local copy of your repository. This is where you will do most of your local. You'll use this local copy to frequently save checkpoints. When you have completed a major feature or need to share your code, you will 'push' changes back to a central repository.
   Term: push - to send changes from your local repository to a remote, hosted one.

1. On your main project page, select 'http' on the right and copy the http://gitlab...git link.
2. Open up rstudio and create a new project (File -> New Project). 
3. Choose 'Version Control', 'Git', and paste the url you copied in step 1. You can accept the default values for the other items.

## Create a README file

   To demonstrate the git workflow, we're going to start by adding a 'readme' file to the repository. Readme files are special in github and gitlab as they are automatically displayed when someone opens up your repository. You can format your file by using markdown syntax. 

1. Go to File -> New text file
2. Add content to your new file.
3. Save your new file as 'readme.md'

## Commit your changes

## Push your Changes

## Pull changes

# Resources

* Gitflow, a workflow using github/lab type services: http://www.dalescott.net/2012/09/14/using-gitflow-with-githubs-fork-pull-model/
* Markdown reference: http://daringfireball.net/projects/markdown/
