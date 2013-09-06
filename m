From: huhaiyan@huawei.com (Haiyan Hu)
Date: Fri, 6 Sep 2013 15:15:07 +0800
Subject: [PATCH] NVMe: Avoid shift operation when writel cq head doorbell
 in nvme_process_cq()
In-Reply-To: <522973F8.5040905@huawei.com>
References: <522973F8.5040905@huawei.com>
Message-ID: <522980FB.7060806@huawei.com>

Changes the type of dev->db_stride to unsigned and changes the value
stored there to be 1 << the current value. Then there is less
calculation to be done at completion time.

Signed-off-by: Haiyan Hu <huhaiyan at huawei.com>
---
 drivers/block/nvme-core.c |    8 ++++----
 include/linux/nvme.h      |    2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7de80bb..481311e 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -772,7 +772,7 @@ static int nvme_process_cq(struct nvme_queue *nvmeq)
 	if (head == nvmeq->cq_head && phase == nvmeq->cq_phase)
 		return 0;

-	writel(head, nvmeq->q_db + (1 << nvmeq->dev->db_stride));
+	writel(head, nvmeq->q_db + nvmeq->dev->db_stride);
 	nvmeq->cq_head = head;
 	nvmeq->cq_phase = phase;

@@ -1084,7 +1084,7 @@ static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 	init_waitqueue_head(&nvmeq->sq_full);
 	init_waitqueue_entry(&nvmeq->sq_cong_wait, nvme_thread);
 	bio_list_init(&nvmeq->sq_cong);
-	nvmeq->q_db = &dev->dbs[qid << (dev->db_stride + 1)];
+	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
 	nvmeq->q_depth = depth;
 	nvmeq->cq_vector = vector;

@@ -1195,7 +1195,7 @@ static int nvme_configure_admin_queue(struct nvme_dev *dev)
 	struct nvme_queue *nvmeq;

 	dev->dbs = ((void __iomem *)dev->bar) + 4096;
-	dev->db_stride = NVME_CAP_STRIDE(cap);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(cap);

 	result = nvme_disable_ctrl(dev, cap);
 	if (result < 0)
@@ -1685,7 +1685,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	/* Deregister the admin queue's interrupt */
 	free_irq(dev->entry[0].vector, dev->queues[0]);

-	db_bar_size = 4096 + ((nr_io_queues + 1) << (dev->db_stride + 3));
+	db_bar_size = 4096 + ((nr_io_queues + 1) * 8 * dev->db_stride);
 	if (db_bar_size > 8192) {
 		iounmap(dev->bar);
 		dev->bar = ioremap(pci_resource_start(pdev, 0), db_bar_size);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 3403c8f..87ba032 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -78,7 +78,7 @@ struct nvme_dev {
 	struct dma_pool *prp_small_pool;
 	int instance;
 	int queue_count;
-	int db_stride;
+	u32 db_stride;
 	u32 ctrl_config;
 	struct msix_entry *entry;
 	struct nvme_bar __iomem *bar;
-- 
1.7.6
