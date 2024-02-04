#!/usr/bin/env bash

# Set default value
default_notes_path="~/Documents/notes"

# Check if the environment variable is set
if [ -n "$NOTES_PATH" ]; then
    # Use the value from the environment variable
    notes_path="$NOTES_PATH"
else
    # Use the default value
    notes_path="$default_notes_path"
fi

if [[ $# -eq 2 ]]; then
    selected=$2
else
    selected=$({ 
    echo "~"
    echo "$notes_path"
    echo " ~/dev"
    find ~/dev -mindepth 1 -maxdepth 1 -type d  
  }| fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

echo $selected
# add a path to the selected variable

if [[ $selected == "~" ]]; then
selected_name="home" 
else
selected_name=$(basename "$selected" | tr . _)
fi

tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name
