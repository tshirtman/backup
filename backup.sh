#!/usr/bin/env bash
set -ex

DIR=/mnt/storage_1to/BACKUPS

cd $DIR
sources=$(cat sources)

for source in $sources
do
  echo "backing up $source"
  host=$(echo $source|sed -s 's/:.*$//')
  dest=$(echo $source|sed -s 's/^.*:\///')
  mkdir -p $DIR/$dest.incomplete

  link_dest_candidate=$(ls -d $DIR/$dest.* | egrep -v '.incomplete$'| sort | tail -n 1)

  if [[ $link_dest_candidate ]]; then
    link_dest="--link-dest=$link_dest_candidate"
  fi

  rsync \
    --exclude=.gvfs \
    --archive \
    --one-file-system \
    --hard-links \
    --human-readable \
    --inplace \
    --numeric-ids \
    --delete \
    --delete-excluded \
    --exclude-from=$DIR/excludes.txt \
    $link_dest \
    $extra_opts \
    $source $DIR/$dest.incomplete || echo "rsync termined with errors"

  mv $DIR/$dest.incomplete $DIR/$dest.$(date -Iseconds)
done
