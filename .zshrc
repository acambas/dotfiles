# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Set default encoding to UTF-8
export LANG=en_US.UTF-8

# Use nvim as the default editor
export EDITOR="nvim"

export PATH=/usr/local/bin:/System/Cryptexes/App/usr/bin:/usr/bin:/bin:/usr/sbin:/sbin -
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(git aws fzf)

source $ZSH/oh-my-zsh.sh

# load secrets
[ -f ~/.secrets.sh ] && source ~/.secrets.sh


export PATH=$PATH:/Users/aleksandarcambas/.local/bin
export PATH=$PATH:~/.volta/bin/
export PATH=$PATH:~/go/bin/
# ---------------------------- aliases ----------------------------

# General
alias reload="source ~/.zshrc"
alias c="clear"
alias hg="history 0 | grep"
alias lg="lazygit"

# Config
alias config.zsh="vim ~/.zshrc"
alias config.tmux="nvim ~/.tmux.conf"
alias config.wezterm="nvim ~/.wezterm.lua"
alias config.vim="nvim ~/.config/nvim -c 'cd ~/.config/nvim'"
alias config.secrets="nvim ~/.secrets.sh"
alias config.macos="nvim ~/macos.sh"

# Vim
alias vi="nvim"
alias vim="nvim"
alias v.="vim ."

# cd
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# zoxide
alias cd="z"


# Tmux
alias tn="tmux new -d -s"
alias ta="tmux a -t"
alias tl="tmux ls"
alias tk="tmux kill-session -t"
alias td="tmux detach -t"
alias ts="tmux switch-client -t"
alias tss="~/tmux-sessionizer.sh"

# zig
# alias zig="~/dev/zig/zig"


if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach -t home || tmux new -s home -c $HOME
fi

# bun completions
[ -s "/Users/aleksandarcambas/.bun/_bun" ] && source "/Users/aleksandarcambas/.bun/_bun"

# eval "$(starship init zsh)"
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
# source /opt/homebrew/share/zsh-vi-mode/zsh-vi-mode.zsh

# ---- Zoxide (better cd) ----
eval "$(zoxide init zsh)"
