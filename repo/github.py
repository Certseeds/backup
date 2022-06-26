#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

import os
from typing import Any, Dict, Tuple
import requests

GITHUB_PAT: str = os.environ['GITHUB_PAT']
headers: Dict[str, str] = {
    'Authorization': f'token {GITHUB_PAT}'
}


def zen() -> None:
    x = requests.get("https://api.github.com/zen", headers=headers)
    print(x.text)


def getRepoAddress(username: str) -> Dict[str, Any]:
    userInfoResp = requests.get(
        f'https://api.github.com/users/{username}', headers=headers)
    userInfo = userInfoResp.json()
    print(userInfo)
    repos_url: str = userInfo["repos_url"]
    public_repos: int = userInfo["public_repos"]
    will_return: Dict[str, Any] = {
        "repos_url": repos_url,
        "public_repos": public_repos
    }
    print(will_return)
    return will_return


def getRepoList(pub_repo_info: Dict[str, Any]) -> Tuple[str]:
    public_repos_num = pub_repo_info['public_repos']
    public_repo_address = pub_repo_info['repos_url']
    will_return: Tuple[str] = ()
    for i in range(1, (public_repos_num//10+public_repos_num % 10+1), 1):
        reposResp = requests.get(
            url=f'{public_repo_address}',
            params={
                'per_page': 10,
                'page': i,
            },
            headers=headers)
        repos = reposResp.json()
        print(repos)
        repos_name_list = tuple([repo['name'] for repo in repos])
        print(repos_name_list)
        will_return = repos_name_list + will_return
        print(len(will_return))
    return will_return


def main() -> None:
    zen()
    address: str = getRepoAddress("Certseeds")
    pub_repos = getRepoList(address)
    print(pub_repos)
    pass


if __name__ == '__main__':
    mmap = ({'a': 1}, {'a': 2}, {'a': 3})
    elements = [ele['a'] for ele in mmap]
    print(len(elements))
    main()
