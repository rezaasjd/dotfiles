#!/usr/bin/bash
languages=`echo "golang lua cpp c python rust zig bash" | tr ' ' '\n'`
utilities=`echo "pip bsub ssh vim xarg find fd-find grep rg sed awk" | tr ' ' '\n'`

selected=`printf "$languages\n$utilities" | fzf`

if [[ -z $selected ]]; then
    exit 0
fi

read -p "Enter Query: " query

if pritnf "$languages" | grep -qs $selected; then
    query=`echo $query | tr ' ' '+'`
    tmux neww bash -c "echo \"curl cht.sh/$selected/$query/\" & curl cht.sh/$selected/$query & while [ : ]; do sleep 1; done"
else
    tmux neww bash -c "curl -s cht.sh/$selected~$query | less -r"
fi
