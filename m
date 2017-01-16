From: parav@mellanox.com (Parav Pandit)
Date: Mon, 16 Jan 2017 14:19:05 -0600
Subject: [PATCHv1] nvmet-rdma: Fix missing dma sync to nvme data structures
Message-ID: <1484597945-31143-1-git-send-email-parav@mellanox.com>

This patch performs dma sync operations on nvme_command,
inline page(s) and nvme_completion.

nvme_command and write cmd inline data is synced
(a) on receiving of the recv queue completion for cpu access.
(b) before posting recv wqe back to rdma adapter for device access.

nvme_completion is synced
(a) on receiving send completion for nvme_completion for cpu access.
(b) before posting send wqe to rdma adapter for device access.

This patch is generated for git://git.infradead.org/nvme-fabrics.git
Branch: nvmf-4.10

Signed-off-by: Parav Pandit <parav at mellanox.com>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 6c1c368..fe7e257 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -437,6 +437,14 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_cmd *cmd)
 {
 	struct ib_recv_wr *bad_wr;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (cmd->sge[i].length)
+			ib_dma_sync_single_for_device(ndev->device,
+				cmd->sge[0].addr, cmd->sge[0].length,
+				DMA_FROM_DEVICE);
+	}
 
 	if (ndev->srq)
 		return ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
@@ -507,6 +515,10 @@ static void nvmet_rdma_send_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct nvmet_rdma_rsp *rsp =
 		container_of(wc->wr_cqe, struct nvmet_rdma_rsp, send_cqe);
 
+	ib_dma_sync_single_for_cpu(rsp->queue->dev->device,
+			rsp->send_sge.addr, rsp->send_sge.length,
+			DMA_TO_DEVICE);
+
 	nvmet_rdma_release_rsp(rsp);
 
 	if (unlikely(wc->status != IB_WC_SUCCESS &&
@@ -538,6 +550,11 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
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
@@ -692,12 +709,20 @@ static bool nvmet_rdma_execute_command(struct nvmet_rdma_rsp *rsp)
 static void nvmet_rdma_handle_command(struct nvmet_rdma_queue *queue,
 		struct nvmet_rdma_rsp *cmd)
 {
+	int i;
 	u16 status;
 
 	cmd->queue = queue;
 	cmd->n_rdma = 0;
 	cmd->req.port = queue->port;
 
+	for (i = 0; i < 2; i++) {
+		if (cmd->cmd->sge[i].length)
+			ib_dma_sync_single_for_cpu(queue->dev->device,
+				cmd->cmd->sge[i].addr, cmd->cmd->sge[i].length,
+				DMA_FROM_DEVICE);
+	}
+
 	if (!nvmet_req_init(&cmd->req, &queue->nvme_cq,
 			&queue->nvme_sq, &nvmet_rdma_ops))
 		return;
-- 
1.8.3.1
