# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1


# Use vi keybindings.
bindkey -v

# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export HISTFILE="${HOME}/.local/share/zsh/history"
# Record history at once and not after shell exit
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
# Record timestamps in history
setopt EXTENDED_HISTORY

# Use modern completion system
autoload -Uz compinit
compinit -d "{HOME}/.local/share/zsh/zcompdump"

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
#!/bin/zsh

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:$(du "$HOME/.local/bin/" | cut -f2 | paste -sd ':')"
# Default programs:
export EDITOR="nvim"
#export TERMINAL="st"
export BROWSER="chrome"

# ~/ Clean-up:
export LESSHISTFILE="-"
export WGETRC="${HOME}/.config/wget/wgetrc"
export INPUTRC="${HOME}/.config/inputrc"
export ZDOTDIR="${HOME}/.config/zsh"
export ANSIBLE_CONFIG="${HOME}/.config/ansible/ansible.cfg"
export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_DEFAULT_PROVIDER="virtualbox"
export VAGRANT_WSL_WINDOWS_ACCESS_USER_HOME_PATH="/c/vagrant"

fe() {find . \( ! -regex '.*/\..*' \) -type f | fzf --preview 'bat --style=numbers --color=always {}' | xargs -r $EDITOR}
fp() {find . \( ! -regex '.*/\..*' \) -type f | fzf --preview 'bat --style=numbers --color=always {}' | xargs -r $PAGER}
fcd() {cd `find . \( ! -regex '.*/\..*' \) -type d | fzf`}
ms() {apropos .| fzf --preview 'echo {}| awk "{print $1}"| xargs man' | awk '{print $1}' | xargs man}
if type rg &> /dev/null; then
  export FZF_DEFAULT_COMMAND='rg --files'
  export FZF_DEFAULT_OPTS='-m --height 50% --border'
fi

export MOLECULE_DISTRO=debian10
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
