if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

set fish_color_command blue

fish_add_path -g ~/.cargo/bin
fish_add_path -g ~/go/bin

abbr -a c cargo
abbr -a d docker
abbr -a dc docker compose

abbr -a g './gradlew --no-scan'
abbr -a -g gru 'git fetch && git reset --hard @{upstream}'
abbr -a -g gwl './gradlew --no-scan --write-locks'

set -x JAVA_HOME (/usr/libexec/java_home -v 17)

set -x DOCKER_FOR_MAC_OVERRIDE /Applications/OrbStack.app

function cmd
    set -l color_bold (set_color --bold)
    set -l color_normal (set_color normal)

    echo -s $color_bold "> $argv" $color_normal

    $argv
end

function excavator -a check repo
    if test -z "$repo"
        excavator $check acme/cbac-commons
        excavator $check foundry/eulamanager
        excavator $check foundry/gatekeeper-initial-nodes
        excavator $check foundry/multipass
        excavator $check foundry/multipass-clients
        excavator $check foundry/multipass-error-prone
        excavator $check foundry/multipass-group-aum
        excavator $check foundry/multipass-style
        excavator $check foundry/pass
        excavator $check foundry/provenance
        excavator $check foundry/roles
        excavator $check foundry/row-level-policy-service
        excavator $check foundry/security-schema
        excavator $check foundry/twofamanager
        return
    end

    set -l repo (string split -m 1 '/' $repo)
    set -l owner $repo[1]
    set -l name $repo[2]

    set -l color_normal (set_color normal)
    set -l color_yellow (set_color yellow)

    if test -n "$name"
        echo -s $color_yellow "$owner/$name:" $color_normal
        cmd curl -XPOST "https://excavator.palantir.build/api/coordinator/lint/$check?owner=$owner&name=$name"
        echo
        echo
    else
        echo -s $color_yellow "$owner:" $color_normal
        cmd curl -XPOST "https://excavator.palantir.build/api/coordinator/lint/$check?owner=$owner"
        echo
        echo
    end
end
