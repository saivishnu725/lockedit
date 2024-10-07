#!/bin/bash

#lockedit
# Author: The Unconcerned Ape // Sai Vishnu
# Website: theunconcernedape.me
# Github: https://github.com/saivishnu725/lockedit

# version option
VERSION(){
    echo "$0 v2.0" >&2
    exit 0
}

# help option
HELP(){
    echo "
    Usage: lockedit [options] [arguments]
    -f, --file:         input file
    -q, --quiet:        quiet outputs
    -v, --version:      version
    -c, --config:       configuration file
    -p, --pass:         use password for this file
    -t, --toggle:       toggles the file between mutable and immutable settings
    -l, --list:         lists all the files that are managed by lockedit
    -h, --help:         help menu
    -i, --interactive:  list of all the files to easily toggle
    -g, --get:          prints all the important variables with its value
    "
    exit 0
}


# TODO: arguments
# long options
shift $((OPTIND - 1))
while [[ $# -gt 0 ]]; do
  case "$1" in
    --file) FILE="$2"; shift 2 ;;
    --version) VERSION; shift 0;;
    --config) CONFIG_FILE="$2"; shift 2 ;;
    --help) HELP; shift 0;;
    *) echo "Unknown option: $1" >&2; exit 1 ;;
  esac
done
# short options
while getopts "f:vc:h" opt; do
  case $opt in
    f) FILE="$OPTARG" ;;
    v) VERSION;;
    c) CONFIG_FILE="$OPTARG" ;;
    h) HELP;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
    :) echo "Option -$OPTARG requires an argument." >&2; exit 1 ;;
  esac
done

# TODO: make file immutable without editing
# TODO: make file mutable without editing
# TODO: quiet mode
# TODO: error/edge case handling

# load config
load_config "$CONFIG_FILE"

# check if the file exists
if [[ -z $FILE ]]; then
  echo "Error: File path is required." >&2
  exit 1
elif [[ ! -f $FILE ]]; then
  echo "Error: File does not exist: $FILE" >&2
  exit 1
else
  echo "File: $FILE"
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
