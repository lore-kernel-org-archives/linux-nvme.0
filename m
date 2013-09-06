From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 6 Sep 2013 16:41:58 -0400
Subject: [PULL REQUEST] NVM Express updates
Message-ID: <20130906204158.GB4668@linux.intel.com>

Hi Linus,

Please pull the NVMe tree.

The following changes since commit a2648ebb7ed69ef209d9c8a76fadeb3252d9a023:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/mason/linux-btrfs (2013-06-13 22:34:14 -0700)

are available in the git repository at:


  git://git.infradead.org/users/willy/linux-nvme.git master

for you to fetch changes up to d82e8bfdef9afae83b894be49af4644d9ac3c359:
  NVMe: Merge issue on character device bring-up (2013-09-06 16:26:58 -0400)

----------------------------------------------------------------
Keith Busch (12):
      NVMe: Disk IO statistics
      NVMe: Update nvme_id_power_state with latest spec
      NVMe: Fix checkpatch issues
      NVMe: Bring up cdev on set feature failure
      NVMe: Disk stats for read/write commands only
      NVMe: Group pci related actions in functions
      NVMe: Separate queue alloc/free from create/delete
      NVMe: Separate controller init from disk discovery
      NVMe: Use normal shutdown
      NVMe: Add pci suspend/resume driver callbacks
      NVMe: Handle ioremap failure
      NVMe: Merge issue on character device bring-up

Matthew Wilcox (6):
      NVMe: Restructure MSI / MSI-X setup
      NVMe: Return correct value from interrupt handler
      NVMe: Remove "process_cq did something" message
      NVMe: Call nvme_process_cq from submission path
      NVMe: Split header file into user-visible and kernel-visible pieces
      NVMe: Namespace IDs are unsigned

Tushar Behera (1):
      NVMe: Use kzalloc instead of kmalloc+memset

 drivers/block/nvme-core.c | 585 +++++++++++++++++++++++++++++++---------------
 drivers/block/nvme-scsi.c |  24 +-
 include/linux/nvme.h      | 466 +-----------------------------------
 include/uapi/linux/Kbuild |   1 +
 include/uapi/linux/nvme.h | 477 +++++++++++++++++++++++++++++++++++++
 5 files changed, 895 insertions(+), 658 deletions(-)
 create mode 100644 include/uapi/linux/nvme.h
