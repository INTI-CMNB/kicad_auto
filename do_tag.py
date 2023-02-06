#!/usr/bin/python3
import os
import re
import stat
import subprocess

CUR_VERSION = '1.6.0'
CUR_K5 = '5.1.9'
CUR_K6 = '6.0.10'
CUR_DEB = '11.6'
ITERA = '1'

TAGS = {'latest': CUR_DEB+'-'+CUR_K5, 'ki6': 'ki'+CUR_K6+'_Debian'}
NEW_TAGS = {'latest': '-'+ITERA+'_k'+CUR_K5+'_d'+CUR_DEB, 'ki6': '-'+ITERA+'_k'+CUR_K6+'_d'+CUR_DEB}
NEW_DEB1 = {'latest': CUR_K5, 'ki6': CUR_K6}
NEW_DEB2 = {'latest': CUR_K5+'_d'+CUR_DEB, 'ki6': CUR_K6+'_d'+CUR_DEB}
IMAGES = ['kicad_debian', 'kicad_auto', 'kicad_auto_test']
NEW_NAMES = {'kicad_auto:latest': 'kicad5_auto',
             'kicad_auto:ki6': 'kicad6_auto',
             'kicad_auto_test:latest': 'kicad5_auto_full',
             'kicad_auto_test:ki6': 'kicad6_auto_full'}
NEW_NAMES_D = {'kicad_debian:latest': 'kicad5_debian',
               'kicad_debian:ki6': 'kicad6_debian'}
OWNER = 'setsoft'
OWNER2 = 'ghcr.io/inti-cmnb'
DEBUG = False


def do_tag(name, hash, current):
    cmd = ['docker', 'tag', hash, name]
    print('{} -> {}'.format(current, cmd))
    if not DEBUG:
        subprocess.run(cmd, check=True)


res = subprocess.run(['docker', 'images'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT, check=True)
reg = re.compile(r'^(\S+)\s+(\S+)\s+([0-9a-z]+)\s+')

if 1:
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
        hash = r[2]
        current = r[0]+':'+tag
        do_tag('{}/{}:{}'.format(OWNER, img, TAGS[tag]), hash, current)
        do_tag('{}/{}:{}'.format(OWNER2, img, TAGS[tag]), hash, current)
        do_tag('{}/{}:{}'.format(OWNER2, img, tag), hash, current)
        old_lu = img+':'+tag
        try:
            new_img = NEW_NAMES[old_lu]
            do_tag('{}/{}:{}'.format(OWNER2, new_img, 'latest'), hash, current)
            do_tag('{}/{}:{}'.format(OWNER2, new_img, CUR_VERSION), hash, current)
            do_tag('{}/{}:{}'.format(OWNER2, new_img, CUR_VERSION+NEW_TAGS[tag]), hash, current)
        except KeyError:
            pass
        try:
            new_img = NEW_NAMES_D[old_lu]
            do_tag('{}/{}:{}'.format(OWNER2, new_img, 'latest'), hash, current)
            do_tag('{}/{}:{}'.format(OWNER2, new_img, NEW_DEB1[tag]), hash, current)
            do_tag('{}/{}:{}'.format(OWNER2, new_img, NEW_DEB2[tag]), hash, current)
        except KeyError:
            pass


with open('push.sh', 'wt') as f:
    f.write('#!/bin/sh\n')
    for o in [OWNER, OWNER2]:
        for i in IMAGES:
            for t in TAGS.values():
                f.write('docker push {}/{}:{}\n'.format(o, i, t))
        if o == OWNER2:
            for i in IMAGES:
                f.write('docker push {}/{}:latest\n'.format(o, i))
                f.write('docker push {}/{}:ki6\n'.format(o, i))
                if i == 'kicad_debian':
                    for t in TAGS.keys():
                        new_name = NEW_NAMES_D[i+':'+t]
                        f.write('docker push {}/{}:latest\n'.format(o, new_name))
                        f.write('docker push {}/{}:{}\n'.format(o, new_name, NEW_DEB1[t]))
                        f.write('docker push {}/{}:{}\n'.format(o, new_name, NEW_DEB2[t]))
                else:
                    for t in TAGS.keys():
                        new_name = NEW_NAMES[i+':'+t]
                        f.write('docker push {}/{}:latest\n'.format(o, new_name))
                        f.write('docker push {}/{}:{}\n'.format(o, new_name, CUR_VERSION))
                        f.write('docker push {}/{}:{}\n'.format(o, new_name, CUR_VERSION+NEW_TAGS[t]))
os.chmod('push.sh', stat.S_IRWXU)
