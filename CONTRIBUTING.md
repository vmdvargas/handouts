# Welcome to a SESYNC Training Event

This document explains how to create and contribute to your own GitHub repository comprised of the event's worksheets. The steps below use the git version control system and the RStudio IDE.

1. **Configure git**
1. **Create a new project in RStudio**
1. **Create a RSA Key Pair (Recommended)**
1. **Sync to a corresponding repository on GitHub**

## 1. Configure git

The first time you work with git on your computer, you should tell it your name and email address. This populates the author metadata associated with your commits. GitHub will associate commits with user accounts by matching e-mail addresses, so use the same one! From a terminal (e.g. RStudio's "Tools > Terminal"), execute the following two lines with appropriate substitutions for your name and email:

    git config --global user.name "J. Doe"
    git config --global user.email jdoe@email.com
    

## 2. Create a new project in RStudio

Download the ZIP archive of the [handouts], unzip them to an appropriate location, and rename the folder containing the worksheets to whatever name you like for your project/repository. In RStudio, choose "File > New Project > Existing Directory", browse to the newly-named folder, and clicke "Create Project".

## 3. Add version control

In RStudio, choose "Tools > Version Control > Project Setup ..." and select "git" for your version control system. Yes, you do want to initialize a new repo. Yes, restart RStudio too. The new "Git" tab provides utilities for interacting with git (i.e. a simple git GUI).

Highlight all the files, check any box, wait for it, and then click "Commit". In the window that opens, enter a commit message (e.g. "initial commit") and click "Commit".

## 4. Create a RSA Key Pair (Recommended)

Setting up an RSA key pair between your GitHub account and your computer allows you to sync to your repository on GitHub without typing in a password. To set up a key pair, follow these detailed [instructions](http://adamwilson.us/RDataScience/GitSSHNotes.html#generating-a-ssh-key-in-rstudio) written out by Adam Wilson, a professor of Geography from the University at Buffalo.

## 5. Sync to a corresponding repository on GitHub

Login to your account on https://github.com. Click on the "+" sign and choose to create a new repository. Name the "repo" like your RStudio project, add a description (optional), and "Create repository". Now that the "origin" repository exists under your account on GitHub, you can pair it with your local "clone". Choose SSH or HTTPS and follow the instructions under "…or push an existing repository from the command line" using the RStudio terminal.

Commits in your RStudio project can now be pushed to (or pulled from) your GitHub repository.

[handouts]: https://github.com/sesync-ci/handouts/archive/latest.zip
