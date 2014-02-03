From: willy@linux.intel.com (Matthew Wilcox)
Date: Mon, 3 Feb 2014 11:06:35 -0500
Subject: [PULL REQUEST] NVMe driver updates for 3.14
Message-ID: <20140203160635.GE2285@linux.intel.com>


Hi Linus,

Looks like I missed the merge window ... but these are almost all bugfixes
anyway (the ones that aren't have been baking for months).

The following changes since commit 2d3c627502f2a9b0a7de06a5a2df2365542a72c9:

  Revert "init/Kconfig: add option to disable kernel compression" (2013-11-17 11:17:36 -0800)

are available in the git repository at:

  git://git.infradead.org/users/willy/linux-nvme.git master

for you to fetch changes up to 9ac27090f61ea6735a62b0a98c7669c833bcdc09:

  NVMe: Namespace use after free on surprise removal (2014-02-02 13:31:15 -0500)

----------------------------------------------------------------
Haiyan Hu (1):
      NVMe: Avoid shift operation when writing cq head doorbell

Keith Busch (9):
      NVMe: compat SG_IO ioctl
      NVMe: Device resume error handling
      NVMe: Schedule reset for failed controllers
      NVMe: Abort timed out commands
      NVMe: Surprise removal handling
      NVMe: Async IO queue deletion
      NVMe: Disable admin queue on init failure
      NVMe: Add a pci_driver shutdown method
      NVMe: Namespace use after free on surprise removal

Matthew Wilcox (5):
      NVMe: Fix lockdep warnings
      NVMe: Cache dev->pci_dev in a local pointer
      NVMe: Dynamically allocate partition numbers
      NVMe: Include device and queue numbers in interrupt name
      NVMe: Correct uses of INIT_WORK

Michael Opdenacker (1):
      NVMe: remove deprecated IRQF_DISABLED

 drivers/block/nvme-core.c | 610 ++++++++++++++++++++++++++++++++++++++--------
 drivers/block/nvme-scsi.c | 147 +++++++++++
 include/linux/nvme.h      |   6 +-
 include/uapi/linux/nvme.h |  11 +
 4 files changed, 668 insertions(+), 106 deletions(-)
