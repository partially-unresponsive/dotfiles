alias config='/usr/bin/git --git-dir=/home/sam/.dotfiles/ --work-tree=/home/sam'
# Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

#####---------- EXPORTS ----------#####

export BROWSER="librewolf"
export EDITOR="nvim"
export VISUAL="nvim"
export LESSHISTFILE=-
export HISTFILE="$HOME/.bash_history"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'
export CDPATH=".:$HOME:$HOME/.config/:$HOME/.local/:$HOME/.local/share/:$HOME/.local/programs"
export LIBVIRT_DEFAULT_URI='qemu:///system'
export CSCOPE_EDITOR="nvim"
export DOTS="$HOME/github/dotfiles"
export RUSTC_WRAPPER=sccache

eval $(dircolors ~/.dir_colors)

alias vim=nvim
alias ls='ls -a --color=auto'
alias ll='ls -alh --color=auto'
alias grep='grep --color=auto'
alias neofetch='fastfetch'
alias fetch='fastfetch'
alias lss='du -ah --max-depth 1 | sort -n'
alias noisetorch='exec ~/.local/bin/noisetorch'
alias bashrc='nvim ~/.bashrc'
alias sourcebash='source ~/.bashrc'
alias top='btop'
alias code='vscodium'
# alias swww='awww'
# alias swww-daemon='awww-daemon'

fastfetch
echo "[NOTE]: Try running \`fish\`!"
# kitty fish &
eval "$(zoxide init bash --cmd cd)"

###------------------- PROMPT -----------------------###

function parse_git_dirty {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then printf ""; return; else printf " ["; fi
  if echo "${STATUS}" | grep -c "renamed:"         &> /dev/null; then printf " >"; else printf ""; fi
  if echo "${STATUS}" | grep -c "branch is ahead:" &> /dev/null; then printf " !"; else printf ""; fi
  if echo "${STATUS}" | grep -c "new file::"       &> /dev/null; then printf " +"; else printf ""; fi
  if echo "${STATUS}" | grep -c "Untracked files:" &> /dev/null; then printf " ?"; else printf ""; fi
  if echo "${STATUS}" | grep -c "modified:"        &> /dev/null; then printf " *"; else printf ""; fi
  if echo "${STATUS}" | grep -c "deleted:"         &> /dev/null; then printf " -"; else printf ""; fi
  printf " ]"
}

parse_git_branch() {
  # Long form
  git rev-parse --abbrev-ref HEAD 2> /dev/null
 # Short form
  # git rev-parse --abbrev-ref HEAD 2> /dev/null | sed -e 's/.*\/\(.*\)/\1/'
}

prompt_comment() {
    DIR="$HOME/.local/share/promptcomments/"
    MESSAGE="$(find "$DIR"/*.txt | shuf -n1)"
    cat "$MESSAGE"
}

PS1="\[\e[00;36m\]┌─[ \[\e[00;37m\]\T \d \[\e[00;36m\]]──\[\e[00;31m\]>\[\e[00;37m\] \u\[\e[00;31m\]@\[\e[00;37m\]\h\n\[\e[00;36m\]|\n\[\e[00;36m\]└────\[\e[00;31m\]> \[\e[00;37m\]\w \[\e[00;31m\]\$ \[\e[01;37m\]"
#PS1="\e[00;36m\]┌─[ \e[00;37m\]\T \d \e[00;36m\]]──\e[00;31m\]>\e[00;37m\] \u\e[00;31m\]@\e[00;37m\]\h\n\e[00;36m\]|\n\e[00;36m\]└────\e[00;31m\]> \e[00;37m\]\w \e[00;31m\]\$ \e[01;37m\]"
#export PS1="\[\e[01;37m\]{ \[\e[01;34m\]\w \[\e[01;37m\]} \[\e[01;35m\]\[\$ \]\[\e[01;37m\]"
#PS1="\[\e[1;36m\]\$(parse_git_branch)\[\033[31m\]\$(parse_git_dirty)\[\033[00m\]\n\w\[\e[1;31m\] \[\e[1;36m\]\[\e[1;37m\] "
#PS1="\[\e[1;33m\]\$(parse_git_branch)\[\033[34m\]\$(parse_git_dirty)\n\[\033[1;36m\]  \[\e[1;37m\] \w \[\e[1;37m\]\[\e[0;37m\] "
#PS1="\[\e[1;33m\]\$(parse_git_branch)\[\033[34m\]\$(parse_git_dirty)\n\[\033[1;34m\] 󰣇 \[\e[1;37m\] \w \[\e[1;36m\]\[\e[0;37m\] "

###---------- ARCHIVE EXTRACT ----------###

ex ()
{
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1   ;;
        *.tar.gz)    tar xzf $1   ;;
        *.bz2)       bunzip2 $1   ;;
        *.rar)       unrar x $1   ;;
        *.gz)        gunzip $1    ;;
        *.tar)       tar xf $1    ;;
        *.tbz2)      tar xjf $1   ;;
        *.tgz)       tar xzf $1   ;;
        *.zip)       unzip $1     ;;
        *.Z)         uncompress $1;;
        *.7z)        7za e x $1   ;;
        *.deb)       ar x $1      ;;
        *.tar.xz)    tar xf $1    ;;
        *.tar.zst)   unzstd $1    ;;
        *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}


###---------- OTHER ----------###

HISTSIZE=10000
#SAVEHIST=10000

export LESS_TERMCAP_mb=$'\e[1;36m'
export LESS_TERMCAP_md=$'\e[1;36m'
export LESS_TERMCAP_me=$'\e[1;37m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;34m'

###---- npm packages ----- ###
NPM_PACKAGES="${HOME}/.npm-packages"
export PATH="$PATH:$NPM_PACKAGES/bin"
export PATH="$PATH:/home/izzyfix/.cargo/bin"
# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"

###-------- gnupg -------###
export GPG_TTY=$(tty)
# google-cloud-cli gcloud
# source /etc/profile.d/google-cloud-cli.sh


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# flutter
export PATH="/usr/bin/flutter/bin:$PATH"

# Created by `pipx` on 2025-07-21 10:38:43
export PATH="$PATH:/home/izzyfix/.local/bin"

if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]]
then
	shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=''
	exec fish $LOGIN_OPTION
fi
