#!/bin/bash

mdadm --zero-superblock --force /dev/sd{b,c,d,e}
mdadm --create --verbose /dev/md0 -l10 -n 4 /dev/sd{b,c,d,e}
