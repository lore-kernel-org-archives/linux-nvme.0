From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 11 Apr 2014 10:09:47 -0400
Subject: [PULL REQUEST] NVMe driver updates for 3.15
Message-ID: <20140411140947.GN5727@linux.intel.com>


Hi Linus,

Various updates to the NVMe driver.  The most user-visible change is
that drive hotplugging now works and CPU hotplug while an NVMe drive is
installed should also work better.

The following changes since commit dcb99fd9b08cfe1afe426af4d8d3cbc429190f15:

  Linux 3.14-rc7 (2014-03-16 18:51:24 -0700)

are available in the git repository at:

  git://git.infradead.org/users/willy/linux-nvme.git master

for you to fetch changes up to edd10d33283899fb15d99a290dcc9ceb3604ca78:

  NVMe: Retry failed commands with non-fatal errors (2014-04-10 17:11:59 -0400)

----------------------------------------------------------------
Dan McLeran (1):
      NVMe: Start-stop nvme_thread during device add-remove.

Jingoo Han (1):
      NVMe: Add CONFIG_PM_SLEEP to suspend/resume functions

Keith Busch (9):
      NVMe: Initialize device reference count earlier
      NVMe: RCU protected access to io queues
      NVMe: IOCTL path RCU protect queue access
      NVMe: Fix divide-by-zero in nvme_trans_io_get_num_cmds
      NVMe: per-cpu io queues
      NVMe: CPU hot plug notification
      NVMe: Make I/O timeout a module parameter
      NVMe: Add getgeo to block ops
      NVMe: Retry failed commands with non-fatal errors

Matthew Wilcox (1):
      NVMe: Replace DEFINE_PCI_DEVICE_TABLE

 drivers/block/nvme-core.c | 684 ++++++++++++++++++++++++++++++++--------------
 drivers/block/nvme-scsi.c |  43 +--
 include/linux/nvme.h      |  21 +-
 include/uapi/linux/nvme.h |   1 +
 4 files changed, 504 insertions(+), 245 deletions(-)
