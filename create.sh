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

# check if new_dir flag is set
if [ -z "$new_dir" ]; then
  echo "Error: No directory name provided"
  exit 1
fi

# check if new_dir is template
if [ "$new_dir" = "template" ]; then
  echo "Error: new_dir value cannot be 'template'"
  exit 1
fi

# replace spaces with underscores for new_dir
new_dir=${new_dir// /_}

# print dry run message if flag is set
if [ $dry_run -eq 1 ]; then
  echo "Dry run: cp -r template $new_dir"
  echo "Dry run: mv -r template/template.adoc $new_dir/$new_dir.adoc"
else
  # copy template directory to new directory
  if [ $verbose -eq 1 ]; then
    cp -rv template $new_dir
  else
    cp -r template $new_dir
  fi
  # rename template.adoc to new_dir.adoc
  mv $new_dir/template.adoc $new_dir/${new_dir}.adoc
  # check if copy was successful
  if [ $? -eq 0 ]; then
    echo "Directory template successfully copied to $new_dir and template.adoc has been renamed to ${new_dir}.adoc"
  else
    echo "Error: Failed to copy directory"
  fi
fi

