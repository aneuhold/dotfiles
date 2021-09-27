# dotfiles

Dotfiles for machines that I personally use.

## Instructions

1. Use terminal or powershell to navigate to the home directory
2. Use the following command to clone from this repo into the current directory: 
```sh
git init .; git remote add -t \* -f origin git@github.com:aneuhold/dotfiles.git; git checkout main
```
3. If on Linux / Mac run `./startup.sh`. If on Windows run `.\startup.ps1`.

## Testing

To test out the dotfiles repo, you should always be able to start a new sub-directory
and use these commands. It shouldn't make a difference where the starting directory is.