info 'opening files'
for file_source in $(dotfiles_find install.open); do
  OLD_IFS=$IFS
  IFS=$'\n'
  basedir="$(dirname $file_source)"
  for file in `cat $file_source`; do
    canonical_file="$basedir/$file"
    open_file "$canonical_file"
  done
  IFS=$OLD_IFS
done