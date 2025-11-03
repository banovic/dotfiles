# ~/.bashrc

# Vars
export EDITOR='vim'
export VISUAL='vim'
export PAGER='less'
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth:erasedups  # Avoid duplicates

# Tabs in terminal title
export PROMPT_COMMAND='printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/~}"'

# Dotnet vars
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export DOTNET_ROOT="$HOME/.dotnet"
# Opt dir for user:
export USER_OPT_DIR="$HOME/opt"
# npm
export NPM_CONFIG_PREFIX="$HOME/.npm-global"
# flutter
export CHROME_EXECUTABLE="/usr/bin/google-chrome-stable"

# Path
PATH="$HOME/bin:$HOME/.local/bin:$HOME/.dotnet:$HOME/.dotnet/tools:$HOME/.npm-global/bin:$USER_OPT_DIR/flutter/bin:$PATH"

# Rust/Cargo, deno, flutter/dart
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -f "$HOME/.deno/env" ] && . "$HOME/.deno/env"
[ -d "$USER_OPT_DIR/flutter/bin" ] && PATH="$USER_OPT_DIR/flutter/bin:$PATH"

# Secrets (API keys, etc.), local not in repo
[ -f "$HOME/.secrets" ] && . "$HOME/.secrets"

# Completions and prompt for git
GIT_VERSION_NUMBER=$(git version | cut -d ' ' -f 3)
GIT_COMPLETION_SOURCE_DIR="/usr/doc/git-$GIT_VERSION_NUMBER/contrib/completion" # In Slackware
[ -f "$GIT_COMPLETION_SOURCE_DIR/git-completion.bash" ] && . "$GIT_COMPLETION_SOURCE_DIR/git-completion.bash"
[ -f "$GIT_COMPLETION_SOURCE_DIR/git-prompt.sh" ] && . "$GIT_COMPLETION_SOURCE_DIR/git-prompt.sh"

# Prompt
if type -t __git_ps1 > /dev/null; then
    PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
else
    PS1='[\u@\h \W]\$ '
fi

# Aliases
alias ls='ls --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias startx='startx -- -nolisten tcp' 

# Quick file and directory search
ff() { find . -type f -iname "*$1*"; }
fd() { find . -type d -iname "*$1*"; }



