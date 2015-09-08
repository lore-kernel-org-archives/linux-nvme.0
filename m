From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Sep 2015 14:13:07 -0600
Subject: [PATCH] NVMe: Force cancel commands on hot-removal
Message-ID: <1441743187-12277-1-git-send-email-keith.busch@intel.com>

On a surprise removal when pciehp is in use, the port services driver
will usually notify the nvme driver to remove the device before the
nvme polling thread detects it is gone. If this happens, the queues are
not shutdown prior to deleting namespace gendisks, so there may be IO
outstanding that will never complete. An unnecessarily long timeout has to
happen in order to complete the IO's with failure status. This patch fixes
that by clearing the queues first when we know the device is IO incapable.

Reported-by: Mohana Goli <mohana.goli at seagate.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..cf052b5 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2402,8 +2402,19 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 {
 	bool kill = nvme_io_incapable(ns->dev) && !blk_queue_dying(ns->queue);
 
-	if (kill)
+	if (kill) {
+		int i;
+		struct blk_mq_hw_ctx *hctx;
+
 		blk_set_queue_dying(ns->queue);
+		queue_for_each_hw_ctx(ns->queue, hctx, i) {
+			if (!hctx->tags)
+				continue;
+			blk_mq_all_tag_busy_iter(hctx->tags,
+						nvme_cancel_queue_ios,
+						hctx->driver_data);
+		}
+	}
 	if (ns->disk->flags & GENHD_FL_UP) {
 		if (blk_get_integrity(ns->disk))
 			blk_integrity_unregister(ns->disk);
-- 
1.7.10.4
