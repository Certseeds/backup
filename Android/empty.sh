#!/usr/bin/env bash
set -eoux pipefail
###
# @Github: https://github.com/Certseeds/backup
# @Author: nanoseeds
# @CreateDate: 2020-03-14 21:50:12
###
main() {
    local origin_path=$(pwd)
    cd "${1}"
    grep -v '^ *#' <./names.txt | while IFS= read -r line; do
        echo "Line: $line"
        touch "${line}"
        echo "${line}" | base64 | md5sum >"./${line}"
        echo "${line}" | md5sum | base64 >>"./${line}"
        echo "${line}" | sha1sum | base64 >>"./${line}"
        echo "${line}" | sha256sum | md5sum >>"./${line}"
    done
    cd "${origin_path}"
}
main "${1}"
# main ./ for default
