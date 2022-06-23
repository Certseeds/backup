#!/usr/bin/env bash
set -euox pipefail
main(){
    ENCRY_PUBKEY=
    SIGN_KEY=
    gpg -er ${ENCRY_PUBKEY} --sign -u ${SIGN_KEY} ./my-ublock-backup.txt
    gpg -er ${ENCRY_PUBKEY} --sign -u ${SIGN_KEY} ./OmegaOptions.bak
    gpg -er ${ENCRY_PUBKEY} --sign -u ${SIGN_KEY} ./OmegaProfile_auto_switch.pac
    gpg -er ${ENCRY_PUBKEY} --sign -u ${SIGN_KEY} ./PrivacyBadger_user_data.json
    gpg -er ${ENCRY_PUBKEY} --sign -u ${SIGN_KEY} ./tampermonkey-backup-chrome.txt
}
main
