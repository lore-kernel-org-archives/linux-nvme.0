From: cascardo@canonical.com (Thadeu Lima de Souza Cascardo)
Date: Thu,  6 Dec 2018 14:48:08 -0200
Subject: [PATCH 0/4] nvme multipath: expose slaves/holders
Message-ID: <20181206164812.30925-1-cascardo@canonical.com>

Exposing slaves/holders is necessary in order to find out the real PCI device
and its driver for the root filesystem when generating an initramfs with
initramfs-tools. That fails right now for nvme multipath devices, which this
patchset fixes.

However, because the slave devices are hidden, lsblk fails without some extra
patches, as it can't find the device numbers for the slave devices, and exits.

Christoph Hellwig (2):
  block: move holder tracking from struct block_device to hd_struct
  nvme: create slaves/holder entries for multipath devices

Thadeu Lima de Souza Cascardo (2):
  nvme: Should not warn when a disk path is opened
  block: expose devt for GENHD_FL_HIDDEN disks

 block/genhd.c                 | 13 ++++++----
 block/partition-generic.c     |  4 +++
 drivers/block/drbd/drbd_nl.c  |  4 +--
 drivers/md/bcache/super.c     |  8 +++---
 drivers/md/dm.c               |  4 +--
 drivers/md/md.c               |  4 +--
 drivers/nvme/host/core.c      |  9 ++++---
 drivers/nvme/host/multipath.c | 13 ++++++++--
 drivers/nvme/host/nvme.h      | 12 ++++++---
 fs/block_dev.c                | 48 +++++++++++++++--------------------
 include/linux/fs.h            | 11 +++-----
 include/linux/genhd.h         |  4 +++
 12 files changed, 75 insertions(+), 59 deletions(-)

-- 
2.19.1
