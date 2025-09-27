#    _               _
#   | |__   __ _ ___| |__  _ __ ___
#   | '_ \ / _` / __| '_ \| '__/ __|
#  _| |_) | (_| \__ \ | | | | | (__
# (_)_.__/ \__,_|___/_| |_|_|  \___|
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return
parse_git_branch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

PS1='\[\e[31m\]\u\[\e[0m\]\[\e[32m\]@\h:\w\$\[\e[0m\]\[\e[90m\] $(parse_git_branch)\[\e[00m\]\n> '

# -----------------------------------------------------
# Fastfetch if in Hyprland
# -----------------------------------------------------
if [[ $(tty) == *"pts"* ]]; then
    fastfetch
else
    echo
    echo "Start Hyprland with command Hyprland"
fi

# -----------------------------------------------------
# If bash_aliases
# -----------------------------------------------------
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# -----------------------------------------------------
# Activate a base python env
# -----------------------------------------------------
export LD_LIBRARY_PATH=/opt/rocm/lib:$LD_LIBRARY_PATH
export PATH="/opt/rocm/bin":$PATH
export PATH="/home/$USER/.local/bin/bin":$PATH
eval "$(fzf --bash)"

function echo-alias-venv() {
    local dir=$1
    local temp_alias="/home/$USER/.python_envs_aliases"
    if [[ -f "$temp_alias" ]]; then
        rm -rf "$temp_alias"
    fi
    pushd "$dir" > /dev/null
    echo "List of python environments:"
    local counter=1
    for entry in *; do
        if [[ -d "$entry" && ! -L "$entry" ]]; then
            echo "$counter: $entry -> $dir$entry"
            ((counter++))
            local alias_str="alias $entry='source $dir/$entry/bin/activate'"
            echo "$alias_str" >> "$temp_alias"
        fi
    done
    source "$temp_alias"
    rm -rf "$temp_alias"
    popd > /dev/null
}

function venv() {
    # ask user for search directory
    read -e -p "Enter the directory to search for python environments: " dir
    dir="${dir/#\~/$HOME}"
    if [[ ! -d "$dir" ]]; then
        echo "Directory $dir does not exist."
        return 1
    fi
    echo-alias-venv "$dir/"
}

. "$HOME/.cargo/env"

# -----------------------------------------------------
# Enable shell options for autocd and cdspell
# -----------------------------------------------------
shopt -s autocd
shopt -s cdspell

