#!/usr/bin/env bash
set -euox pipefail
main(){
    # git rebase -i --root \
    git rebase HEAD~${num} \
    --exec 'GIT_COMMITTER_DATE="$(git --no-pager log --graph --pretty=format:'%ai' -1 | tee | cut -b 3-)" git commits --amend --author="Certseeds <51754303+Certseeds@users.noreply.github.com>" --no-edit --date="$(git --no-pager log --graph --pretty=format:'%ai' -1 | tee | cut -b 3-)"'
    GIT_COMMITTER_DATE="$(git --no-pager log --graph --pretty=format:'%ai' -1 | tee | cut -b 3-)" git commits --amend --author="Certseeds <51754303+Certseeds@users.noreply.github.com>" --no-edit --date="$(git --no-pager log --graph --pretty=format:'%ai' -1 | tee | cut -b 3-)" # commit with last commit's author-date amd commit-date,but can not specific gpg sign time
}
