From: israelr@mellanox.com (Israel Rukshin)
Date: Sun,  4 Nov 2018 16:37:14 +0000
Subject: [PATCH] nvme-rdma: Don't fail the controller if only part of the
 queues fail to connect
Message-ID: <1541349434-31640-1-git-send-email-israelr@mellanox.com>

From: Sagi Grimberg <sagi@grimberg.me>

blk-mq tells us to skip unmapped queues but we fail the controller altogether.

Signed-off-by: Israel Rukshin <israelr at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6f1bd79..c6dd1efe 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -643,20 +643,33 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 
 static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
-	int i, ret = 0;
+	int i, ret, count = 0;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_start_queue(ctrl, i);
-		if (ret)
+		if (ret) {
+			if (ret == -EXDEV) {
+				/* unmapped queue, skip ... */
+				nvme_rdma_free_queue(&ctrl->queues[i]);
+				continue;
+			}
 			goto out_stop_queues;
+		}
+		count++;
 	}
 
+	if (!count)
+		/* no started queues, fail */
+		return -EIO;
+
+	dev_info(ctrl->ctrl.device, "connected %d I/O queues.\n", count);
+
 	return 0;
 
 out_stop_queues:
 	for (i--; i >= 1; i--)
 		nvme_rdma_stop_queue(&ctrl->queues[i]);
-	return ret;
+	return -EIO;
 }
 
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
-- 
1.8.3.1
