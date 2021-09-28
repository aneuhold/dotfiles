# dotfiles

Dotfiles for machines that I personally use.

## Instructions

1. Use terminal or powershell to navigate to the home directory
2. Use the following command to clone from this repo into the current directory: 
```sh
git init .; git remote add -t \* -f origin git@github.com:aneuhold/dotfiles.git; git checkout main
```
3. If on Linux / Mac run `./startup.sh`. If on Windows run `.\startup.ps1`.

## Startup script objective

Things the startup script should do:

- Install everything needed to get to the point that the main node.js script can be ran with `npx`. The main node.js script will be multi-platform.

Things the startup script shouldn't do:

- Install yarn
- Update global node or yarn packages
- Create directories unless absolutely needed to get to the above stated point

Something to think about is checking for updates on commands. Maybe before starting each command, you will need to have some kind of git command that checks the remote repo for any updates and if there are any, it pulls them down. 

One thing to watch out for is if you can actually update node while node is running. Maybe that will work, but need to test first. 

The "Node.js" entry in the personal Wiki has some good info on setting up shell commands with Node.js.

## Testing

To test out the dotfiles repo, you should always be able to start a new sub-directory
and use these commands. It shouldn't make a difference where the starting directory is.