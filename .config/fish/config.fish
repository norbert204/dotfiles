if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
    sh ~/fetch.sh
end

# TODO: make this alias more universal
alias sysupdate="sudo aura -S archlinux-keyring && sudo aura -Syu && sudo aura -Au && cargo install-update --all && sudo flatpak update"
alias roll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"
alias py="python3"
alias vim="nvim"
alias ls="exa"
alias dotnet_install="~/.dotnet/dotnet-install.sh"

set -gx DOTNET_ROOT $HOME/.dotnet

fish_add_path $DOTNET_ROOT
fish_add_path "/var/lib/flatpak/exports/share"
fish_add_path "~/.local/bin"

starship init fish | source
