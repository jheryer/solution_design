#!/bin/bash

dry_run=0
verbose=0
new_dir=""

while getopts ":dvn:" opt; do
  case $opt in
    d) dry_run=1 ;;
    v) verbose=1 ;;
    n) new_dir=$OPTARG;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1 ;;
  esac
done

if [ -z "$new_dir" ]; then
  echo "Error: No project name provided use -n <project name>"
  exit 1
fi

if [ "$new_dir" = "template" ]; then
  echo "Error: new_dir value cannot be 'template'"
  exit 1
fi

new_dir=${new_dir// /_}

if [ $dry_run -eq 1 ]; then
  echo "Dry run: cp -r template $new_dir"
  echo "Dry run: mv -r template/template.adoc $new_dir/$new_dir.adoc"
else
  if [ $verbose -eq 1 ]; then
    cp -rv template $new_dir
  else
    cp -r template $new_dir
  fi
  mv $new_dir/template.adoc $new_dir/${new_dir}.adoc
  if [ $? -eq 0 ]; then
    echo "Project successfully copied to $new_dir and  ${new_dir}.adoc has been created"
    echo "to generate a sample PDF simply run: asciidoctor -b pdf -r asciidoctor-pdf  ${new_dir}/${new_dir}.adoc "
  else
    echo "Error: Failed to copy directory"
  fi
fi

