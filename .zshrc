# Plugins
source /usr/share/zsh-antidote/antidote.zsh
antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt

# Plugins installed through APT
eval "$(atuin init zsh)"
eval "$(dircolors -b)"
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

# Completion
autoload -Uz compinit
compinit

zstyle ':completion:*:*:docker-*:*' option-stacking yes
zstyle ':completion:*:*:docker:*' option-stacking yes
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias zz='z $(git rev-parse --show-toplevel || echo .)'
