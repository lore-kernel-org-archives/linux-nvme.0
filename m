From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 22 Jun 2016 15:06:00 +0300
Subject: [PATCH 1/2] nvme-rdma: Don't use tl_retry_count
In-Reply-To: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
References: <1466597161-5242-1-git-send-email-sagi@grimberg.me>
Message-ID: <1466597161-5242-2-git-send-email-sagi@grimberg.me>

Always use the maximum qp retry count as the
error recovery timeout is dictated from the nvme
keep-alive.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index e1205c0d36e4..b939f89ad936 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -117,7 +117,6 @@ struct nvme_rdma_ctrl {
 	u32			queue_count;
 
 	/* other member variables */
-	unsigned short		tl_retry_count;
 	struct blk_mq_tag_set	tag_set;
 	struct work_struct	delete_work;
 	struct work_struct	reset_work;
@@ -1268,8 +1267,8 @@ static int nvme_rdma_route_resolved(struct nvme_rdma_queue *queue)
 	param.flow_control = 1;
 
 	param.responder_resources = queue->device->dev->attrs.max_qp_rd_atom;
-	/* rdma_cm will clamp down to max QP retry count (7) */
-	param.retry_count = ctrl->tl_retry_count;
+	/* maximum retry count */
+	param.retry_count = 7;
 	param.rnr_retry_count = 7;
 	param.private_data = &priv;
 	param.private_data_len = sizeof(priv);
@@ -1898,7 +1897,6 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
 	ctrl->ctrl.sqsize = opts->queue_size;
-	ctrl->tl_retry_count = opts->tl_retry_count;
 	ctrl->ctrl.kato = opts->kato;
 
 	ret = -ENOMEM;
@@ -1975,8 +1973,7 @@ out_free_ctrl:
 static struct nvmf_transport_ops nvme_rdma_transport = {
 	.name		= "rdma",
 	.required_opts	= NVMF_OPT_TRADDR,
-	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_TL_RETRY_COUNT |
-			  NVMF_OPT_RECONNECT_DELAY,
+	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
1.9.1
