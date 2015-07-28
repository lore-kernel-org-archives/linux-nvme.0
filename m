From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Tue, 28 Jul 2015 13:17:43 +0200
Subject: [PATCH v6 0/5] Support for Open-Channel SSDs
Message-ID: <1438082268-13496-1-git-send-email-mb@lightnvm.io>

These patches implement support for Open-Channel SSDs.

Applies against axboe's linux-block/for-4.3/drivers, and can be found
in the lkml_v6 branch at https://github.com/OpenChannelSSD/linux

Any feedback is greatly appreciated.

Changes since v5:

Feedback from Christoph Hellwig.
 - Created new null_nvm from null_blk to register itself as a lightnvm
   device.
 - Changed the interface of register/unregister to only take disk_name.
   The gendisk alloc in nvme is kept. Most instantiations will
   involve the device gendisk, therefore wait with refactoring to a
   later time.
 - Renamed global parameters in core.c and rrpc.c

Changes since v4:
 - Remove gendisk->nvm dependency
 - Remove device driver rq private field dependency.
 - Update submission and completion. The flow is now
     Target -> Block Manager -> Device Driver, replacing callbacks in
     device driver.
 - Abstracted out the block manager into its own module. Other block
   managers can now be implemented. For example to support fully
   host-based SSDs.
 - No longer exposes the device driver gendisk to user-space.
 - Management is moved into /sys/modules/lnvm/parameters/configure_debug

Changes since v3:

 - Remove dependency on REQ_NVM_GC
 - Refactor nvme integration to use nvme_submit_sync_cmd for
   internal commands.
 - Fix race condition bug on multiple threads on RRPC target.
 - Rename sysfs entry under the block device from nvm to lightnvm.
   The configuration is found in /sys/block/*/lightnvm/

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

Thanks to Jens Axboe, Christoph Hellwig, Keith Busch, Paul Bolle,
Javier Gonzalez and Jesper Madsen for discussions and contributions.

Matias Bj?rling (5):
  lightnvm: Support for Open-Channel SSDs
  lightnvm: Hybrid Open-Channel SSD RRPC target
  lightnvm: Hybrid Open-Channel SSD block manager
  null_nvm: Lightnvm test driver
  nvme: LightNVM support

 MAINTAINERS                   |    8 +
 drivers/Kconfig               |    2 +
 drivers/Makefile              |    5 +
 drivers/block/Makefile        |    2 +-
 drivers/block/nvme-core.c     |   22 +-
 drivers/block/nvme-lightnvm.c |  509 ++++++++++++++++++
 drivers/lightnvm/Kconfig      |   36 ++
 drivers/lightnvm/Makefile     |    8 +
 drivers/lightnvm/bm_hb.c      |  379 +++++++++++++
 drivers/lightnvm/bm_hb.h      |   31 ++
 drivers/lightnvm/core.c       |  580 ++++++++++++++++++++
 drivers/lightnvm/null_nvm.c   |  420 +++++++++++++++
 drivers/lightnvm/rrpc.c       | 1190 +++++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h       |  220 ++++++++
 include/linux/lightnvm.h      |  385 +++++++++++++
 include/linux/nvme.h          |    6 +
 include/uapi/linux/nvme.h     |    3 +
 17 files changed, 3802 insertions(+), 4 deletions(-)
 create mode 100644 drivers/block/nvme-lightnvm.c
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/bm_hb.c
 create mode 100644 drivers/lightnvm/bm_hb.h
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 drivers/lightnvm/null_nvm.c
 create mode 100644 drivers/lightnvm/rrpc.c
 create mode 100644 drivers/lightnvm/rrpc.h
 create mode 100644 include/linux/lightnvm.h

-- 
2.1.4
