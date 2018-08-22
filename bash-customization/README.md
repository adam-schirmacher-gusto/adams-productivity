# Bash Customizations

# ghpr *(github pull request)*

![ghpr screenshot](ghpr-old-pr-screenshot.png)

What just happened? I was chilling on a local branch called `mpl/eoy-emails/w2c` which tracked upstream branch `origin/development`. Then I ran `ghpr` and it auto-magically found the PR for this branch, echoed the URL, and opened the PR in my browser.

If I do the same thing with a branch that doesn't have a PR yet...

![ghpr screenshot](ghpr-new-pr-screenshot.png)

Then it asks me to enter a PR title, creates the PR and opens it in browser!

### Setup

`source` `ghpr.sh` somewhere in your `.bash_profile` or `.bashrc` where it'll get picked up when you start a terminal. Set your `ghtoken` within the file. Get it [here](https://github.com/settings/tokens).

Install `jq` with `brew install jq` and make sure it ends up in your PATH. `jq` is a command line utility to work with JSON.

Try it with `ghpr` while on a branch. Note that I haven't invested much into error checking - it's usually pretty obvious why something went wrong, for example if you're not in a git repo or not on a branch.

**Assumptions ghpr makes:**

* you want to push to the remote called `origin`
* your local branch tracks the upstream branch that you want to merge code into
    * i.e. if you want your code to get merged into `origin/development`, your local branch needs to track `origin/development`
* the name of your local branch matches the name you pushed it to in the remote repo
    * i.e. local branch `fix-for-119` is pushed to `origin` as `origin/fix-for-119`

# git aliases

This is my personal git alias setup. Everyone has their own preferences, so you may or may not find it useful. YMMV.

The key take-away is that **if you are experienced with git and still often typing full git commands, you can fix this!**.

A few things I'll point out as being very useful commands.

`gb` = more verbose `git branch`

![](gb-screenshot.png)

`gcane` = roll staged changes into HEAD commit

(*"oh crap, I should have included these changes in the last commit"*)

![](gcane-screenshot.png)

`gau` = `git add` all modified files

![](gau-screenshot.png)

`gshns` = show the files changed in a commit

![](gshns-screenshot.png)
