# git prompt
source ~/.git-prompt.sh
export PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
export PROMPT_COMMAND='__git_ps1 "\u@\h:\w" "\\\$ "'
export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM="auto"
export GIT_PS1_SHOWCOLORHINTS=true

# bazel completion
source /usr/share/bash-completion/completions/bazel

alias gjf='git show --diff-filter=AM --pretty="" --name-only HEAD | grep java$ | xargs -r google-java-format -i'
alias b='git show --diff-filter=AM --pretty="" --name-only HEAD | grep --regex "BUILD\|WORKSPACE" | xargs buildifier'
