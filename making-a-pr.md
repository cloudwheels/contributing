# Making a Pull Request (PR)

A basic overview of the process of contributing to another project.

## Prerequisites

- Git on your local machine
- Some understanding of using the command line
- Knowledge of the project you want to work on!

It is assumed you are using a unix type system.

## Variables

These variables can be replaced to customise the text

**{MY_USERNAME}** - Your github account name.

**{UPSTREAM_USERNAME}** -  Account name / organisation of original project.

**{PROJECT_NAME}** - Name of project.

**{BASE_BRANCH}** - Base branch of original project, ofter "master".

**{WORKING_BRANCH}** - The branch created to make you changes - should be specific to those changes and may follow naming conventions. e.g. hotfix/readme-updates.


## Process

1. Make fork on GH.

2. Clone your fork from github to local machine: 

`git clone https://github.com/{MY_USERNAME}/{PROJECT_NAME}.git`

> ```
> Cloning into '{PROJECT_NAME}'...
> remote: Enumerating objects: 260, done.
> remote: Counting objects: 100% (260/260), done.
> remote: Compressing objects: 100% (125/125), done.
> remote: Total 260 (delta 130), reused 254 (delta 127), pack-reused 0
> Receiving objects: 100% (260/260), 33.12 KiB | 0 bytes/s, done.
> Resolving deltas: 100% (130/130), done.
> ```

3. Change into the {PROJECT_NAME} directory:

`cd {PROJECT_NAME}`

4. Add original repo as a remote named 'upstream':

`git remote add upstream https://github.com/{UPSTREAM_USERNAME}/{PROJECT_NAME}.git`

You now have two remotes for this project on disk:
- `origin` which points to your GitHub fork of the project. You can read and write to this remote.
- `upstream` which points to the main project’s GitHub repository. You can only read from this remote.
You can check this by running:

`git remote`
  
> ```
> origin
> upstream
> ```

5. Create a local working branch for your changes.

The {BASE_BRANCH} is often but not always "master":

`git checkout {BASE_BRANCH}`

> ```
> Already on '{BASE_BRANCH}'
> Your branch is up-to-date with 'origin/{BASE_BRANCH}'.
> ```

6. Get the latest code form the upstream branch. You will need to enter your github password.

`git pull upstream {BASE_BRANCH} && git push origin {BASE_BRANCH}`

> ```
> From https://github.com/{UPSTREAM_USERNAME}/{PROJECT_NAME}
>  * branch            {BASE_BRANCH}     -> FETCH_HEAD
>  * [new branch]      {BASE_BRANCH}     -> upstream/{BASE_BRANCH}
> Already up-to-date.
> Username for 'https://github.com': {MY_USERNAME}
> Password for 'https://{MY_USERNAME}@github.com': 
> Everything up-to-date
> ```

7. Create & switch to working branch

`git checkout -b {WORKING_BRANCH}`

> ```
> Switched to a new branch '{WORKING_BRANCH}'
> ```

8. Make changes on this branch

9. Add & commit the changes with good quality commit messages

`git add .`

`git commit -m "commit message"`

10. (create &) Update (push to) the {WORKING_BRANCH} in the remote "origin" (github.com/{MY_USERNAME}/{PROJECT_NAME})

`git push -u origin {WORKING_BRANCH}`

11. CREATE PR in Github against the  {BASE_BRANCH} in the remote "upstream" (github.com/{UPSTREAM_USERNAME}/{PROJECT_NAME}). 

