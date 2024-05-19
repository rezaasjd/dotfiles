# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# make sure package manager is installed and source it (zinit in this case)
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit"
if [ ! -d "$ZINIT_HOME" ]; then
  mkdir -p "$(dirname $ZINIT_HOME)"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi
source "${ZINIT_HOME}/zinit.zsh"

# powerlevel10k plugin
zinit ice depth=1
zinit light romkatv/powerlevel10k

# syntax highlighting
zinit light zsh-users/zsh-syntax-highlighting

# fzf completion
zinit light Aloxaf/fzf-tab

# zsh completion
zinit light zsh-users/zsh-completions
autoload -U compinit && compinit

# ignore case when trying to complete
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# add color to zsh completion list
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Remove the default menu bc we have fzf
zstyle ':completion:*' menu no

# Remove the default menu bc we have fzf
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --colro $realpath'

# zoxide
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --colro $realpath'

# zsh suggestion like fish
zinit light zsh-users/zsh-autosuggestions
bindkey -e
bindkey "^o" autosuggest-accept
bindkey "^n" history-search-forward
bindkey "^p" history-search-backward

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Aliases
[ -f ~/.aliases.zsh ] && source ~/.aliases.zsh

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zsh history
HISTSIZE=8000
HISTFILE="$HOME/.zsh_history"
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# export some env variables just in case
export JAVA_HOME='/Users/reza/Library/Java/JavaVirtualMachines/corretto-17.0.5/Contents/Home'
export PATH=/opt/homebrew/Cellar/gcc/12.2.0/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# zoxide
eval "$(zoxide init zsh)"

# conda initialize
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/reza/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
  eval "$__conda_setup"
else
  if [ -f "/Users/reza/miniconda3/etc/profile.d/conda.sh" ]; then
    . "/Users/reza/miniconda3/etc/profile.d/conda.sh"
  else
    export PATH="/Users/reza/miniconda3/bin:$PATH"
  fi
fi
unset __conda_setup
# conda initialize
