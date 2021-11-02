if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
	sh ~/fetch.sh
end

alias sysupdate="sudo aura -Syu && sudo aura -Au && flatpak update"
alias roll="curl -s -L https://raw.githubusercontent.com/keroserene/rickrollrc/master/roll.sh | bash"

starship init fish | source
