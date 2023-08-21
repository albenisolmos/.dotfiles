if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$HOME/.cargo/env" ]; then
	source "$HOME/.cargo/env"
fi

PATH="$HOME/.local/share/pnpm:$PATH"
PATH="$HOME/.cargo/bin:$PATH"

export COLORTERM=truecolor
export KEYTIMEOUT=1
export WWW_HOME="http://duckduckgo.com"
export GTK_OVERLAY_SCROLLING=0
export EDITOR="nvim"
export OPENER="xdg-open"
export KEYBOARD_LAYOUT="colemak"
export PNPM_HOME=""
export PATH
export ZDOTDIR=~/.config/zsh

if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
	tmux attach -t default || tmux new -s default
fi
