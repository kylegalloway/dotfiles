# Load autocomplete
autoload -Uz compinit
compinit

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook
autoload -Uz vcs_info

# Fix tf/node versions
# setup-env-from-directory() {
#   local tfswitchrc_path=".terraform-version"
#   local nodejs_version_path=".node-version"

#   if [ -f "$nodejs_version_path" ]; then
#     echo "Switched nodejs to version: \"$(cat .node-version)\""
#   fi

#   if [ -f "$tfswitchrc_path" ]; then
#     tfswitch
#   fi
# }

# add-zsh-hook chpwd setup-env-from-directory

# Git info
# Enable git
zstyle ':vcs_info:*' enable git
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'
# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git*' formats "(%b)%u%c"
zstyle ':vcs_info:git:*' actionformats "(%b|%a)%u%c"
# Run vcs_info just before a prompt is displayed (precmd)
# https://stackoverflow.com/questions/64093788/different-zsh-terminal-prompt-when-outside-git-directory
precmd_vcs_info() {
  vcs_info
  psvar[1]=$vcs_info_msg_0_
}

add-zsh-hook precmd precmd_vcs_info

# Prompt
# Enable substitution in the prompt.
setopt prompt_subst
TOP_CONNECTOR=$'%F{blue}%B┌─%f%b'
BOT_CONNECTOR=$'%F{blue}%B└─%f%b'
WORKING_DIR=$'%F{blue}%B[%b%F{white}%~%F{blue}%B]%f%b'
HISTORY_NUM=$'%F{green}!%!%f'
FINAL_WITH_SUDO=$'%F{red}%(!.#.>)%f'

PROMPT=$'${TOP_CONNECTOR}${WORKING_DIR} - ${HISTORY_NUM}
${BOT_CONNECTOR} %F{magenta}%1v%f ${FINAL_WITH_SUDO} '

TIME=$'%F{blue}%B[%b%F{yellow}'%D{"%a %b %d, %r"}%b$'%F{blue}%B]%b%f'

RPROMPT='${TIME}'

# Aliases

## Movement
alias ll="ls -lh"
alias la="ls -al"
alias gohome="cd ~;clear;"

## Git
alias pullall="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} pull \;"
alias checkall="find . -mindepth 1 -maxdepth 1 -type d -print -exec git -C {} status --porcelain \;"
alias gitupdate='git add --all; git commit -am "update"; git push'
alias fixgitignore='git rm --cached `git ls-files -i --exclude-from=.gitignore`'
alias gaa='git add --all'
alias gst='git status'
alias gcm='git commit -m'
alias gcam='git commit -am'
alias gl='git pull'
alias glr='git pull --rebase'
alias gp='git push'
alias gco='git checkout'
alias root='cd $(git rev-parse --show-toplevel)'

## K8s
alias k="kubectl"
alias kdebug="kubectl run -i --rm --tty debug --image=busybox --restart=Never -- sh"

## TF
alias tf="terraform"

## General
# alias brewup="brew update && brew upgrade"
# alias news="curl -s 'https://www.npr.org/rss/rss.php?id=1001' | grep '<title>' | sed 's/ <title>//g;s/<\/title>//;' | tail -n+3 | awk '{\$1=\$1};1'"
# alias smallnews="news | head -n 5 | nl -bt -nrn -s'. ' | awk '{\$1=\$1};1' | fold -sw 50"

# Search history with up/down
# source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
# bindkey '^[[A' history-substring-search-up
# bindkey '^[[B' history-substring-search-down

HISTFILE="$HOME/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
# setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
# setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
# setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
# setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
# setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
# setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
# setopt HIST_BEEP                 # Beep when accessing nonexistent history.

### 6DEV SNIPPET: tfswitch ###
# see https://github.com/warrensbox/terraform-switcher#automation
# load-tfswitch() {
#   if [ -f ".terraform-version" ]; then
#     tfswitch
#   fi
# }
# add-zsh-hook chpwd load-tfswitch
### END 6DEV SNIPPET

## Helpful functions

### Find the SSL information for a site.
sslForSite () {
    local sslAttributes=$(echo | openssl s_client -showcerts -servername $1 -connect $1:443 2>/dev/null | openssl x509 -inform pem -noout -text)
    printf "%s" "${sslAttributes}" | grep --color=auto -A 2 "Validity"
    printf "%s" "${sslAttributes}" | grep --color=auto "DNS"
    printf "%s" "${sslAttributes}" | grep --color=auto "Issuer"
}

### Delete branches that aren't on remote from local git rev
gdam() {
  echo "=== Deleting all merged branches ==="
  git fetch -p;
  for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}' | grep -vE '(main|master)'); do
    git branch -D $branch;
  done
  echo "☑️ Done!"
}

unstick-terminating-namespace() {
(
kubectl proxy &
kubectl get namespace $1 -o json |jq '.spec = {"finalizers":[]}' >temp.json
curl -k -H "Content-Type: application/json" -X PUT --data-binary @temp.json 127.0.0.1:8001/api/v1/namespaces/$1/finalize
)
}