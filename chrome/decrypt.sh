#!/usr/bin/env bash
set -euox pipefail
main() {
    local ENCRY_PUBKEY=""
    local FILENAME=my-ublock-backup.json &&
        gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg >./${FILENAME}
    local FILENAME=OmegaOptions.bak.json &&
        gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg >./${FILENAME}
    local FILENAME=OmegaProfile_auto_switch.pac.js &&
        gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg >./${FILENAME}
    local FILENAME=tampermonkey-backup-chrome.json &&
        gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg >./${FILENAME}
}
main
