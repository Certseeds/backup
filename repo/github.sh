#!/usr/bin/env bash
set -euox pipefail
main(){
    curl https://api.github.com/zen
    curl https://api.github.com/users/Certseeds
}
main
