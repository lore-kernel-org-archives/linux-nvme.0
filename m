From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 19 Jun 2018 15:34:13 +0300
Subject: [PATCH 5/7] nvme-rdma: don't override opts->queue_size
In-Reply-To: <20180619123415.25077-1-sagi@grimberg.me>
References: <20180619123415.25077-1-sagi@grimberg.me>
Message-ID: <20180619123415.25077-6-sagi@grimberg.me>

That is user argument, and theoretically controller limits can
change over time (over reconnects/resets). Instead, use sqsize
controller attribute to check queue depth boundaries and use it
to the tagset allocation.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index edf63cd106ff..9dc1c37b5f65 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -692,7 +692,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set = &ctrl->tag_set;
 		memset(set, 0, sizeof(*set));
 		set->ops = &nvme_rdma_mq_ops;
-		set->queue_depth = nctrl->opts->queue_size;
+		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = 1; /* fabric connect */
 		set->numa_node = NUMA_NO_NODE;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
@@ -1977,20 +1977,22 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		goto out_remove_admin_queue;
 	}
 
-	if (opts->queue_size > ctrl->ctrl.maxcmd) {
-		/* warn if maxcmd is lower than queue_size */
-		dev_warn(ctrl->ctrl.device,
-			"queue_size %zu > ctrl maxcmd %u, clamping down\n",
-			opts->queue_size, ctrl->ctrl.maxcmd);
-		opts->queue_size = ctrl->ctrl.maxcmd;
-	}
-
 	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
-		/* warn if sqsize is lower than queue_size */
+		/*
+		 * warn if sqsize is lower than queue_size actual calmping
+		 * will be by using sqsize for the tagset allocation later.
+		 */
 		dev_warn(ctrl->ctrl.device,
 			"queue_size %zu > ctrl sqsize %u, clamping down\n",
 			opts->queue_size, ctrl->ctrl.sqsize + 1);
-		opts->queue_size = ctrl->ctrl.sqsize + 1;
+	}
+
+	if (ctrl->ctrl.sqsize + 1 > ctrl->ctrl.maxcmd) {
+		/* warn if maxcmd is lower than sqsize+1 */
+		dev_warn(ctrl->ctrl.device,
+			"sqsize %u > ctrl maxcmd %u, clamping down\n",
+			ctrl->ctrl.sqsize + 1, ctrl->ctrl.maxcmd);
+		ctrl->ctrl.sqsize = ctrl->ctrl.maxcmd - 1;
 	}
 
 	if (opts->nr_io_queues) {
-- 
2.14.1
