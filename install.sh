#!/bin/bash

# set default values for flags
dry_run=0
verbose=0
new_dir=""

# process flags
while getopts ":dvn:" opt; do
  case $opt in
    d) dry_run=1 ;;
    v) verbose=1 ;;
    n) new_dir=$OPTARG;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

if [ -z "$new_dir" ]; then
  echo "Error: No directory name provided"
  exit 1
fi

if [ $dry_run -eq 1 ]; then
  echo "Dry run: cp -r template $new_dir"
else
  if [ $verbose -eq 1 ]; then
    cp -rv template $new_dir
  else
    cp -r template $new_dir
  fi
  if [ $? -eq 0 ]; then
    echo "Directory template successfully copied to $new_dir"
  else
    echo "Error: Failed to copy directory"
  fi
fi

