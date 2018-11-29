From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 29 Nov 2018 07:47:13 -0800
Subject: [PATCH 3/7] nvme: implement mq_ops->commit_rqs() hook
In-Reply-To: <20181128133538.20329-4-axboe@kernel.dk>
References: <20181128133538.20329-1-axboe@kernel.dk>
 <20181128133538.20329-4-axboe@kernel.dk>
Message-ID: <20181129154713.GC7234@infradead.org>

> +static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
> +{
> +	if (++index == nvmeq->q_depth)
> +		return 0;
> +
> +	return index;
> +}

This is unused now.

Also what about this little cleanup on top?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 42472bd0cfed..527907aa6903 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -523,22 +523,26 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 	return 0;
 }
 
-static inline void nvme_write_sq_db(struct nvme_queue *nvmeq)
+/*
+ * Write sq tail if we are asked to, or if the next command would wrap.
+ */
+static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 {
+	if (!write_sq) {
+		u16 next_tail = nvmeq->sq_tail + 1;
+
+		if (next_tail == nvmeq->q_depth)
+			next_tail = 0;
+		if (next_tail != nvmeq->last_sq_tail)
+			return;
+	}
+
 	if (nvme_dbbuf_update_and_check_event(nvmeq->sq_tail,
 			nvmeq->dbbuf_sq_db, nvmeq->dbbuf_sq_ei))
 		writel(nvmeq->sq_tail, nvmeq->q_db);
 	nvmeq->last_sq_tail = nvmeq->sq_tail;
 }
 
-static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
-{
-	if (++index == nvmeq->q_depth)
-		return 0;
-
-	return index;
-}
-
 /**
  * nvme_submit_cmd() - Copy a command into a queue and ring the doorbell
  * @nvmeq: The queue to use
@@ -548,24 +552,11 @@ static inline int nvme_next_ring_index(struct nvme_queue *nvmeq, u16 index)
 static void nvme_submit_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 			    bool write_sq)
 {
-	u16 next_tail;
-
 	spin_lock(&nvmeq->sq_lock);
-
 	memcpy(&nvmeq->sq_cmds[nvmeq->sq_tail], cmd, sizeof(*cmd));
-
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
-
-	next_tail = nvmeq->sq_tail + 1;
-	if (next_tail == nvmeq->q_depth)
-		next_tail = 0;
-
-	/*
-	 * Write sq tail if we have to, OR if the next command would wrap
-	 */
-	if (write_sq || next_tail == nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq);
+	nvme_write_sq_db(nvmeq, write_sq);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
@@ -575,7 +566,7 @@ static void nvme_commit_rqs(struct blk_mq_hw_ctx *hctx)
 
 	spin_lock(&nvmeq->sq_lock);
 	if (nvmeq->sq_tail != nvmeq->last_sq_tail)
-		nvme_write_sq_db(nvmeq);
+		nvme_write_sq_db(nvmeq, true);
 	spin_unlock(&nvmeq->sq_lock);
 }
 
