From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Dec 2014 17:54:12 -0700
Subject: [PATCH 0/4] nvme-blkmq fixes
Message-ID: <1419036856-16275-1-git-send-email-keith.busch@intel.com>

This fixes some surprise hot plug and error handling cases.

There is still one deadlock when we run out of tags and get stuck in
bt_get, but Jens sent me a test patch that I verfied fixes that when
used with this set.

Keith Busch (4):
  blk-mq: Exit queue on alloc failure
  blk-mq: Export freeze/unfreeze functions
  NVMe: Fix double free irq
  NVMe: Freeze queues on shutdown

 block/blk-mq.c            |   10 +++++++---
 drivers/block/nvme-core.c |   46 ++++++++++++++++++++++++++++++++++++---------
 include/linux/blk-mq.h    |    2 ++
 3 files changed, 46 insertions(+), 12 deletions(-)

-- 
1.7.10.4
