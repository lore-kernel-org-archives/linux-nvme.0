From: Stephen.Bates@pmcs.com (Stephen Bates)
Date: Mon, 8 Jun 2015 14:48:53 +0000
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <36F6EBABA23FEF4391AF72944D228901B6BFB116@BBYEXM01.pmc-sierra.internal>

Hi

I have tested this patchset using fio and a simple script that is available at the URL below. Note testing was performed in a QEMU environment and not on real lightnvm block IO devices.

https://github.com/OpenChannelSSD/lightnvm-hw

(see the sanity.sh script in the sanity sub-folder).

Tested-by: Stephen Bates <stephen.bates at pmcs.com>

Cheers

Stephen

-----Original Message-----
From: Matias Bj?rling [mailto:m@bjorling.me] 
Sent: Friday, June 5, 2015 6:54 AM
To: hch at infradead.org; axboe at fb.com; linux-fsdevel at vger.kernel.org; linux-kernel at vger.kernel.org; linux-nvme at lists.infradead.org
Cc: javier at lightnvm.io; Stephen Bates; keith.busch at intel.com; Matias Bj?rling
Subject: [PATCH v4 0/8] Support for Open-Channel SSDs

Hi,

This is an updated version based on the feedback from Christoph.

Patch 1-2 are fixes and preparation for the nvme driver. The first fixes a flag bug. The second allows rq->special in nvme_submit_sync_cmd to be set and used.
Patch 3 fixes capacity reporting in null_blk.
Patch 4-8 introduces LightNVM and a simple target.

Jens, the patches are on top of your for-next tree.

Development and further information on LightNVM can be found at:

  https://github.com/OpenChannelSSD/linux

Changes since v3:

 - Remove dependence on REQ_NVM_GC
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

Matias Bj?rling (8):
  nvme: add special param for nvme_submit_sync_cmd
  nvme: don't overwrite req->cmd_flags on sync cmd
  null_blk: wrong capacity when bs is not 512 bytes
  bio: Introduce LightNVM payload
  lightnvm: Support for Open-Channel SSDs
  lightnvm: RRPC target
  null_blk: LightNVM support
  nvme: LightNVM support

 Documentation/block/null_blk.txt |    8 +
 MAINTAINERS                      |    9 +
 drivers/Kconfig                  |    2 +
 drivers/Makefile                 |    2 +
 drivers/block/Makefile           |    2 +-
 drivers/block/null_blk.c         |  136 ++++-
 drivers/block/nvme-core.c        |  134 ++++-
 drivers/block/nvme-lightnvm.c    |  320 +++++++++++
 drivers/block/nvme-scsi.c        |    4 +-
 drivers/lightnvm/Kconfig         |   26 +
 drivers/lightnvm/Makefile        |    6 +
 drivers/lightnvm/core.c          |  833 +++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.c          | 1088 ++++++++++++++++++++++++++++++++++++++
 drivers/lightnvm/rrpc.h          |  221 ++++++++
 include/linux/bio.h              |    9 +
 include/linux/blk_types.h        |    4 +-
 include/linux/blkdev.h           |    2 +
 include/linux/genhd.h            |    3 +
 include/linux/lightnvm.h         |  379 +++++++++++++
 include/linux/nvme.h             |   11 +-
 include/uapi/linux/nvme.h        |  131 +++++
 21 files changed, 3300 insertions(+), 30 deletions(-)  create mode 100644 drivers/block/nvme-lightnvm.c  create mode 100644 drivers/lightnvm/Kconfig  create mode 100644 drivers/lightnvm/Makefile  create mode 100644 drivers/lightnvm/core.c  create mode 100644 drivers/lightnvm/rrpc.c  create mode 100644 drivers/lightnvm/rrpc.h  create mode 100644 include/linux/lightnvm.h

--
2.1.4
