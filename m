From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:22:56 -0400
Subject: [PATCH 2/7] nvme/fc: Fix admin queue depth setup
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-3-git-send-email-keith.busch@intel.com>

The NVME_FC_AQ_BLKMQ_DEPTH is one less than what we actually want the
admin queue's depth to be since it subtracts the AEN entry.

We also need to subtract 1 from the blk-mq depth to always leave an
empty queue entry, and to not collide command id with the AEN request.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/fc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8355937..6328158 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2284,16 +2284,15 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 * Create the admin queue
 	 */
 
-	nvme_fc_init_queue(ctrl, 0, NVME_FC_AQ_BLKMQ_DEPTH);
+	nvme_fc_init_queue(ctrl, 0, NVME_AQ_DEPTH);
 
 	ret = __nvme_fc_create_hw_queue(ctrl, &ctrl->queues[0], 0,
-				NVME_FC_AQ_BLKMQ_DEPTH);
+				NVME_AQ_DEPTH);
 	if (ret)
 		goto out_free_queue;
 
 	ret = nvme_fc_connect_admin_queue(ctrl, &ctrl->queues[0],
-				NVME_FC_AQ_BLKMQ_DEPTH,
-				(NVME_FC_AQ_BLKMQ_DEPTH / 4));
+				NVME_AQ_DEPTH, (NVME_AQ_DEPTH / 4));
 	if (ret)
 		goto out_delete_hw_queue;
 
@@ -2693,7 +2692,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH;
+	ctrl->admin_tag_set.queue_depth = NVME_FC_AQ_BLKMQ_DEPTH - 1;
 	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_fc_fcp_op) +
-- 
2.5.5
