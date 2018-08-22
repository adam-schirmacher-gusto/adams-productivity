source `dirname ${BASH_SOURCE[0]}`/git-completion.bash

# Be sure to set this to your own GH API token @
export ghtoken="68a38200e9b19822b9acc7d56a3aa5c68a380b36"

# __git_complete is defined in git-completion.bash to allow us to use completion through aliases/functions
alias gs="git status";								__git_complete gs		_git_status
alias gb="git branch -vv";							__git_complete gb		_git_branch
alias gbr="git branch -r -vv";						__git_complete gbr		_git_branch
alias gbu="git branch -u";							__git_complete gbu		_git_branch
alias gcm="git commit -m";							__git_complete gcm		_git_commit
alias gca="git commit --amend";						__git_complete gca		_git_commit
alias grne="git revert --no-edit";					__git_complete grne		_git_revert
alias gl="git log";									__git_complete gl		_git_log
alias glns="git log --name-status";					__git_complete glns		_git_log
alias glo="git log --oneline -20";					__git_complete glo		_git_log
alias glog="git log --oneline --graph";				__git_complete glog		_git_log
alias glons="git log --oneline -20 --name-status";	__git_complete glons	_git_log
alias gch="git checkout";							__git_complete gch		_git_checkout
alias gchb="git checkout -b";						__git_complete gchb		_git_checkout
alias grs="git reset --soft";						__git_complete grs		_git_reset
alias grm="git reset --mixed";						__git_complete grm		_git_reset
alias grh="git reset --hard";						__git_complete grh		_git_reset
alias gfa="git fetch --all --prune";				__git_complete gfa		_git_fetch
alias gd="git diff";								__git_complete gd		_git_diff
alias gdc="git diff --cached";						__git_complete gdc		_git_diff
alias gai="git add -i";								__git_complete gai		_git_add
alias gau="git add -u";								__git_complete gau		_git_add
alias ga="git add";									__git_complete ga		_git_add
alias gpr="git pull --rebase";						__git_complete gpr		_git_pull
alias gsh="git show";								__git_complete gsh		_git_show
alias gshns="git show --name-status";				__git_complete gshns	_git_show
alias gcane="git commit --amend --no-edit";			__git_complete gcane	_git_commit
alias gcp="git cherry-pick";						__git_complete gcp		_git_cherry_pick
alias gri="git rebase -i";							__git_complete gri		_git_rebase
alias glns="git log --name-status";					__git_complete glns		_git_log
alias gsu="git submodule update";					__git_complete gsu		_git_submodule
alias gp="normal-push-ref";							__git_complete gp		_git_push
alias gpf="force-push-ref";							__git_complete gpf		_git_push
alias gcdfx="git clean -dfx";						__git_complete gcdfx	_git_clean

# Push functions for force and normal push
normal-push-ref () { ref=${1:-HEAD}; git push origin "$ref":`git rev-parse --abbrev-ref HEAD`; }
force-push-ref () { ref=${1:-HEAD}; git push -f origin "$ref":`git rev-parse --abbrev-ref HEAD`; }

# Push function that pushes to remote branch matching current branch name
push-with-branchname () { git push "$@" origin `git rev-parse --abbrev-ref HEAD`; }

# Reset hard to the upstream branch
grhu () { grh `git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD)`; }
