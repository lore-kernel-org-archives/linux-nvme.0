From: sjones@kalray.eu (Samuel Jones)
Date: Tue, 25 Oct 2016 09:22:34 +0200 (CEST)
Subject: [PATCH] rdma: force queue size to respect controller capability
Message-ID: <444159155.19898733.1477380154029.JavaMail.zimbra@kalray.eu>

Queue size needs to respect the Maximum Queue Entries Supported advertised by
the controller in its Capability register.

Signed-off-by: Samuel Jones <sjones at kalray.eu>
---
 drivers/nvme/host/rdma.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5a83881..98d9c09 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1908,6 +1908,14 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		opts->queue_size = ctrl->ctrl.maxcmd;
 	}
 
+	if (opts->queue_size > ctrl->ctrl.sqsize) {
+		/* warn if sqsize is lower than queue_size */
+		dev_warn(ctrl->ctrl.device,
+			"queue_size %zu > ctrl sqsize %u, clamping down\n",
+			opts->queue_size, ctrl->ctrl.sqsize);
+		opts->queue_size = ctrl->ctrl.sqsize;
+	}
+
 	if (opts->nr_io_queues) {
 		ret = nvme_rdma_create_io_queues(ctrl);
 		if (ret)
-- 
1.8.3.1
