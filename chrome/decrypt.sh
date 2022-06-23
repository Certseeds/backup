#!/usr/bin/env bash
set -euox pipefail
main(){
    ENCRY_PUBKEY=""
    FILENAME=my-ublock-backup.txt &&  gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg > ./${FILENAME}
    FILENAME=OmegaOptions.bak &&  gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg > ./${FILENAME}
    FILENAME=OmegaProfile_auto_switch.pac &&  gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg > ./${FILENAME}
    FILENAME=PrivacyBadger_user_data.json &&  gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg > ./${FILENAME}
    FILENAME=tampermonkey-backup-chrome.txt &&  gpg -dr ${ENCRY_PUBKEY} -v ./${FILENAME}.gpg > ./${FILENAME}
}
main
