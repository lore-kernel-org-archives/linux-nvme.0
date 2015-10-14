From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Wed, 14 Oct 2015 16:42:13 +0200
Subject: [PATCH v9 0/5] Support for Open-Channel SSDs
Message-ID: <1444833738-8961-1-git-send-email-m@bjorling.me>

This patchset implements support for Open-Channel SSDs.

Applies against Jens' for-next and is available through the lkml_v9 branch at:

  https://github.com/OpenChannelSSD/linux

Changes since v8:
 - Specification was changed to define a SSD configuration using a single entry.
   This replaces the per-lun specification with a single configuration. Easing
   the access to global geometry values and simplifies address calculations.
 - Implement PPA addressing modes. Encode NAND flash structure into physical
   page addresses. An address now has bits reserved for each part of the flash
   units (sectors, page, block, plane, lun, channels), replacing the linear
   address space previously found in the LightNVM specification.
 - Rename bm_hb to gennvm (generic nvm manager). This part now covers any type
   of non-volatile memory media. Thus, it is not only a block manager, but
   manages several pieces of core information.
 - Add detection for CNEX Westlake controller.
 - Completion of I/Os was previously directly completed in the target. Push
   completion through the media manager first and then target.
 - Rebased on top of latest changes to the NVMe device driver architecture.
 - Various fixes and refactoring.

Changes since v7:
 - The IOCTL management interface have been created. Devices can now be
   managed through the lightnvm-adm tool (ladm). This is available from:
     https://github.com/OpenChannelSSD/lightnvm-adm.git
 - The debugging management interface is now only available if debugging
   is enabled. (/sys/module/lnvm/parameters/configure_debug)
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
  gennvm: Generic NVM manager
  rrpc: Round-robin sector target with cost-based gc
  null_nvm: LightNVM test driver
  nvme: LightNVM support

 Documentation/ioctl/ioctl-number.txt |    1 +
 MAINTAINERS                          |    8 +
 drivers/Kconfig                      |    2 +
 drivers/Makefile                     |    1 +
 drivers/lightnvm/Kconfig             |   48 ++
 drivers/lightnvm/Makefile            |    8 +
 drivers/lightnvm/core.c              |  856 ++++++++++++++++++++++
 drivers/lightnvm/gennvm.c            |  467 ++++++++++++
 drivers/lightnvm/gennvm.h            |   46 ++
 drivers/lightnvm/null_nvm.c          |  463 ++++++++++++
 drivers/lightnvm/rrpc.c              | 1308 ++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h              |  239 +++++++
 drivers/nvme/host/Makefile           |    2 +-
 drivers/nvme/host/lightnvm.c         |  597 ++++++++++++++++
 drivers/nvme/host/nvme.h             |   10 +
 drivers/nvme/host/pci.c              |   39 +-
 include/linux/lightnvm.h             |  516 ++++++++++++++
 include/uapi/linux/lightnvm.h        |  130 ++++
 18 files changed, 4729 insertions(+), 12 deletions(-)
 create mode 100644 drivers/lightnvm/Kconfig
 create mode 100644 drivers/lightnvm/Makefile
 create mode 100644 drivers/lightnvm/core.c
 create mode 100644 drivers/lightnvm/gennvm.c
 create mode 100644 drivers/lightnvm/gennvm.h
 create mode 100644 drivers/lightnvm/null_nvm.c
 create mode 100644 drivers/lightnvm/rrpc.c
 create mode 100644 drivers/lightnvm/rrpc.h
 create mode 100644 drivers/nvme/host/lightnvm.c
 create mode 100644 include/linux/lightnvm.h
 create mode 100644 include/uapi/linux/lightnvm.h

-- 
2.1.4
