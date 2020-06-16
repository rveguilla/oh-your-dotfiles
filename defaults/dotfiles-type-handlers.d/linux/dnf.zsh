function dnf_install_upgrade_packages() {
  dnf_add_repos
  add_yum_repos_d
  dnf_enable_repos
  import_rpm_keys
  dnf_upgrade_packages
  dnf_install_packages "$(dnf_packages)"
}

function check_and_install_dnf_core_plugins() {
  dnf_upgrade_packages 'fedora-workstation-repositories dnf-core-plugins'
}

function dnf_add_repos() {
  if [ -n "" ]; then
      check_and_install_dnf_core_plugins
  fi
}

function add_yum_repos_d() {
  echo
}

function import_rpm_keys() {
  echo
}

function dnf_install_packages() {
  typeset -U packages
  packages=(${(f)"${1}"})
  missing_packages=""
  installed_packages=""
  for package in $packages; do
    if ! rpm -q --quiet "$package" ; then
      missing_packages+="$package "
    fi
  done

  missing_packages=$(echo "$missing_packages" | xargs)

  if [ -n "$missing_packages" ]; then
    run "installing via dnf ($(echo "$missing_packages" | sed -e :a -e '$!N; s/\n/, /; ta'))" "sudo dnf install -y $missing_packages"
  fi
}

function dnf_upgrade_packages() {
  run 'dnf check-update' 'sudo dnf check-update'
  run 'dnf update -y' 'sudo dnf update -y'
}

function dnf_packages() {
    dotfiles_find install.rpm | while read installer ; do echo && cat $installer ; done
}

dnf_install_upgrade_packages
