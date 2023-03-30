#!/usr/bin/python3
# -*- coding: utf-8 -*-
# Copyright (c) 2023 Salvador E. Tropea
# Copyright (c) 2023 Instituto Nacional de Tecnologïa Industrial
# License: GPLv3
# Simple Git Hub release downloader
import argparse
import json
import os
import requests
import sys
from time import sleep
from urllib.parse import unquote


USER_AGENT = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101 Firefox/102.0'


def error(msg):
    print(msg)
    exit(3)


def get_request(url):
    retry = 4
    while retry:
        r = requests.get(url, timeout=20, allow_redirects=True, headers={'User-Agent': USER_AGENT})
        if r.status_code == 200:
            return r
        if r.status_code == 403:
            # GitHub returns 403 randomly (saturated?)
            sleep(1 << (4-retry))
            retry -= 1
        else:
            retry = 0
    error(f'Failed to get release info, status {r.status_code}')


def download(url, skip):
    fname = unquote(os.path.basename(url))
    for s in skip:
        if fname.startswith(s):
            print(f"Skipping `{fname}`")
            return
    if os.path.isfile(fname):
        print(f"`{fname}` already downloaded, won't overwrite")
        return
    print(f"Downloading `{fname}`")
    res = get_request(url)
    print(f"Saving `{fname}`")
    with open(fname, 'wb') as f:
        f.write(res.content)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Debian package downloader for GitHub releases')

    parser.add_argument('project', help='The user/project to fetch')
    parser.add_argument('--skip', '-s', help='Skip files starting with', type=str, nargs='+', default=[])
    parser.add_argument('--release', '-r', help='Release to download', type=str, default='latest')
    args = parser.parse_args()

    if args.release != 'latest':
        args.release = 'tags/'+args.release
    url = 'https://api.github.com/repos/'+args.project+'/releases/'+args.release
    print(f"Downloading `{args.release}` release of `{args.project}` ({url})")
    res = get_request(url)
    r = res.json()
    for a in r['assets']:
        download(a['browser_download_url'], args.skip)
