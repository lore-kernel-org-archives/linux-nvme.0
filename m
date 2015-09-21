From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 21 Sep 2015 18:05:45 +0200
Subject: [PATCH v8 0/5] Support for Open-Channel SSDs
Message-ID: <1442851550-25249-1-git-send-email-m@bjorling.me>

These patches implement support for Open-Channel SSDs.

Applies against v4.2 and available through the lkml_v8 branch at:

  https://github.com/OpenChannelSSD/linux

Major changes from last revision is:

 - The NVMe driver is no longer forced to use a non-standard way to
   detect LightNVM devices. It now uses PCI IDs until the identification
   method have been standardized. Keith, is this good with you?
 - The IOCTL management interface have been created. Devices can now be
   managed through the lightnvm-adm tool (ladm). This is available from:
     https://github.com/OpenChannelSSD/lightnvm-adm.git
 - The debugging management interface is now only available if debugging
   is enabled. (/sys/module/lnvm/parameters/configure_debug)

Any feedback is greatly appreciated.

Changes since v7:
 - GCC compatibility fixes (Dongsheng Yang)
 - Fix for BM initialization (Dongsheng Yang)
 - Fix for error during rrpc init (Javier Gonzalez)
 - Refactor NVMe driver to not expect non-standard behavior. Added PCI
   id identification for selected devices (qemu-nvme and cnex).
 - Enable NVMe metadata to be passed from target.
 - Create ioctl interface for management.
 - Add NVM_DEBUG flag to explicit enable/diskable parameter
   configure_debug access. The interface is only available if debugging
   is enabled.
 - Add support for physical block address commands.
 - Added uapi/lightnvm.h header to expose ioctl interface.
 - Fix qemu-nvme initialization extensions regarding L2P translation
   support.
 - Clean up of dead code.
 - Updated e-mails, copyrights, etc.


Changes since v6:
 - Multipage support (Javier Gonzalez)
 - General code cleanups
 - Fixed memleak on register failure

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
  lightnvm: Hybrid Open-Channel SSD block manager
  lightnvm: RRPC target
  null_nvm: LightNVM test driver
  nvme: LightNVM support

 Documentation/ioctl/ioctl-number.txt |    1 +
 MAINTAINERS                          |    8 +
 drivers/Kconfig                      |    2 +
 drivers/Makefile                     |    4 +
 drivers/block/Makefile               |    2 +-
 drivers/block/nvme-core.c            |   38 +-
 drivers/block/nvme-lightnvm.c        |  607 ++++++++++++++++
 drivers/lightnvm/Kconfig             |   48 ++
 drivers/lightnvm/Makefile            |    8 +
 drivers/lightnvm/bm_hb.c             |  372 ++++++++++
 drivers/lightnvm/bm_hb.h             |   46 ++
 drivers/lightnvm/core.c              |  832 ++++++++++++++++++++++
 drivers/lightnvm/null_nvm.c          |  468 ++++++++++++
 drivers/lightnvm/rrpc.c              | 1303 ++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h              |  236 ++++++
 include/linux/lightnvm.h             |  350 +++++++++
 include/linux/nvme.h                 |    6 +
 17 files changed, 4319 insertions(+), 12 deletions(-)
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
