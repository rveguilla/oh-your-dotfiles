# launch agents
for file_source in $(dotfiles_find \*.launchagent); do
  file_dest="$HOME/Library/LaunchAgents/$(basename $file_source | sed 's/.launchagent//')"
  install_file copy $file_source $file_dest
done