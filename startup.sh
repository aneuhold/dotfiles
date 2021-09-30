#!/bin/bash
echo "Running startup script..."
GREEN_ICON=✅
RED_ICON=🔴
MAIN_SCRIPTS_PKG_NAME="@aneuhold/main-scripts"

setup_mac() {
  if [[ $(has_command "brew") == "true" ]]; then
    echo "$GREEN_ICON This machine does have homebrew installed."
  else
    echo "$RED_ICON This machine does not have homebrew installed."
    setup_homebrew
  fi
  update_homebrew

  if [[ $(has_command "node") == "true" ]]; then
    echo "$GREEN_ICON This machine does have node installed."
  else
    echo "$RED_ICON This machine does not have node installed..."
    mac_setup_node
  fi

  if [[ $(has_command "npm") == "true" ]]; then
    echo "$GREEN_ICON This machine does have npm installed."
  else
    echo "$RED_ICON This machine does not have npm installed..."
    mac_setup_npm
  fi

  # Check if the main scripts are installed
  if [[ -z $(npm list -g | grep $MAIN_SCRIPTS_PKG_NAME) ]]; then
    echo "$RED_ICON $MAIN_SCRIPTS_PKG_NAME is not installed."
    install_main_scripts
  else 
    echo "$GREEN_ICON $MAIN_SCRIPTS_PKG_NAME already installed."
    echo "Checking for updates to $MAIN_SCRIPTS_PKG_NAME..."
    if [[ $(needs_main_scripts_update) == "true" ]]; then
      echo "$RED_ICON $MAIN_SCRIPTS_PKG_NAME is outdated."

      # As of 9/30/2021 evidently updating just a single package deletes 
      # all packages. Really weird.
      echo "Updating $MAIN_SCRIPTS_PKG_NAME and all global packages...";
      echo $(npm update -g)

    else
      echo "$GREEN_ICON $MAIN_SCRIPTS_PKG_NAME is up to date."
    fi
  fi
}

# Checks to see if the main scripts package needs to be updated
#
# Returns a string either "true" or "false"
needs_main_scripts_update() {
  if [[ -z $(npm outdated -g $MAIN_SCRIPTS_PKG_NAME) ]]; then
    echo "true"
  else
    echo "false"
  fi
}

# Checks to see if the given command exists
#
# Argument provided is the command name
# Returns a string either "true" or "false"
has_command() {
  # Might be able to find a better way to see if commands are installed in the
  # future
  if [[ $(which $1) == *"$1"* ]]; then
    local has_cmd="true"
  else
    local has_cmd="false"
  fi
  echo "$has_cmd"
}

update_homebrew() {
  echo "Updating homebrew..."
  echo $(brew update)
  echo "Upgrading homebrew..."
  echo $(brew upgrade)
}

setup_homebrew() {
  echo "Installing homebrew now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

mac_setup_node() {
  echo "Setting up node..."
  echo $(brew install node)
}

mac_setup_npm() {
  echo "Setting up npm..."
  echo $(brew reinstall node)
}

install_main_scripts() {
  echo "Installing $MAIN_SCRIPTS_PKG_NAME...";
  npm i -g $MAIN_SCRIPTS_PKG_NAME;
}

if [[ "$1" == "update" && "$2" == "mainscripts" ]]; then
  echo "Updating $MAIN_SCRIPTS_PKG_NAME...";
  npm update -g;
  echo "Running $MAIN_SCRIPTS_PKG_NAME command again with the following arguments: $3"
  tb $3;
# If this is running on a mac
elif [[ "$OSTYPE" == "darwin"* ]]; then
  echo "This is running on a mac... Executing appropriate commands..."
  setup_mac
else
  echo "$RED_ICON Unknown OSTYPE... Please add a command for this machine in the startup.sh script."
fi
