# Set up the prompt

autoload -Uz promptinit
promptinit
prompt adam1


# Use vi keybindings.
bindkey -v


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
# Aliases
alias la='ls -lah --color=auto'
alias lh='ls -lh --color=auto'
alias ls='ls --color=auto'
alias l='ls --color=auto'
alias grep='grep --color=auto'
alias fd=fdfind
export MOLECULE_DISTRO=debian10
export ANSIBLE_VAULT_PASSWORD_FILE=~/.vault_pass.txt
export GOPATH=~/.local/share/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.cargo/bin

# Keybindings for substring search plugin. Maps up and down arrows.
bindkey -M main '^[OA' history-substring-search-up
bindkey -M main '^[OB' history-substring-search-down
bindkey -M main '^[[A' history-substring-search-up
bindkey -M main '^[[B' history-substring-search-up
#
# # Keybindings for autosuggestions plugin
bindkey '^ ' autosuggest-accept
bindkey '^f' autosuggest-accept
#
# # Gray color for autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=247'
#
# # fzf settings. Uses sharkdp/fd for a faster alternative to `find`.
FZF_CTRL_T_COMMAND='fd --type f --hidden --exclude .git --exclude .cache'
FZF_ALT_C_COMMAND='fd --type d --hidden --exclude .git'
#
ZSH_THEME="gruvbox"
# Load plugins
export ZPLUG_HOME=~/.local/share/zsh/zplug
source $ZPLUG_HOME/init.zsh
zplug "woefe/wbase.zsh"
zplug "woefe/git-prompt.zsh", use:"{git-prompt.zsh,examples/wprompt.zsh}"
zplug "junegunn/fzf", use:"shell/*.zsh"
zplug "junegunn/fzf-bin", from:gh-r, as:command, rename-to:fzf,
# use:"*linux*amd64*"
zplug "sharkdp/fd", from:gh-r, as:command, rename-to:fd,
# use:"*x86_64-unknown-linux-gnu.tar.gz"
zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "zsh-users/zsh-history-substring-search", defer:3
zplug load
# Keep 1000 lines of history within the shell and save it to ~/.zsh_history:
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000
export SAVEHIST=1000000000
export HISTFILE="${HOME}/.local/share/zsh/history"
# Record history at once and not after shell exit
setopt INC_APPEND_HISTORY
export HISTTIMEFORMAT="[%F %T] "
# Record timestamps in history
setopt EXTENDED_HISTORY

# Use modern completion system
autoload -Uz compinit
compinit -d "{HOME}/.local/share/zsh/zcompdump"

