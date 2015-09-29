From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 29 Sep 2015 11:20:56 +0800
Subject: [PATCH 2/3] block: nvme: use map_changed to set irq affinity hint
In-Reply-To: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
References: <1443496857-26887-1-git-send-email-tom.leiming@gmail.com>
Message-ID: <1443496857-26887-3-git-send-email-tom.leiming@gmail.com>

This patch uses the .map_changed callback to set irq affinity
hint, then the irq affinity can be updated when CPU topo
is changed.

Signed-off-by: Ming Lei <tom.leiming at gmail.com>
---
 drivers/block/nvme-core.c | 53 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 19 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..cac16a6f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -105,6 +105,8 @@ struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
 	char irqname[24];	/* nvme4294967295-65535\0 */
+	unsigned long mapped:1;
+	unsigned long irq_affinity_set:1;
 	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
 	struct nvme_command __iomem *sq_cmds_io;
@@ -232,6 +234,37 @@ static int nvme_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 	return 0;
 }
 
+/*
+ * Since namespaces shared tagset and the 'hctx' with same
+ * index shared one same nvme queue & tag, also the mapping
+ * between sw queue and hw queue is global and only depends
+ * on CPUs topo, this callback only sets irq affinity once
+ * by using the cpumask from one of hctx.
+ * */
+static void nvme_map_changed(struct blk_mq_hw_ctx *hctx,
+		unsigned int hctx_idx, bool mapped)
+{
+	struct nvme_queue *nvmeq = hctx->driver_data;
+	struct nvme_dev *dev = nvmeq->dev;
+	unsigned int irq;
+
+	if (nvmeq->mapped != mapped)
+		nvmeq->irq_affinity_set = 0;
+
+	nvmeq->mapped = mapped;
+
+	if (nvmeq->irq_affinity_set)
+		return;
+
+	irq = dev->entry[nvmeq->cq_vector].vector;
+	if (mapped)
+		irq_set_affinity_hint(irq, hctx->cpumask);
+	else
+		irq_set_affinity_hint(irq, NULL);
+
+	nvmeq->irq_affinity_set = 1;
+}
+
 static int nvme_init_request(void *data, struct request *req,
 				unsigned int hctx_idx, unsigned int rq_idx,
 				unsigned int numa_node)
@@ -1664,6 +1697,7 @@ static struct blk_mq_ops nvme_mq_ops = {
 	.queue_rq	= nvme_queue_rq,
 	.map_queue	= blk_mq_map_queue,
 	.init_hctx	= nvme_init_hctx,
+	.map_changed    = nvme_map_changed,
 	.init_request	= nvme_init_request,
 	.timeout	= nvme_timeout,
 };
@@ -2953,22 +2987,6 @@ static const struct file_operations nvme_dev_fops = {
 	.compat_ioctl	= nvme_dev_ioctl,
 };
 
-static void nvme_set_irq_hints(struct nvme_dev *dev)
-{
-	struct nvme_queue *nvmeq;
-	int i;
-
-	for (i = 0; i < dev->online_queues; i++) {
-		nvmeq = dev->queues[i];
-
-		if (!nvmeq->tags || !(*nvmeq->tags))
-			continue;
-
-		irq_set_affinity_hint(dev->entry[nvmeq->cq_vector].vector,
-					blk_mq_tags_cpumask(*nvmeq->tags));
-	}
-}
-
 static int nvme_dev_start(struct nvme_dev *dev)
 {
 	int result;
@@ -3010,8 +3028,6 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	if (result)
 		goto free_tags;
 
-	nvme_set_irq_hints(dev);
-
 	dev->event_limit = 1;
 	return result;
 
@@ -3062,7 +3078,6 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	} else {
 		nvme_unfreeze_queues(dev);
 		nvme_dev_add(dev);
-		nvme_set_irq_hints(dev);
 	}
 	return 0;
 }
-- 
1.9.1
