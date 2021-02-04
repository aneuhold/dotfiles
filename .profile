color1=$(tput setaf 10)
color2=$(tput setaf 14)
reset=$(tput sgr0)
export PS1='\[$color1\]${USER}\[$reset\]@\[$color2\]\W\[$reset\]:'
export PATH=$PATH:/Users/aneuhold/Library/Android/sdk/platform-tools


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
