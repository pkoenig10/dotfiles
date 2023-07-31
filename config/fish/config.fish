if test -f /opt/homebrew/bin/brew
    eval (/opt/homebrew/bin/brew shellenv)
end

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

set -x HUSKY_SKIP_HOOKS 1

function ex -a owner -a name -a check
    echo -n "$name: "
    curl -XPOST "https://excavator.palantir.build/api/coordinator/lint/$check?owner=$owner&name=$name"
    echo
end

function exall -a check
    ex foundry multipass $check
    ex foundry provenance $check
    ex foundry row-level-policy-service $check
    ex foundry multipass-clients $check
    ex foundry multipass-error-prone $check
    ex foundry multipass-style $check
    ex foundry gatekeeper-initial-nodes $check
    ex foundry security-schema $check
    ex foundry multipass-group-aum $check
    ex foundry eulamanager $check
    ex foundry twofamanager $check
    ex foundry roles $check
    ex acme cbac-commons $check
end
