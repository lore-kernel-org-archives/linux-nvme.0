From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 22 Apr 2015 16:26:49 +0200
Subject: [PATCH v3 0/7] Support for Open-Channel SSDs
Message-ID: <1429712816-10336-1-git-send-email-m@bjorling.me>

Hi,

This is an updated version based on the feedback from Paul, Keith and
Christoph.

Patches are against v4.0.

Development and further information on LightNVM can be found at:

  https://github.com/OpenChannelSSD/linux

Changes since v2:

 Feedback from Paul Bolle:
 - Fix license to GPLv2, documentation, compilation.
 Feedback from Keith Busch:
 - nvme: Move lightnvm out and into nvme-lightnvm.c.
 - nvme: Set controller css on lightnvm command set.
 - nvme: Remove OACS.
 Feedback from Christoph Hellwig:
 - lightnvm: Move out of block layer into /drivers/lightnvm/core.c
 - lightnvm: refactor request->phys_sector into device drivers.
 - lightnvm: refactor prep/unprep into device drivers.
 - lightnvm: move nvm_dev from request_queue to gendisk.

 New
 - Bad block table support (From Javier).
 - Update maintainers file.

Changes since v1:

 - Splitted LightNVM into two parts. A get/put interface for flash
   blocks and the respective targets that implement flash translation
   layer logic.
 - Updated the patches according to the LightNVM specification changes.
 - Added interface to add/remove targets for a block device.

Javier Gonz?lez (1):
  nvme: rename and expose nvme_alloc_iod

Matias Bj?rling (6):
  bio: Introduce LightNVM payload
  block: add REQ_NVM_GC for targets gc
  lightnvm: Support for Open-Channel SSDs
  lightnvm: RRPC target
  null_blk: LightNVM support
  nvme: LightNVM support

 Documentation/block/null_blk.txt |    8 +
 MAINTAINERS                      |    8 +
 drivers/Kconfig                  |    2 +
 drivers/Makefile                 |    2 +
 drivers/block/Makefile           |    2 +-
 drivers/block/null_blk.c         |  116 +++-
 drivers/block/nvme-core.c        |  112 +++-
 drivers/block/nvme-lightnvm.c    |  401 +++++++++++++
 drivers/lightnvm/Kconfig         |   26 +
 drivers/lightnvm/Makefile        |    6 +
 drivers/lightnvm/core.c          |  804 ++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.c          | 1176 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h          |  215 +++++++
 include/linux/bio.h              |    9 +
 include/linux/blk_types.h        |    9 +-
 include/linux/blkdev.h           |    2 +
 include/linux/genhd.h            |    3 +
 include/linux/lightnvm.h         |  312 ++++++++++
 include/linux/nvme.h             |    8 +
 include/uapi/linux/lightnvm.h    |   70 +++
 include/uapi/linux/nvme.h        |  132 +++++
 21 files changed, 3400 insertions(+), 23 deletions(-)
 create mode 100644 drivers/block/nvme-lightnvm.c
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 drivers/lightnvm/rrpc.c
 create mode 100644 drivers/lightnvm/rrpc.h
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/lightnvm.h

-- 
1.9.1
