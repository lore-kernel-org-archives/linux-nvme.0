From: parav@mellanox.com (Parav Pandit)
Date: Wed, 18 Jan 2017 18:22:26 -0600
Subject: [PATCHv3] nvmet-rdma: Fix missing dma sync to nvme data structures
Message-ID: <1484785346-2991-1-git-send-email-parav@mellanox.com>

This patch performs dma sync operations on nvme_command
and nvme_completion.

nvme_command is synced
(a) on receiving of the recv queue completion for cpu access.
(b) before posting recv wqe back to rdma adapter for device access.

nvme_completion is synced
(a) on receiving of the recv queue completion of associated
nvme_command for cpu access.
(b) before posting send wqe to rdma adapter for device access.

This patch is generated for git://git.infradead.org/nvme-fabrics.git
Branch: nvmf-4.10

Signed-off-by: Parav Pandit <parav at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6c1c368..0599217 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -438,6 +438,10 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 {
 	struct ib_recv_wr *bad_wr;
 
+	ib_dma_sync_single_for_device(ndev->device,
+		cmd->sge[0].addr, cmd->sge[0].length,
+		DMA_FROM_DEVICE);
+
 	if (ndev->srq)
 		return ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
 	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
@@ -538,6 +542,11 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 		first_wr = &rsp->send_wr;
 
 	nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
+
+	ib_dma_sync_single_for_device(rsp->queue->dev->device,
+			rsp->send_sge.addr, rsp->send_sge.length,
+			DMA_TO_DEVICE);
+
 	if (ib_post_send(cm_id->qp, first_wr, &bad_wr)) {
 		pr_err("sending cmd response failed\n");
 		nvmet_rdma_release_rsp(rsp);
@@ -698,6 +707,13 @@ static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 	cmd->n_rdma = 0;
 	cmd->req.port = queue->port;
 
+	ib_dma_sync_single_for_cpu(queue->dev->device,
+		cmd->cmd->sge[0].addr, cmd->cmd->sge[0].length,
+		DMA_FROM_DEVICE);
+	ib_dma_sync_single_for_cpu(queue->dev->device,
+			cmd->send_sge.addr, cmd->send_sge.length,
+			DMA_TO_DEVICE);
+
 	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_rdma_ops))
 		return;
-- 
1.8.3.1
