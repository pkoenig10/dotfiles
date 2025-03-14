if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set fish_color_command blue

fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/go/bin

abbr -a c cargo
abbr -a d docker
abbr -a dc docker compose
