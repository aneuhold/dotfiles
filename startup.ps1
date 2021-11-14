Write-Host "Running startup script..."
$GREEN_ICON = "✅"
$RED_ICON = "🔴"
$MAIN_SCRIPTS_PKG_NAME="@aneuhold/main-scripts"

# Checks to see if the main scripts package needs to be updated
#
# Returns a string either "true" or "false"
function Needs-Main-Scripts-Update {
  if (Invoke-Expression "npm outdated -g $MAIN_SCRIPTS_PKG_NAME") {
    return "true"
  } else {
    return "false"
  }
}

# Checks to see if the given command exists
#
# Argument provided is the command name
# Returns a string either "true" or "false"
function Has-Command {
  param ($cmd)

  # Might be able to find a better way to see if commands are installed in the
  # future
  #
  # Also the last part hides the error that gets output if there is one.
  $output = Invoke-Expression "Get-Command $cmd -erroraction silentlycontinue";

  # Check if output has any characters in it, if it does, then the command
  # exists.
  if ($output) {
    return "true";
  } else {
    return "false";
  }
}

function Has-Main-Scripts {
  $output = Invoke-Expression "npm list -g $MAIN_SCRIPTS_PKG_NAME";
  if ($output -like "*$MAIN_SCRIPTS_PKG_NAME*") {
    return "true"
  } else {
    return "false"
  }
}

function Initialize-Windows {
  # Check for admin
  if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { 
    Write-Host "$RED_ICON This is script needs to be run in an administrator shell... Please start that then run again."
    Exit;
  }

  Write-Host "Setting up windows..."

  if (Has-Command choco -eq "true") {
    Write-Host "$GREEN_ICON This machine does have Chocolatey installed.";
  } else {
    Write-Host "$RED_ICON This machine does not have Chocolatey installed."
    Write-Host "Installing Chocolatey now..."
    Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
  }

  if (Has-Command node -eq "true") {
    Write-Host "$GREEN_ICON This machine does have node installed.";
  } else {
    Write-Host "$RED_ICON This machine does not have node installed."
    Write-Host "Installing node now..."
    choco install nodejs;
  }

  if (Has-Command npm -eq "true") {
    Write-Host "$GREEN_ICON This machine does have npm installed.";
  } else {
    Write-Host "$RED_ICON This machine does not have npm installed."
    Write-Host "Not sure what to do about that yet if node is installed..."
    Exit;
  }

  if (Has-Command az -eq "true") {
    Write-Host "$GREEN_ICON This machine does have the Azure CLI installed.";
  } else {
    Write-Host "$RED_ICON This machine does not have the Azure CLI installed.";
    Write-Host "Installing Azure CLI now..."
    choco install azure-cli;
  }

  $hasMainScripts = Has-Main-Scripts;
  if ("$hasMainScripts" -eq "true") {
    Write-Host "$GREEN_ICON This machine does have $MAIN_SCRIPTS_PKG_NAME installed.";
    
  }
}



if (($args[0] -eq "update") -and ($args[1] -eq "mainscripts")) {
  Write-Host "Updating $MAIN_SCRIPTS_PKG_NAME..."
  npm update -g;
  Write-Host "Running $MAIN_SCRIPTS_PKG_NAME command again with the following arguments: $args[2]"
  tb $3;
} else {
  Initialize-Windows
}