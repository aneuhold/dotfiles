#!/bin/bash
echo "Running startup script..."
GREEN_ICON=✅
RED_ICON=🔴

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

mac_has_homebrew() {
  # Might be able to find a better way to see if homebrew is installed in the
  # future
  if [[ $(which brew) == *"brew"* ]]; then
    local has_homebrew="true"
  else
    local has_homebrew="false"
  fi
  echo "$has_homebrew"
}

setup_homebrew() {
  echo "Installing homebrew now..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
}

mac_setup_node() {
  echo "Setting up node..."
  echo $(brew install node)
}

setup_scripts_area() {
  echo "Setting up script area..."
}

# If this is running on a mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "This is running on a mac... Executing appropriate commands..."
  setup_mac
else
  echo "$RED_ICON Unknown OSTYPE... Please add a command for this machine in the startup.sh script."
fi

