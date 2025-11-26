# Custom version of ohmyzsh/git
# https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh

# Get the default branch name from common branch names or fallback to remote HEAD
function git_main_branch() {
  command git rev-parse --git-dir &>/dev/null || return
  
  local remote ref
  
  for ref in refs/{heads,remotes/{origin,upstream}}/{main,trunk,mainline,default,stable,master}; do
    if command git show-ref -q --verify $ref; then
      echo ${ref:t}
      return 0
    fi
  done
  
  # Fallback: try to get the default branch from remote HEAD symbolic refs
  for remote in origin upstream; do
    ref=$(command git rev-parse --abbrev-ref $remote/HEAD 2>/dev/null)
    if [[ $ref == $remote/* ]]; then
      echo ${ref#"$remote/"}; return 0
    fi
  done

  # If no main branch was found, fall back to master but return error
  echo master
  return 1
}

alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gb='git branch'
alias gba='git branch --all'
alias gbd='git branch --delete'
alias gbD='git branch --delete --force'

function gbda() {
  # Add extra protected branches
  git branch --no-color --merged | command grep -vE "^([+*]|\s*($(git_main_branch)|pqa|production)\s*$)" | command xargs git branch --delete 2>/dev/null
}

alias gco='git checkout'
alias gcb='git checkout -b'
alias gcm='git checkout $(git_main_branch)'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcam='git commit --all --message'
alias gcmsg='git commit --message'
alias gc!='git commit --amend'
alias gcf='git commit --fixup'
alias gd='git diff'
alias gdc='git diff --cached' # Renamed from original
alias gds='git diff --staged'
alias gf='git fetch'
alias glg='git lg' # Custom log format
alias gm='git merge'
alias gmff="git merge --ff-only"
alias gl='git pull'
alias gpr='git pull --rebase'
alias gp='git push'
alias gp!='git push --force'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase --interactive'
alias grbs='git rebase --skip'
alias grs='git restore'
alias grss='git restore --source'
alias grst='git restore --staged'
alias gstp='git stash push'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gt='git tag' # Renamed from original
alias gtv='git tag | sort -V'
alias gst='git status'
