From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 29 Jun 2016 16:51:35 +0200
Subject: [PATCH 0/6] enable sysfs for lightnvm
Message-ID: <1467211901-26707-1-git-send-email-m@bjorling.me>

The common way to expose a storage device is to export it through the
gendisk structure, which takes care of handling the visibility lifetime
of the device to user-space and carries device driver and block layer
specific sysfs entries.

For LightNVM, no gendisk is exposed, which hides these entries.

This patchset enables LightNVM to expose a subset of the gendisk entries
by implementing a new non-gendisk device that only exposes the sysfs
entries that are relevant to the device driver and LightNVM. For example
/mq and the NVMe sysfs entries.

The new non-gendisk exposes itself in place of the original gendisk.
Thus, a gendisk device exposed through /sys/class/nvme/nvme0n1, will
still be exposed through the same directory, although only with the /mq,
lightnvm, and nvme specific entries.

The LightNVM storage device can be found through sysfs by searching
for devices that has the "lightnvm" dev type.

The patches require the just posted patches before they can be applied.
They can also be found in the for-4.8/sysfs branch at:

  https://github.com/OpenChannelSSD/linux.git

v3:
 - Fixed missing divising by nvme block nr.
v2:
 - Updated "expose gennvm target type" to expose its own kobject, which
   pblk and others can hook into.
 - Fixed missing disk_name in null_blk patch on lightnvm device

Matias Bj?rling (4):
  nvme: refactor namespaces to support non-gendisk devices
  null_blk: refactor to support non-gendisk devices
  blk-mq: register device instead of disk
  lightnvm: let drivers control the lifetime of nvm_dev

Simon A. F. Lund (2):
  lightnvm: expose device geometry through sysfs
  lightnvm: expose gennvm target type through sysfs

 block/blk-mq-sysfs.c         |  13 ++-
 block/blk-sysfs.c            |   4 +-
 drivers/block/null_blk.c     | 128 +++++++++++++++++-----------
 drivers/lightnvm/Makefile    |   2 +-
 drivers/lightnvm/core.c      |  54 +++++-------
 drivers/lightnvm/gennvm.c    | 112 +++++++++++++++++++++----
 drivers/lightnvm/lightnvm.h  |  35 ++++++++
 drivers/lightnvm/sysfs.c     | 195 +++++++++++++++++++++++++++++++++++++++++++
 drivers/md/dm.c              |   2 +-
 drivers/nvme/host/core.c     | 165 ++++++++++++++++++++----------------
 drivers/nvme/host/lightnvm.c |  34 ++++++--
 drivers/nvme/host/nvme.h     |  26 ++++--
 include/linux/blk-mq.h       |   4 +-
 include/linux/lightnvm.h     |  28 +++++--
 14 files changed, 603 insertions(+), 199 deletions(-)
 create mode 100644 drivers/lightnvm/lightnvm.h
 create mode 100644 drivers/lightnvm/sysfs.c

-- 
2.1.4
