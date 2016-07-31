From: roland@kernel.org (Roland Dreier)
Date: Sun, 31 Jul 2016 00:27:39 -0700
Subject: [PATCH 1/2] nvme-rdma: Don't leak uninitialized memory in connect
 request private data
Message-ID: <1469950060-18098-1-git-send-email-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

Zero out the full nvme_rdma_cm_req structure before sending it.
Otherwise we end up leaking kernel memory in the reserved field, which
might break forward compatibility in the future.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/rdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 3e3ce2b0424e..b96b88369871 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1269,7 +1269,7 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 {
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 	struct rdma_conn_param param = { };
-	struct nvme_rdma_cm_req priv;
+	struct nvme_rdma_cm_req priv = { };
 	int ret;
 
 	param.qp_num = queue->qp->qp_num;
-- 
2.7.4
