#!/bin/bash
echo "Running startup script..."
GREEN_ICON=✅
RED_ICON=🔴

setup_mac() {
  if [[ $(mac_has_homebrew) == "true" ]]; then
    echo "$GREEN_ICON This machine does have homebrew installed..."
  else
    echo "$RED_ICON This machine does not have homebrew installed..."
    echo "Installing homebrew now..."
    
  fi
}

mac_has_homebrew() {
  local has_homebrew="true"
  echo "$has_homebrew"
}

setup_homebrew() {
  echo "test"
}

# If this is running on a mac
if [[ "$OSTYPE" == "darwin"* ]]; then
  echo "This is running on a mac... Executing appropriate commands..."
  setup_mac
else
  echo "Unknown OSTYPE... Please add a command for this machine in the startup.sh script."
fi

