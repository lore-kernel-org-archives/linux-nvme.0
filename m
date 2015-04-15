From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 15 Apr 2015 14:34:39 +0200
Subject: [PATCH 0/5 v2] Support for Open-Channel SSDs
Message-ID: <1429101284-19490-1-git-send-email-m@bjorling.me>

A problem with SSDs is that they expose a narrow read/write interface,
where the host and device must communicate their intent. The narrow
interface leaves little information to be carried down from file-systems
and applications, and therefore performance guarantees in these devices
are best-efforts.

In the case of SSDs, there are various approaches to mitigate it.
Examples include trim and multi-streams. However, these approaches are
specialized by each vendor, each having their own behavior. More
importantly, they do not allow the host to completely control data
placement, parallelism and garbage collection.

By exposing the physical characteristics of an SSD to the host,
file-systems and applications can directly place data and control when
and where garbage collection should be applied. We call the class of
SSDs that expose these physical characteristics Open-Channel SSDs.

For this class of SSDs, LightNVM is a specification that defines a
common interface. It allows the host to manage data placement, garbage
collection, and parallelism. With it, the kernel can expose a building
block for further integration into file-systems and applications.
Immediate benefits include strict control of access latency and IO
response variance.

This patchset wires up support in the block layer, introduces a simple
block device target called rrpc, and at last adds support in the
null_blk and NVMe drivers.

Patches are against v4.0.

Development and further information on LightNVM can be found at:

  https://github.com/OpenChannelSSD/linux

Changes since v1:

 - Splitted LightNVM into two parts. A get/put interface for flash
   blocks and the respective targets that implement flash translation
   layer logic.
 - Updated the patches accordring to the LightNVM specification changes.
 - Added interface to add/remove targets for a block device.

Matias Bj?rling (5):
  blk-mq: Add prep/unprep support
  blk-mq: Support for Open-Channel SSDs
  lightnvm: RRPC target
  null_blk: LightNVM support
  nvme: LightNVM support

 Documentation/block/null_blk.txt |    8 +
 block/Kconfig                    |   12 +
 block/Makefile                   |    2 +-
 block/blk-mq.c                   |   40 +-
 block/blk-nvm.c                  |  722 ++++++++++++++++++++++
 block/blk-sysfs.c                |   11 +
 block/blk.h                      |   18 +
 drivers/Kconfig                  |    2 +
 drivers/Makefile                 |    2 +
 drivers/block/null_blk.c         |   89 ++-
 drivers/block/nvme-core.c        |  380 +++++++++++-
 drivers/lightnvm/Kconfig         |   29 +
 drivers/lightnvm/Makefile        |    5 +
 drivers/lightnvm/rrpc.c          | 1222 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h          |  203 +++++++
 include/linux/bio.h              |    9 +
 include/linux/blk-mq.h           |    3 +
 include/linux/blk_types.h        |   12 +-
 include/linux/blkdev.h           |  218 +++++++
 include/linux/lightnvm.h         |   55 ++
 include/linux/nvme.h             |    2 +
 include/uapi/linux/nvm.h         |   70 +++
 include/uapi/linux/nvme.h        |  116 ++++
 23 files changed, 3217 insertions(+), 13 deletions(-)
 create mode 100644 block/blk-nvm.c
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/rrpc.c
 create mode 100644 drivers/lightnvm/rrpc.h
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/nvm.h

-- 
1.9.1
