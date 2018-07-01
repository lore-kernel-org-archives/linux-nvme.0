From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun,  1 Jul 2018 12:20:24 +0300
Subject: [PATCH v2 1/1] nvmet-rdma: Add an error flow for post_recv failures
Message-ID: <1530436824-18229-1-git-send-email-maxg@mellanox.com>

Posting receive buffer operation can fail, thus we should make
sure to have an error flow during initialization phase. While
we're here, add a debug print in case of a failure.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---

changes from v1:
 - updated change log to be more informative
 - updated debug print

---
 drivers/nvme/target/rdma.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d..6835186 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -383,14 +383,21 @@ static int nvmet_rdma_post_recv(struct nvmet_rdma_device *ndev,
 		struct nvmet_rdma_cmd *cmd)
 {
 	struct ib_recv_wr *bad_wr;
+	int ret;
 
 	ib_dma_sync_single_for_device(ndev->device,
 		cmd->sge[0].addr, cmd->sge[0].length,
 		DMA_FROM_DEVICE);
 
 	if (ndev->srq)
-		return ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
-	return ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
+		ret = ib_post_srq_recv(ndev->srq, &cmd->wr, &bad_wr);
+	else
+		ret = ib_post_recv(cmd->queue->cm_id->qp, &cmd->wr, &bad_wr);
+
+	if (unlikely(ret))
+		pr_err("post_recv cmd failed\n");
+
+	return ret;
 }
 
 static void nvmet_rdma_process_wr_wait_list(struct nvmet_rdma_queue *queue)
@@ -765,11 +772,16 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	ndev->srq = srq;
 	ndev->srq_size = srq_size;
 
-	for (i = 0; i < srq_size; i++)
-		nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+	for (i = 0; i < srq_size; i++) {
+		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+		if (ret)
+			goto out_free_cmds;
+	}
 
 	return 0;
 
+out_free_cmds:
+	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
 out_destroy_srq:
 	ib_destroy_srq(srq);
 	return ret;
@@ -899,13 +911,17 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	if (!ndev->srq) {
 		for (i = 0; i < queue->recv_queue_size; i++) {
 			queue->cmds[i].queue = queue;
-			nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
+			ret = nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
+			if (ret)
+				goto err_destroy_qp;
 		}
 	}
 
 out:
 	return ret;
 
+err_destroy_qp:
+	rdma_destroy_qp(queue->cm_id);
 err_destroy_cq:
 	ib_free_cq(queue->cq);
 	goto out;
-- 
1.8.3.1
