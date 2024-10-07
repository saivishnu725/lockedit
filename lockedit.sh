#!/bin/bash

#lockedit
# Author: The Unconcerned Ape // Sai Vishnu
# Website: theunconcernedape.me
# Github: https://github.com/saivishnu725/lockedit

# load config
USER_CONFIG_FILE="$HOME/.config/lockedit/lockedit.conf"
GLOBAL_CONFIG_FILE="/etc/lockedit/lockedit.conf"
# TODO: make config file template and save it in the path. use it to make more stuff happen
if [ -f "$USER_CONFIG_FILE" ]; then
    . "$USER_CONFIG_FILE"

    echo "Using user configuration file: $USER_CONFIG_FILE"
elif [ -f "$GLOBAL_CONFIG_FILE" ]; then
    . "$GLOBAL_CONFIG_FILE"
    echo "Using global configuration file: $GLOBAL_CONFIG_FILE"
else
    echo "No configuration file found. Please ensure that either $USER_CONFIG_FILE or $GLOBAL_CONFIG_FILE exists."
    exit 1
fi

# check if filename is provided
if [ -z "$1" ]; then
	echo "Usage: $0 <file_path>"
	exit 1
fi

# file to edit
FILE="$1"
# program name
PROG_NAME="lockedit"
# directory to store list
LOG_DIR="/etc/$PROG_NAME"
# log file
LOG_FILE="$LOG_DIR/list"

# check if the file exists
if [ ! -f "$FILE" ]; then
	echo "Error: File $FILE does not exist."
	exit 1
fi

# create directory and log file if it does not exists, ensure it is accessible
sudo mkdir -p "$LOG_DIR"
sudo touch "$LOG_FILE"
sudo chmod 644 "$LOG_FILE"

echo "editor: $EDITOR "

# check if $EDITOR is set
if [ -z "$EDITOR" ]; then
    echo "\$EDITOR is not set. Checking for available editors..."

    # list of potential editors
    EDITORS=("nano" "vim" "nvim" "vi" "emacs" "gedit")
    for editor in "${EDITORS[@]}"; do
        if command -v "$editor" &> /dev/null; then
            echo "Using $editor as the editor."
            EDITOR="$editor"
            break
        fi
    done

    # check if an editor was found
    if [ -z "$EDITOR" ]; then
        echo "No available text editors found."
        echo "Please set your \$EDITOR variable in your .bashrc or .zshrc and rerun the program."
        exit 1
    fi
fi

# remove immutable flag
sudo chattr -i "$FILE"
# edit the file
$EDITOR "$FILE"
# make the file immutable
sudo chattr +i "$FILE"

# append to LOG_FILE if not already logged
grep -qxF "$FILE" "$LOG_FILE" || echo "$FILE" | sudo tee -a "$LOG_FILE" > /dev/null

# finishing message
echo "File $FILE has been edited and made immutable. Logged to $LOG_FILE."
