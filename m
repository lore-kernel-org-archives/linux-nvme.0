From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 28 Nov 2018 06:35:34 -0700
Subject: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181128133538.20329-1-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
Message-ID: <20181128133538.20329-4-axboe@kernel.dk>

Split the command submission and the SQ doorbell ring, and add the
doorbell ring as our ->commit_rqs() hook. This allows a list of
requests to be issued, with nvme only writing the SQ update when
it's necessary. This is more efficient if we have lists of requests
to issue, particularly on virtualized hardware, where writing the
SQ doorbell is more expensive than on real hardware. For those cases,
performance increases of 2-3x have been observed.

The use case for this is plugged IO, where blk-mq flushes a batch of
requests at the time.

Signed-off-by: Jens Axboe <axboe at kernel.dk>
---
 drivers/nvme/host/pci.c | 52 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73effe586e5f..42472bd0cfed 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -203,6 +203,7 @@ struct nvme_queue {
 	u16 q_depth;
 	s16 cq_vector;
 	u16 sq_tail;
+	u16 last_sq_tail;
 	u16 cq_head;
 	u16 last_cq_head;
 	u16 qid;
@@ -522,22 +523,59 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
+{
+	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
+			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
+		writel(nvmeq->sq_tail, nvmeq->q_db);
+	nvmeq->last_sq_tail = nvmeq->sq_tail;
+}
+
+static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
+{
+	if (++index == nvmeq->q_depth)
+		return 0;
+
+	return index;
+}
+
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
  * @cmd: The command to send
+ * @write_sq: whether to write to the SQ doorbell
  */
-static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd)
+static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
+			    bool write_sq)
 {
+	u16 next_tail;
+
 	spin_lock(&nvmeq->sq_lock);
 
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
 
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
-			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
-		writel(nvmeq->sq_tail, nvmeq->q_db);
+
+	next_tail = nvmeq->sq_tail + 1;
+	if (next_tail == nvmeq->q_depth)
+		next_tail = 0;
+
+	/*
+	 * Write sq tail if we have to, OR if the next command would wrap
+	 */
+	if (write_sq || next_tail == nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq);
+	spin_unlock(&nvmeq->sq_lock);
+}
+
+static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+
+	spin_lock(&nvmeq->sq_lock);
+	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
+		nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -923,7 +961,7 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 	blk_mq_start_request(req);
-	nvme_submit_cmd(nvmeq, &cmnd);
+	nvme_submit_cmd(nvmeq, &cmnd, bd->last);
 	return BLK_STS_OK;
 out_cleanup_iod:
 	nvme_free_iod(dev, req);
@@ -1108,7 +1146,7 @@ static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = nvme_admin_async_event;
 	c.common.command_id = NVME_AQ_BLK_MQ_DEPTH;
-	nvme_submit_cmd(nvmeq, &c);
+	nvme_submit_cmd(nvmeq, &c, true);
 }
 
 static int adapter_delete_queue(struct nvme_dev *dev, u8 opcode, u16 id)
@@ -1531,6 +1569,7 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 
 	spin_lock_irq(&nvmeq->cq_lock);
 	nvmeq->sq_tail = 0;
+	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
@@ -1603,6 +1642,7 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 #define NVME_SHARED_MQ_OPS					\
 	.queue_rq		= nvme_queue_rq,		\
+	.commit_rqs		= nvme_commit_rqs,		\
 	.rq_flags_to_type	= nvme_rq_flags_to_type,	\
 	.complete		= nvme_pci_complete_rq,		\
 	.init_hctx		= nvme_init_hctx,		\
-- 
2.17.1
