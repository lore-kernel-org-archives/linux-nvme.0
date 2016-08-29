From: swise@opengridcomputing.com (Steve Wise)
Date: Mon, 29 Aug 2016 14:27:07 -0700
Subject: [PATCH WIP/RFC v2 3/6] nvme_rdma: keep a ref on the ctrl during
 delete/flush
In-Reply-To: <cover.1472506505.git.swise@opengridcomputing.com>
References: <cover.1472506505.git.swise@opengridcomputing.com>
Message-ID: <f3b74c6ef7caba2fdff194be0c90ec7423103893.1472506505.git.swise@opengridcomputing.com>

Reviewed-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimbrg.me>
Signed-off-by: Steve Wise <swise at opengridcomputing.com>
---
 drivers/nvme/host/rdma.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index c133256..8d22b95 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1356,9 +1356,15 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 		ret = 1;
 	}
 
-	/* Queue controller deletion */
+	/*
+	 * Queue controller deletion. Keep a reference until all
+	 * work is flushed since delete_work will free the ctrl mem
+	 */
+	kref_get(&ctrl->ctrl.kref);
 	queue_work(nvme_rdma_wq, &ctrl->delete_work);
 	flush_work(&ctrl->delete_work);
+	nvme_put_ctrl(&ctrl->ctrl);
+
 	return ret;
 }
 
@@ -1705,15 +1711,18 @@ static int __nvme_rdma_del_ctrl(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_del_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	int ret;
+	int ret = 0;
 
+	/*
+	 * Keep a reference until all work is flushed since
+	 * __nvme_rdma_del_ctrl can free the ctrl mem
+	 */
+	kref_get(&ctrl->ctrl.kref);
 	ret = __nvme_rdma_del_ctrl(ctrl);
-	if (ret)
-		return ret;
-
-	flush_work(&ctrl->delete_work);
-
-	return 0;
+	if (!ret)
+		flush_work(&ctrl->delete_work);
+	nvme_put_ctrl(&ctrl->ctrl);
+	return ret;
 }
 
 static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
-- 
2.7.0
