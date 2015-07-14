From: keith.busch@intel.com (Keith Busch)
Date: Tue, 14 Jul 2015 11:57:48 -0600
Subject: [PATCH] NVMe: Reread partitions on metadata formats
Message-ID: <1436896668-27373-1-git-send-email-keith.busch@intel.com>

This patch has the driver automatically reread partitions if a namespace
has a separate metadata format. Previously revalidating a disk was
sufficient to get the correct capacity set on such formatted drives,
but partitions that may exist would not have been surfaced.

Reported-by: Paul Grabinar <paul.grabinar at ranbarg.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Matthew Wilcox <willy at linux.intel.com>
Cc: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index d1d6141..7920c27 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2108,8 +2108,17 @@ static void nvme_alloc_ns(struct nvme_dev *dev, unsigned nsid)
 		goto out_free_disk;
 
 	add_disk(ns->disk);
-	if (ns->ms)
-		revalidate_disk(ns->disk);
+	if (ns->ms) {
+		struct block_device *bd = bdget_disk(ns->disk, 0);
+		if (!bd)
+			return;
+		if (blkdev_get(bd, FMODE_READ, NULL)) {
+			bdput(bd);
+			return;
+		}
+		blkdev_reread_part(bd);
+		blkdev_put(bd, FMODE_READ);
+	}
 	return;
  out_free_disk:
 	kfree(disk);
-- 
1.7.10.4
