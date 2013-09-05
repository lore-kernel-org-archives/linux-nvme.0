From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:06 -0600
Subject: [PATCH 0/9] NVMe: Error handling
Message-ID: <1378413915-16667-1-git-send-email-keith.busch@intel.com>

These are a bunch of patches to handle errors and replaces this set:

http://merlin.infradead.org/pipermail/linux-nvme/2013-August/000354.html

Keith Busch (9):
  NVMe: Merge issue on character device bring-up
  NVMe: Differentiate commands not completed
  NVMe: Fail device if unresponsive during init
  NVMe: Reset failed controller
  NVMe: Abort timed out commands
  NVMe: User initiated controller reset
  NVMe: Add shutdown pci callback
  NVMe: Set queue db only when queue is initialized
  NVMe: Don't wait for delete queues to complete

 drivers/block/nvme-core.c |  237 ++++++++++++++++++++++++++++++++++++--------
 include/linux/nvme.h      |    3 +
 include/uapi/linux/nvme.h |   11 ++
 3 files changed, 208 insertions(+), 43 deletions(-)
