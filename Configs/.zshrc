[[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]] &&
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"

path=("$HOME/bin" "$HOME/.local/bin" "$HOME/.cargo/bin" /usr/local/bin $path)
typeset -U path

HISTFILE="${XDG_STATE_HOME:-$HOME/.local/state}/zsh/history"
HISTSIZE=1000000000
SAVEHIST=1000000000
setopt hist_ignore_dups hist_ignore_space hist_reduce_blanks \
       share_history inc_append_history extended_history

autoload -Uz compinit
compinit -d "${XDG_CACHE_HOME:-$HOME/.cache}/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A'  up-line-or-beginning-search
bindkey '^[[B'  down-line-or-beginning-search
bindkey '^[[H'  beginning-of-line
bindkey '^[[F'  end-of-line
bindkey '^[[3~' delete-char
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word

_plugin_dir="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins"

_load_plugin() {
    local repo=$1 name=${1##*/}
    local dir="$_plugin_dir/$name"
    [[ -d $dir ]] || git clone --depth=1 "https://github.com/$repo" "$dir"
    source "$dir/$name.plugin.zsh" 2>/dev/null ||
    source "$dir/$name.zsh-theme"  2>/dev/null ||
    source "$dir/$name.zsh"
}

_load_plugin romkatv/powerlevel10k
_load_plugin zsh-users/zsh-autosuggestions
_load_plugin zsh-users/zsh-syntax-highlighting

alias ls="lsd"
alias find="fd"
alias cat="bat"
alias cp="xcp"
alias ff="fastfetch"
alias clck="tty-clock -c -s -b -C 7"

[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh
