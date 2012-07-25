From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jul 2012 09:59:23 -0600
Subject: [PATCH] NVMe: Set request queue logical block size
Message-ID: <1343231963-3075-1-git-send-email-keith.busch@intel.com>

Sets the request queue logical block size with the block size of the namespace.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index f4996b0..38b9c73 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1344,6 +1344,7 @@ static struct nvme_ns *nvme_alloc_ns(struct nvme_dev *dev, int nsid,
 	ns->disk = disk;
 	lbaf = id->flbas & 0xf;
 	ns->lba_shift = id->lbaf[lbaf].ds;
+	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 
 	disk->major = nvme_major;
 	disk->minors = NVME_MINORS;
-- 
1.7.1
