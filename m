From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Tue, 13 Feb 2018 15:06:00 +0100
Subject: [PATCH 0/8] lightnvm: pblk: implement support for 2.0
Message-ID: <1518530768-20956-1-git-send-email-javier@cnexlabs.com>

This patchset implements support for 2.0 spec in pblk.

The first patch abstracts the geometry retrieved from the identify
command and allows both specs to coexist under the same geometry
description. From there on, we build the missing 2.0 support in lightnvm
core: address format, address conversion and report chnk get log page.
The last three patches implement the actual support for 2.0 in pblk.

Note that we only port functionality for 2.0. Newer functionality
enabled by 2.0 (e.g., wear-leveling) will be submitted in following
patches.

This patches apply on top of Matias' latest patches.

Javier Gonz?lez (8):
  lightnvm: exposed generic geometry to targets
  lightnvm: show generic geometry in sysfs
  lightnvm: add support for 2.0 address format
  lightnvm: convert address based on spec. version
  lightnvm: implement get log report chunk helpers
  lightnvm: pblk: implement get log report chunk
  lightnvm: pblk: refactor init/exit sequences
  lightnvm: pblk: implement 2.0 support

 drivers/lightnvm/core.c          | 171 ++++-----
 drivers/lightnvm/pblk-core.c     | 134 +++++--
 drivers/lightnvm/pblk-gc.c       |   2 +-
 drivers/lightnvm/pblk-init.c     | 787 +++++++++++++++++++++++----------------
 drivers/lightnvm/pblk-read.c     |   2 +-
 drivers/lightnvm/pblk-recovery.c |  14 +-
 drivers/lightnvm/pblk-rl.c       |   2 +-
 drivers/lightnvm/pblk-sysfs.c    | 130 ++++++-
 drivers/lightnvm/pblk-write.c    |   2 +-
 drivers/lightnvm/pblk.h          | 253 +++++++++----
 drivers/nvme/host/lightnvm.c     | 553 ++++++++++++++++++---------
 include/linux/lightnvm.h         | 317 ++++++++++------
 12 files changed, 1553 insertions(+), 814 deletions(-)

-- 
2.7.4
