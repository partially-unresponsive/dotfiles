if status is-interactive
    # Commands to run in interactive sessions can go here
end

alias cl="clear"
alias ls="ls -a --color=auto"
alias ll='ls -alh --color=auto'
alias grep='grep --color=auto'
alias fishrc='nvim ~/.config/fish/config.fish'
alias sourcefish='source ~/.config/fish/config.fish'
alias top='btop'
alias code='vscodium'


fastfetch

zoxide init fish --cmd cd | source
