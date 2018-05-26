From: hch@lst.de (Christoph Hellwig)
Date: Sat, 26 May 2018 13:45:55 +0200
Subject: [PATCH] nvme-pci: simplify __nvme_submit_cmd
Message-ID: <20180526114555.8881-1-hch@lst.de>

With recent CQ handling improvements we can now move the locking into
__nvme_submit_cmd.  Also remove the local tail variable to make the code
more obvious, remove the __ prefix in the name, and fix the comments
describing the function.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 79b48052ea11..3fe41b2594a1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -421,28 +421,25 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 }
 
 /**
- * __nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
+ * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
  * @cmd: The command to send
- *
- * Safe to use from interrupt context
  */
-static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
-						struct nvme_command *cmd)
+static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
 {
-	u16 tail = nvmeq->sq_tail;
-
+	spin_lock(&nvmeq->sq_lock);
 	if (nvmeq->sq_cmds_io)
-		memcpy_toio(&nvmeq->sq_cmds_io[tail], cmd, sizeof(*cmd));
+		memcpy_toio(&nvmeq->sq_cmds_io[nvmeq->sq_tail], cmd,
+				sizeof(*cmd));
 	else
-		memcpy(&nvmeq->sq_cmds[tail], cmd, sizeof(*cmd));
+		memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
 
-	if (++tail == nvmeq->q_depth)
-		tail = 0;
-	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
-					      nvmeq->dbbuf_sq_ei))
-		writel(tail, nvmeq->q_db);
-	nvmeq->sq_tail = tail;
+	if (++nvmeq->sq_tail == nvmeq->q_depth)
+		nvmeq->sq_tail = 0;
+	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
+			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
+		writel(nvmeq->sq_tail, nvmeq->q_db);
+	spin_unlock(&nvmeq->sq_lock);
 }
 
 static void **nvme_pci_iod_list(struct request *req)
@@ -895,10 +892,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-
-	spin_lock(&nvmeq->sq_lock);
-	__nvme_submit_cmd(nvmeq, &cmnd);
-	spin_unlock(&nvmeq->sq_lock);
+	nvme_submit_cmd(nvmeq, &cmnd);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1058,10 +1052,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-
-	spin_lock(&nvmeq->sq_lock);
-	__nvme_submit_cmd(nvmeq, &c);
-	spin_unlock(&nvmeq->sq_lock);
+	nvme_submit_cmd(nvmeq, &c);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
-- 
2.17.0
