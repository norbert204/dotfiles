if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    ~/.local/bin/linefetch
end

alias sysupdate="~/sysupdate.sh"
alias roll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias py="python3"
alias proj="cd (find ~ -type d -print | fzf) && tmux new-session 'nvim .'" # TODO: tmux session quits when nvim is closed
#alias vim="nvim"
#alias ls="exa --noconfirm"
alias dotnet_install="~/.dotnet/dotnet-install.sh"

set -gx DOTNET_ROOT $HOME/.dotnet

fish_add_path $DOTNET_ROOT
#fish_add_path "/var/lib/flatpak/exports/share"
fish_add_path "~/.local/bin"
#fish_add_path "~/.cargo/bin"

starship init fish | source
