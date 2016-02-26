From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 25 Feb 2016 19:36:35 -0700
Subject: [Patchv2 0/3] NVMe: Introduce CMB allocation scheme
Message-ID: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>

This set is a continuation of v1 introduced in December [1].
v1 was missing the controls to reduce the queue depth, and so would
allow tags to be issued above the depth of the CMB allocated queues.

v2 drops patch 3 of v1 which created a cmb_resources file with a layout
similar to the pci_dev resource file.

This set was tested with QEMU with NVMe device emulation [2]

Applies to Jen's for-4.6/drivers [3]

[1] http://lists.infradead.org/pipermail/linux-nvme/2015-December/003510.html
[2] git://git.infradead.org/users/kbusch/qemu-nvme.git
[3] https://git.kernel.org/cgit/linux/kernel/git/axboe/linux-block.git/log/?h=for-4.6/drivers

Jon Derrick (3):
  blk-mq: helper to reduce queue depth on all hardware contexts
  NVMe: Introduce sysfs entries for submission queues in CMB
  NVMe: Generate resource tree for CMB

 block/blk-mq.c           |  20 ++++
 drivers/nvme/host/core.c | 136 ++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  22 +++++
 drivers/nvme/host/pci.c  | 238 ++++++++++++++++++++++++++++++++---------------
 include/linux/blk-mq.h   |   1 +
 5 files changed, 339 insertions(+), 78 deletions(-)

-- 
2.1.4
