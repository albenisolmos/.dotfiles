DISABLE_AUTO_UPDATE="true"
export ZDOTDIR=$HOME/.config/zsh

stty stop undef # Disable ctrl-s to freeze terminal.
source "$ZDOTDIR/functions"

alias poweroff="sudo systemctl poweroff"
alias logout="kill -9 -1"
alias g="git"
alias v="nvim"
alias s="sudo"
alias ihasw="ping www.google.com"
alias ifind="find . -type f | xargs grep -l"
alias pnp="pnpm"
alias ta="tmux attach"
alias tad="tmux attach -t default || tmux new -s default"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Load version control information
autoload -Uz vcs_info
precmd() { vcs_info }
# enable only git
zstyle ':vcs_info:git:*' formats ' %F{#8c7e6a}%b |'

setopt PROMPT_SUBST
PROMPT=" %F{#8c7e6a}%~ "
PROMPT+="%B%(0?.%F{5}.%F{red})$ %{$reset_color%}"

autoload -U colors && colors # colors
zle_highlight=('paste:none')

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line 

#setopt histappend # append and no overwrite history
setopt menu_complete
unsetopt BEEP
zle_highlight=('paste:none')

setopt inc_append_history share_history
export SAVEHIST=1000  # Save most-recent 1000 lines
export HISTFILE=~/.zsh_history
export HISTTIMEFORMAT="[%F %T] "

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
zstyle ':vcs_info:git:*' formats '%b' #Format the vcs_info_msg_0_ variable

zmodload zsh/complist
compinit
_comp_options+=(globdots) # Include hidden files.

bindkey -v #vi mode
bindkey '^e' edit-command-line
# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey -M menuselect '^M' .accept-line
bindkey -s '^o' 'lfcd\n'

_zlf() {
    emulate -L zsh
    local d=$(mktemp -d) || return 1
    {
        mkfifo -m 600 $d/fifo || return 1
        tmux split -bf zsh -c "exec {ZLE_FIFO}>$d/fifo; export ZLE_FIFO; exec lf" || return 1
        local fd
        exec {fd}<$d/fifo
        zle -Fw $fd _zlf_handler
    } always {
        rm -rf $d
    }
}
zle -N _zlf
bindkey '\ek' _zlf

_zlf_handler() {
    emulate -L zsh
    local line
    if ! read -r line <&$1; then
        zle -F $1
        exec {1}<&-
        return 1
    fi
    eval $line
    zle -R
}
zle -N _zlf_handler

autoload -Uz vcs_info
autoload -U colors && colors

# enable only git 
zstyle ':vcs_info:*' enable git 

[ -f "$HOME/.config/lf/lfcd.sh" ] && source "$HOME/.config/lf/lfcd.sh"
# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_completion "esc/conda-zsh-completion" false
zsh_add_plugin "sbugzu/gruvbox-zsh"
zsh_add_plugin "agkozak/zsh-z"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"
