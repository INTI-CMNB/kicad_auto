#!/usr/bin/python3
import os
import re
import stat
import subprocess

TAGS = {'latest': '11.5-5.1.9', 'ki6': 'ki6.0.7_Debian'}
IMAGES = ['kicad_debian', 'kicad_auto', 'kicad_auto_test']
OWNER = 'setsoft'
OWNER2= 'ghcr.io/inti-cmnb'


def do_tag(name, hash, current):
    cmd = ['docker', 'tag', hash, name]
    print('{} -> {}'.format(current, cmd))
    subprocess.run(cmd, check=True)


res = subprocess.run(['docker', 'images'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=True)
reg = re.compile(r'^(\S+)\s+(\S+)\s+([0-9a-z]+)\s+')

if 0:
    for ln in res.stdout.decode().split('\n'):
        r = reg.search(ln)
        if r is None:
            continue
        r = r.groups()
        tag = r[1]
        if tag not in TAGS:
            continue
        r1 = r[0].split('/')
        if len(r1) != 2 or r1[0] != OWNER:
            continue
        img = r1[1]
        if img not in IMAGES:
            continue
        do_tag('{}/{}:{}'.format(OWNER, img, TAGS[tag]), r[2], r[0]+':'+r[1])
        do_tag('{}/{}:{}'.format(OWNER2, img, TAGS[tag]), r[2], r[0]+':'+r[1])
        do_tag('{}/{}:{}'.format(OWNER2, img, tag), r[2], r[0]+':'+r[1])

with open('push.sh', 'wt') as f:
    f.write('#!/bin/sh\n')
    for o in [OWNER, OWNER2]:
        for i in IMAGES:
            for t in TAGS.values():
                f.write('docker push {}/{}:{}\n'.format(o, i, t))
os.chmod('push.sh', stat.S_IRWXU)
