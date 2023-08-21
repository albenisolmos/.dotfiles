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
PROMPT='${vcs_info_msg_0_} %F{#8c7e6a}%~ %B%(0?.%F{5}.%F{red})$ %{$reset_color%}'

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

# Plugins
[ -f "$HOME/.config/lf/lfcd.sh" ] && source "$HOME/.config/lf/lfcd.sh"
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_completion "esc/conda-zsh-completion" false
zsh_add_plugin "dracula/zsh-syntax-highlighting"
#-------------------------
export ZDOTDIR=$HOME/.config/zsh

stty stop undef # Disable ctrl-s to freeze terminal.
source "$ZDOTDIR/functions"
zsh_add_file "aliases"
#zsh_add_file "prompt"

autoload -U colors && colors # colors
zle_highlight=('paste:none')

# Edit line in vim with ctrl-e:
autoload edit-command-line
zle -N edit-command-line 

#setopt histappend # append and no overwrite history
setopt menu_complete
unsetopt BEEP
zle_highlight=('paste:none')

# Basic auto/tab complete:
autoload -Uz compinit
zstyle ':completion:*' menu select
#zstyle ':completion:*' file-sort modification
#zstyle ':completion:*:*:cp:*' file-sort size
#zstyle ':completion:*' completer _expand_alias _complete _ignored
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

autoload -Uz vcs_info
autoload -U colors && colors

# enable only git 
zstyle ':vcs_info:*' enable git 

# setup a hook that runs before every ptompt. 
#precmd_vcs_info() { vcs_info }
#precmd_functions+=( precmd_vcs_info )
#setopt prompt_subst
#
#zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#+vi-git-untracked() {
#	if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
#		git status --porcelain | grep '??' &> /dev/null ; then
#		# This will show the marker if there are any untracked files in repo.
#		# If instead you want to show the marker only if there are untracked
#		# files in $PWD, use:
#		#[[ -n $(git ls-files --others --exclude-standard) ]] ; then
#		hook_com[staged]+='!' # signify new files with a bang
#	fi
#}
#
#zstyle ':vcs_info:*' check-for-changes true
#zstyle ':vcs_info:git:*' formats "%b %m%u%c"

PROMPT=" %F{#8c7e6a}%~ "
PROMPT+="%B%(0?.%F{5}.%F{red})$ %{$reset_color%}"
# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[6 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[6 q"
}
zle -N zle-line-init

echo -ne '\e[6 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[6 q' ;} #Use beam shape cursor new prompt.

[ -f "$HOME/.config/lf/lfcd.sh" ] && source "$HOME/.config/lf/lfcd.sh"
# Plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_completion "esc/conda-zsh-completion" false
zsh_add_plugin "sbugzu/gruvbox-zsh"
#zsh_add_plugin "dracula/zsh-syntax-highlighting" "dracula"

zsh_add_plugin "zsh-users/zsh-syntax-highlighting"

# pnpm
export PNPM_HOME="/home/olmos/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
