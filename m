From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:10 -0700
Subject: [PATCH 5/8] nvme/pci: Remove last_sq_tail
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-5-keith.busch@intel.com>

We don't allocate enough tags to wrap the submission queue ring. Remove
the checks for this condition and shrink struct nvme_queue.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 62f29ab93f5a..06db19b45d2b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -191,7 +191,6 @@ struct nvme_queue {
 	u16 q_depth;
 	u16 cq_vector;
 	u16 sq_tail;
-	u16 last_sq_tail;
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
@@ -514,21 +513,11 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 /*
  * Write sq tail if we are asked to, or if the next command would wrap.
  */
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
 {
-	if (!write_sq) {
-		u16 next_tail = nvmeq->sq_tail + 1;
-
-		if (next_tail == nvmeq->q_depth)
-			next_tail = 0;
-		if (next_tail != nvmeq->last_sq_tail)
-			return;
-	}
-
 	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
-	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
 /**
@@ -544,7 +533,8 @@ static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-	nvme_write_sq_db(nvmeq, write_sq);
+	if (write_sq)
+		nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -553,8 +543,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 
 	spin_lock(&nvmeq->sq_lock);
-	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq, true);
+	nvme_write_sq_db(nvmeq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -1507,7 +1496,6 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 	struct nvme_dev *dev = nvmeq->dev;
 
 	nvmeq->sq_tail = 0;
-	nvmeq->last_sq_tail = 0;
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.14.4
