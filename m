From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:37 +0300
Subject: [PATCH 10/12] nvme-rdma: introduce nvme_rdma_start_queue
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-11-git-send-email-sagi@grimberg.me>

This should pair with nvme_rdma_stop_queue. While this
is not a complete 1x1 reverse, it still pairs up pretty
well because in fabrics we don't have a disconnect capsule
(yet) but we simply teardown the transport association.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6f5f50ed7aa8..8f8a4ecef82f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -593,24 +593,38 @@ static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 		nvme_rdma_stop_queue(&ctrl->queues[i]);
 }
 
-static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
+{
+	int ret;
+
+	if (idx)
+		ret = nvmf_connect_io_queue(&ctrl->ctrl, idx);
+	else
+		ret = nvmf_connect_admin_queue(&ctrl->ctrl);
+
+	if (!ret)
+		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[idx].flags);
+	else
+		dev_info(ctrl->ctrl.device,
+			"failed to connect queue: %d ret=%d\n", idx, ret);
+	return ret;
+}
+
+static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i, ret = 0;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
-		if (ret) {
-			dev_info(ctrl->ctrl.device,
-				"failed to connect i/o queue: %d\n", ret);
+		ret = nvme_rdma_start_queue(ctrl, i);
+		if (ret)
 			goto out_stop_queues;
-		}
-		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
 
 out_stop_queues:
-	nvme_rdma_stop_io_queues(ctrl);
+	for (i--; i >= 1; i--)
+		nvme_rdma_stop_queue(&ctrl->queues[i]);
 	return ret;
 }
 
@@ -767,12 +781,10 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 			goto out_free_queue;
 	}
 
-	error = nvmf_connect_admin_queue(&ctrl->ctrl);
+	error = nvme_rdma_start_queue(ctrl, 0);
 	if (error)
 		goto out_cleanup_queue;
 
-	set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags);
-
 	error = nvmf_reg_read64(&ctrl->ctrl, NVME_REG_CAP,
 			&ctrl->ctrl.cap);
 	if (error) {
@@ -852,7 +864,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 			ctrl->ctrl.queue_count - 1);
 	}
 
-	ret = nvme_rdma_connect_io_queues(ctrl);
+	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
 		goto out_cleanup_connect_q;
 
-- 
2.7.4
