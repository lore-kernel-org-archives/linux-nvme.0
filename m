From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon,  1 Aug 2016 11:36:39 +0300
Subject: [PATCH] nvmet-rdma: Don't use the inline buffer in order to avoid
 allocation for small reads
Message-ID: <1470040599-7294-1-git-send-email-sagi@grimberg.me>

Under extreme conditions this might cause data corruptions. By doing that
we we repost the buffer and then post this buffer for the device to send.
If we happen to use shared receive queues the device might write to the
buffer before it sends it (there is no ordering between send and recv
queues). Without SRQs we probably won't get that if the host doesn't
mis-behave and send more than we allowed it, but relying on that is not
really a good idea.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/rdma.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index e06d504bdf0c..4e83d92d6bdd 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -615,15 +615,10 @@ static u16 nvmet_rdma_map_sgl_keyed(struct nvmet_rdma_rsp *rsp,
 	if (!len)
 		return 0;
 
-	/* use the already allocated data buffer if possible */
-	if (len <= NVMET_RDMA_INLINE_DATA_SIZE && rsp->queue->host_qid) {
-		nvmet_rdma_use_inline_sg(rsp, len, 0);
-	} else {
-		status = nvmet_rdma_alloc_sgl(&rsp->req.sg, &rsp->req.sg_cnt,
-				len);
-		if (status)
-			return status;
-	}
+	status = nvmet_rdma_alloc_sgl(&rsp->req.sg, &rsp->req.sg_cnt,
+			len);
+	if (status)
+		return status;
 
 	ret = rdma_rw_ctx_init(&rsp->rw, cm_id->qp, cm_id->port_num,
 			rsp->req.sg, rsp->req.sg_cnt, 0, addr, key,
-- 
1.9.1
