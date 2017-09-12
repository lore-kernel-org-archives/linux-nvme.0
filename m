From: anish.jhaveri@paviliondata.com (Anish M Jhaveri)
Date: Mon, 11 Sep 2017 21:33:02 -0700
Subject: [PATCH 10/10] Reserved tag for active ns command
Message-ID: <20170912043302.uikxktbfqjfzwfvn@haynes>

Using reserved tag for setting standby namespace to active using nvme command.

Signed-off-by: Anish M Jhaveri <anish.jhaveri at paviliondata.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index cb6a5f8..d094793 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1550,7 +1550,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
 	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
+	ctrl->admin_tag_set.reserved_tags = 3; /* connect + keep-alive */
 	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
 	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
 		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-- 
2.9.3
