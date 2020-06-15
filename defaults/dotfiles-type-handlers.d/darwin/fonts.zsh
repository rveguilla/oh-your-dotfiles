fonts_dir="$HOME/Library/Fonts"

for file_source in $(dotfiles_find \*.otf); do
  file_dest="$fonts_dir/$(basename $file_source)"
  install_file copy $file_source $file_dest
done
for file_source in $(dotfiles_find \*.ttf); do
  file_dest="$fonts_dir/$(basename $file_source)"
  install_file copy $file_source $file_dest
done
for file_source in $(dotfiles_find \*.ttc); do
  file_dest="$fonts_dir/$(basename $file_source)"
  install_file copy $file_source $file_dest
done