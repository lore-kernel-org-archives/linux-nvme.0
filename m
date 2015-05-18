From: keith.busch@intel.com (Keith Busch)
Date: Mon, 18 May 2015 13:30:19 -0600
Subject: [PATCH 0/4] Namespace handling updates and fixes
Message-ID: <1431977423-31587-1-git-send-email-keith.busch@intel.com>

This makes it possible to take down namespaces dynamically and hot remove
mounted namespaces. It's combining a few presvious patches submitted
to the list, and this replaces them all since they're touching a lot of
the same code.

Keith Busch (4):
  blk: Define blk_set_queue_dying in header
  NVMe: Decouple nvmeq hctx from ns request queue
  NVMe: Automatic namespace rescan
  NVMe: Remove disks before shutdown

 drivers/block/nvme-core.c |  198 ++++++++++++++++++++++++++++++++-------------
 include/linux/blkdev.h    |    1 +
 include/linux/nvme.h      |    2 +
 include/uapi/linux/nvme.h |    4 +
 4 files changed, 148 insertions(+), 57 deletions(-)

-- 
1.7.10.4
