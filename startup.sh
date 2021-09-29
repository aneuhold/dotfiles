#!/bin/bash
echo "Running startup script..."
GREEN_ICON=✅
RED_ICON=🔴
MAIN_SCRIPTS_PKG_NAME="@aneuhold/main_scripts"

setup_mac() {
  if [[ $(has_command "brew") == "true" ]]; then
    echo "$GREEN_ICON This machine does have homebrew installed..."
  else
    echo "$RED_ICON This machine does not have homebrew installed..."
    setup_homebrew
  fi
  update_homebrew

  if [[ $(has_command "node") == "true" ]]; then
    echo "$GREEN_ICON This machine does have node installed..."
  else
    echo "$RED_ICON This machine does not have node installed..."
    mac_setup_node
  fi

  # Check if the main scripts are installed
  if [[ -z $(npm list -g | grep $MAIN_SCRIPTS_PKG_NAME) ]]; then
    install_main_scripts
  else 
    echo "$MAIN_SCRIPTS_PKG_NAME already installed. Skipping..."
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

install_main_scripts() {
  echo "Installing the main scripts..."

}

# If this is running on a mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "This is running on a mac... Executing appropriate commands..."
  setup_mac
else
  echo "$RED_ICON Unknown OSTYPE... Please add a command for this machine in the startup.sh script."
fi

