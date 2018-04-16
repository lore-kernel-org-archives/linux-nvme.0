From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon, 16 Apr 2018 16:25:52 +0300
Subject: [PATCH 1/1] nvmet-rdma: Add error flow for post_recv failures
Message-ID: <1523885152-20800-1-git-send-email-maxg@mellanox.com>

Posting receive buffer operation can fail, thus we should
make sure there is no memory leakage in that flow.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/rdma.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 52e0c5d..f0c07d0 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -487,7 +487,11 @@ static void nvmet_rdma_queue_response(struct nvmet_req *req)
 	else
 		first_wr = &rsp->send_wr;
 
-	nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd);
+	if (unlikely(nvmet_rdma_post_recv(rsp->queue->dev, rsp->cmd))) {
+		pr_err("post_recv cmd failed\n");
+		nvmet_rdma_release_rsp(rsp);
+		return;
+	}
 
 	ib_dma_sync_single_for_device(rsp->queue->dev->device,
 		rsp->send_sge.addr, rsp->send_sge.length,
@@ -765,11 +769,18 @@ static int nvmet_rdma_init_srq(struct nvmet_rdma_device *ndev)
 	ndev->srq = srq;
 	ndev->srq_size = srq_size;
 
-	for (i = 0; i < srq_size; i++)
-		nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+	for (i = 0; i < srq_size; i++) {
+		ret = nvmet_rdma_post_recv(ndev, &ndev->srq_cmds[i]);
+		if (ret) {
+			pr_err("initial post_recv failed on SRQ 0x%p\n", srq);
+			goto out_free_cmds;
+		}
+	}
 
 	return 0;
 
+out_free_cmds:
+	nvmet_rdma_free_cmds(ndev, ndev->srq_cmds, ndev->srq_size, false);
 out_destroy_srq:
 	ib_destroy_srq(srq);
 	return ret;
@@ -899,13 +910,19 @@ static int nvmet_rdma_create_queue_ib(struct nvmet_rdma_queue *queue)
 	if (!ndev->srq) {
 		for (i = 0; i < queue->recv_queue_size; i++) {
 			queue->cmds[i].queue = queue;
-			nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
+			ret = nvmet_rdma_post_recv(ndev, &queue->cmds[i]);
+			if (ret) {
+				pr_err("initial post_recv failed\n");
+				goto err_destroy_qp;
+			}
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
