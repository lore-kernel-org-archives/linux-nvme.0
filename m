From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 15 Jun 2017 16:33:14 +0300
Subject: [PATCH v5 for-4.13 7/7] nvme-rdma: use intelligent affinity based
 queue mappings
In-Reply-To: <1497533594-11579-1-git-send-email-sagi@grimberg.me>
References: <1497533594-11579-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497533594-11579-8-git-send-email-sagi@grimberg.me>

Use the generic block layer affinity mapping helper. Also,
limit nr_hw_queues to the rdma device number of irq vectors
as we don't really need more.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2c714f8266bc..80a5be65e06e 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -19,6 +19,7 @@
 #include <linux/string.h>
 #include <linux/atomic.h>
 #include <linux/blk-mq.h>
+#include <linux/blk-mq-rdma.h>
 #include <linux/types.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
@@ -490,14 +491,10 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	ibdev = queue->device->dev;
 
 	/*
-	 * The admin queue is barely used once the controller is live, so don't
-	 * bother to spread it out.
+	 * Spread I/O queues completion vectors according their queue index.
+	 * Admin queues can always go on completion vector 0.
 	 */
-	if (idx == 0)
-		comp_vector = 0;
-	else
-		comp_vector = idx % ibdev->num_comp_vectors;
-
+	comp_vector = idx == 0 ? idx : idx - 1;
 
 	/* +1 for ib_stop_cq */
 	queue->ib_cq = ib_alloc_cq(ibdev, queue,
@@ -637,10 +634,20 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	struct ib_device *ibdev = ctrl->device->dev;
 	unsigned int nr_io_queues;
 	int i, ret;
 
 	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
+
+	/*
+	 * we map queues according to the device irq vectors for
+	 * optimal locality so we don't need more queues than
+	 * completion vectors.
+	 */
+	nr_io_queues = min_t(unsigned int, nr_io_queues,
+				ibdev->num_comp_vectors);
+
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -1527,6 +1534,13 @@ static void nvme_rdma_complete_rq(struct request *rq)
 	nvme_complete_rq(rq);
 }
 
+static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+
+	return blk_mq_rdma_map_queues(set, ctrl->device->dev, 0);
+}
+
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.queue_rq	= nvme_rdma_queue_rq,
 	.complete	= nvme_rdma_complete_rq,
@@ -1536,6 +1550,7 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_hctx	= nvme_rdma_init_hctx,
 	.poll		= nvme_rdma_poll,
 	.timeout	= nvme_rdma_timeout,
+	.map_queues	= nvme_rdma_map_queues,
 };
 
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
-- 
2.7.4
