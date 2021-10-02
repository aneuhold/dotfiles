Write-Host "Running startup script..."
$GREEN_ICON = "✅"
$RED_ICON = "🔴"
$MAIN_SCRIPTS_PKG_NAME="@aneuhold/main-scripts"
function Initialize-Windows {
  Write-Host "Setting up windows..."
}

if (($args[0] -eq "update") -and ($args[1] -eq "mainscripts")) {
  Write-Host "Updating $MAIN_SCRIPTS_PKG_NAME..."
  npm update -g;
  Write-Host "Running $MAIN_SCRIPTS_PKG_NAME command again with the following arguments: $args[2]"
  tb $3;
} else {
  Initialize-Windows
}