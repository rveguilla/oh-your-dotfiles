# preferences
for file_source in $(dotfiles_find \*.plist); do
  file_dest="$HOME/Library/Preferences/`basename $file_source`"
  install_file copy $file_source $file_dest
done
