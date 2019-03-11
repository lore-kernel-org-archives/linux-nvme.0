From: ming.lei@redhat.com (Ming Lei)
Date: Mon, 11 Mar 2019 10:24:42 +0800
Subject: NVMe: Regression: write zeros corrupts ext4 file system
Message-ID: <20190311022441.GA16849@ming.t460p>

Hi,

It is observed that ext4 is corrupted easily by running some workloads
on QEMU NVMe, such as:

1) mkfs.ext4 /dev/nvme0n1

2) mount /dev/nvme0n1 /mnt

3) cd /mnt; git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git

4) then the following error message may show up:

[ 1642.271816] EXT4-fs error (device nvme0n1): ext4_mb_generate_buddy:747: group 0, block bitmap and bg descriptor inconsistent: 32768 vs 23513 free clusters

Or fsck.ext4 will complain after running 'umount /mnt'

The issue disappears by reverting 6e02318eaea53eaafe6 ("nvme: add support for the
Write Zeroes command").

QEMU version:

QEMU emulator version 2.10.2(qemu-2.10.2-1.fc27)
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

Thanks,
Ming
