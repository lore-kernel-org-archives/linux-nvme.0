From: hch@lst.de (Christoph Hellwig)
Date: Wed, 21 Nov 2018 17:23:35 +0100
Subject: [PATCH 01/13] block: move queues types to the block layer
In-Reply-To: <20181121162347.17430-1-hch@lst.de>
References: <20181121162347.17430-1-hch@lst.de>
Message-ID: <20181121162347.17430-2-hch@lst.de>

Having another indirect all in the fast path doesn't really help
in our post-spectre world.  Also having too many queue type is just
going to create confusion, so I'd rather manage them centrally.

Note that the queue type naming and ordering changes a bit - the
first index now is the defauly queue for everything not explicitly
marked, the optional ones are read and poll queues.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.h          | 21 +++++++------
 drivers/nvme/host/pci.c | 68 +++++++++++++++--------------------------
 include/linux/blk-mq.h  | 15 ++++-----
 3 files changed, 43 insertions(+), 61 deletions(-)

diff --git a/block/blk-mq.h b/block/blk-mq.h
index 9ae8e9f8f8b1..3c04a5f07805 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -81,16 +81,14 @@ extern int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int);
 /*
  * blk_mq_map_queue_type() - map (hctx_type,cpu) to hardware queue
  * @q: request queue
- * @hctx_type: the hctx type index
+ * @type: the hctx type index
  * @cpu: CPU
  */
 static inline struct blk_mq_hw_ctx *blk_mq_map_queue_type(struct request_queue *q,
-							  unsigned int hctx_type,
+							  enum hctx_type type,
 							  unsigned int cpu)
 {
-	struct blk_mq_tag_set *set = q->tag_set;
-
-	return q->queue_hw_ctx[set->map[hctx_type].mq_map[cpu]];
+	return q->queue_hw_ctx[q->tag_set->map[type].mq_map[cpu]];
 }
 
 /*
@@ -103,12 +101,17 @@ static inline struct blk_mq_hw_ctx *blk_mq_map_queue(struct request_queue *q,
 						     unsigned int flags,
 						     unsigned int cpu)
 {
-	int hctx_type = 0;
+	enum hctx_type type = HCTX_TYPE_DEFAULT;
+
+	if (q->tag_set->nr_maps > HCTX_TYPE_POLL &&
+	    ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags)))
+		type = HCTX_TYPE_POLL;
 
-	if (q->mq_ops->rq_flags_to_type)
-		hctx_type = q->mq_ops->rq_flags_to_type(q, flags);
+	else if (q->tag_set->nr_maps > HCTX_TYPE_READ &&
+		 ((flags & REQ_OP_MASK) == REQ_OP_READ))
+		type = HCTX_TYPE_READ;
 
-	return blk_mq_map_queue_type(q, hctx_type, cpu);
+	return blk_mq_map_queue_type(q, type, cpu);
 }
 
 /*
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 73effe586e5f..308216201abe 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -95,13 +95,6 @@ struct nvme_queue;
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
-enum {
-	NVMEQ_TYPE_READ,
-	NVMEQ_TYPE_WRITE,
-	NVMEQ_TYPE_POLL,
-	NVMEQ_TYPE_NR,
-};
-
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
@@ -115,7 +108,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	unsigned online_queues;
 	unsigned max_qid;
-	unsigned io_queues[NVMEQ_TYPE_NR];
+	unsigned io_queues[HCTX_MAX_TYPES];
 	unsigned int num_vecs;
 	int q_depth;
 	u32 db_stride;
@@ -498,10 +491,10 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 
 		map->nr_queues = dev->io_queues[i];
 		if (!map->nr_queues) {
-			BUG_ON(i == NVMEQ_TYPE_READ);
+			BUG_ON(i == HCTX_TYPE_DEFAULT);
 
 			/* shared set, resuse read set parameters */
-			map->nr_queues = dev->io_queues[NVMEQ_TYPE_READ];
+			map->nr_queues = dev->io_queues[HCTX_TYPE_DEFAULT];
 			qoff = 0;
 			offset = queue_irq_offset(dev);
 		}
@@ -511,7 +504,7 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != NVMEQ_TYPE_POLL)
+		if (i != HCTX_TYPE_POLL)
 			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
 		else
 			blk_mq_map_queues(map);
@@ -932,16 +925,6 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
-static int nvme_rq_flags_to_type(struct request_queue *q, unsigned int flags)
-{
-	if ((flags & REQ_HIPRI) && test_bit(QUEUE_FLAG_POLL, &q->queue_flags))
-		return NVMEQ_TYPE_POLL;
-	if ((flags & REQ_OP_MASK) == REQ_OP_READ)
-		return NVMEQ_TYPE_READ;
-
-	return NVMEQ_TYPE_WRITE;
-}
-
 static void nvme_pci_complete_rq(struct request *req)
 {
 	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
@@ -1603,7 +1586,6 @@ static const struct blk_mq_ops nvme_mq_admin_ops = {
 
 #define NVME_SHARED_MQ_OPS					\
 	.queue_rq		= nvme_queue_rq,		\
-	.rq_flags_to_type	= nvme_rq_flags_to_type,	\
 	.complete		= nvme_pci_complete_rq,		\
 	.init_hctx		= nvme_init_hctx,		\
 	.init_request		= nvme_init_request,		\
@@ -1754,9 +1736,9 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	}
 
 	max = min(dev->max_qid, dev->ctrl.queue_count - 1);
-	if (max != 1 && dev->io_queues[NVMEQ_TYPE_POLL]) {
-		rw_queues = dev->io_queues[NVMEQ_TYPE_READ] +
-				dev->io_queues[NVMEQ_TYPE_WRITE];
+	if (max != 1 && dev->io_queues[HCTX_TYPE_POLL]) {
+		rw_queues = dev->io_queues[HCTX_TYPE_DEFAULT] +
+				dev->io_queues[HCTX_TYPE_READ];
 	} else {
 		rw_queues = max;
 	}
@@ -2045,9 +2027,9 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
 	 * Setup read/write queue split
 	 */
 	if (nr_io_queues == 1) {
-		dev->io_queues[NVMEQ_TYPE_READ] = 1;
-		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
-		dev->io_queues[NVMEQ_TYPE_POLL] = 0;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
+		dev->io_queues[HCTX_TYPE_READ] = 0;
+		dev->io_queues[HCTX_TYPE_POLL] = 0;
 		return;
 	}
 
@@ -2064,10 +2046,10 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
 			this_p_queues = nr_io_queues - 1;
 		}
 
-		dev->io_queues[NVMEQ_TYPE_POLL] = this_p_queues;
+		dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 		nr_io_queues -= this_p_queues;
 	} else
-		dev->io_queues[NVMEQ_TYPE_POLL] = 0;
+		dev->io_queues[HCTX_TYPE_POLL] = 0;
 
 	/*
 	 * If 'write_queues' is set, ensure it leaves room for at least
@@ -2081,11 +2063,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int nr_io_queues)
 	 * a queue set.
 	 */
 	if (!this_w_queues) {
-		dev->io_queues[NVMEQ_TYPE_WRITE] = 0;
-		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
+		dev->io_queues[HCTX_TYPE_READ] = 0;
 	} else {
-		dev->io_queues[NVMEQ_TYPE_WRITE] = this_w_queues;
-		dev->io_queues[NVMEQ_TYPE_READ] = nr_io_queues - this_w_queues;
+		dev->io_queues[HCTX_TYPE_DEFAULT] = this_w_queues;
+		dev->io_queues[HCTX_TYPE_READ] = nr_io_queues - this_w_queues;
 	}
 }
 
@@ -2107,8 +2089,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 	 */
 	do {
 		nvme_calc_io_queues(dev, nr_io_queues);
-		irq_sets[0] = dev->io_queues[NVMEQ_TYPE_READ];
-		irq_sets[1] = dev->io_queues[NVMEQ_TYPE_WRITE];
+		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
+		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
 		if (!irq_sets[1])
 			affd.nr_sets = 1;
 
@@ -2195,12 +2177,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	dev->num_vecs = result;
 	result = max(result - 1, 1);
-	dev->max_qid = result + dev->io_queues[NVMEQ_TYPE_POLL];
+	dev->max_qid = result + dev->io_queues[HCTX_TYPE_POLL];
 
-	dev_info(dev->ctrl.device, "%d/%d/%d read/write/poll queues\n",
-					dev->io_queues[NVMEQ_TYPE_READ],
-					dev->io_queues[NVMEQ_TYPE_WRITE],
-					dev->io_queues[NVMEQ_TYPE_POLL]);
+	dev_info(dev->ctrl.device, "%d/%d/%d default/read/poll queues\n",
+					dev->io_queues[HCTX_TYPE_DEFAULT],
+					dev->io_queues[HCTX_TYPE_READ],
+					dev->io_queues[HCTX_TYPE_POLL]);
 
 	/*
 	 * Should investigate if there's a performance win from allocating
@@ -2301,13 +2283,13 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	int ret;
 
 	if (!dev->ctrl.tagset) {
-		if (!dev->io_queues[NVMEQ_TYPE_POLL])
+		if (!dev->io_queues[HCTX_TYPE_POLL])
 			dev->tagset.ops = &nvme_mq_ops;
 		else
 			dev->tagset.ops = &nvme_mq_poll_noirq_ops;
 
 		dev->tagset.nr_hw_queues = dev->online_queues - 1;
-		dev->tagset.nr_maps = NVMEQ_TYPE_NR;
+		dev->tagset.nr_maps = HCTX_MAX_TYPES;
 		dev->tagset.timeout = NVME_IO_TIMEOUT;
 		dev->tagset.numa_node = dev_to_node(dev->dev);
 		dev->tagset.queue_depth =
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index b8de11e0603b..859fbb1c77a5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -81,8 +81,12 @@ struct blk_mq_queue_map {
 	unsigned int queue_offset;
 };
 
-enum {
-	HCTX_MAX_TYPES = 3,
+enum hctx_type {
+	HCTX_TYPE_DEFAULT,	/* all I/O not otherwise accounted for */
+	HCTX_TYPE_READ,		/* just for READ I/O */
+	HCTX_TYPE_POLL,		/* polled I/O of any kind */
+
+	HCTX_MAX_TYPES,
 };
 
 struct blk_mq_tag_set {
@@ -117,8 +121,6 @@ struct blk_mq_queue_data {
 
 typedef blk_status_t (queue_rq_fn)(struct blk_mq_hw_ctx *,
 		const struct blk_mq_queue_data *);
-/* takes rq->cmd_flags as input, returns a hardware type index */
-typedef int (rq_flags_to_type_fn)(struct request_queue *, unsigned int);
 typedef bool (get_budget_fn)(struct blk_mq_hw_ctx *);
 typedef void (put_budget_fn)(struct blk_mq_hw_ctx *);
 typedef enum blk_eh_timer_return (timeout_fn)(struct request *, bool);
@@ -144,11 +146,6 @@ struct blk_mq_ops {
 	 */
 	queue_rq_fn		*queue_rq;
 
-	/*
-	 * Return a queue map type for the given request/bio flags
-	 */
-	rq_flags_to_type_fn	*rq_flags_to_type;
-
 	/*
 	 * Reserve budget before queue request, once .queue_rq is
 	 * run, it is driver's responsibility to release the
-- 
2.19.1
