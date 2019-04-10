From: yuyufen@huawei.com (Yufen Yu)
Date: Wed, 10 Apr 2019 16:00:31 +0800
Subject: [PATCH RFC 2/6] nvme-pci: use NVME_ADMIN_QID for admin queue
In-Reply-To: <20190410080035.82529-1-yuyufen@huawei.com>
References: <20190410080035.82529-1-yuyufen@huawei.com>
Message-ID: <20190410080035.82529-3-yuyufen@huawei.com>

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 drivers/nvme/host/pci.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a84a31525097..ecbe7b9cba19 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -424,7 +424,7 @@ static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
 	struct nvme_dev *dev = data;
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->queues[NVME_ADMIN_QID];
 
 	WARN_ON(hctx_idx != 0);
 	WARN_ON(dev->admin_tagset.tags[0] != hctx->tags);
@@ -1122,7 +1122,7 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx)
 static void nvme_pci_submit_async_event(struct nvme_ctrl *ctrl)
 {
 	struct nvme_dev *dev = to_nvme_dev(ctrl);
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->queues[NVME_ADMIN_QID];
 	struct nvme_command c;
 
 	memset(&c, 0, sizeof(c));
@@ -1421,13 +1421,13 @@ static void nvme_suspend_io_queues(struct nvme_dev *dev)
 {
 	int i;
 
-	for (i = dev->ctrl.queue_count - 1; i > 0; i--)
+	for (i = dev->ctrl.queue_count - 1; i > NVME_ADMIN_QID; i--)
 		nvme_suspend_queue(&dev->queues[i]);
 }
 
 static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 {
-	struct nvme_queue *nvmeq = &dev->queues[0];
+	struct nvme_queue *nvmeq = &dev->queues[NVME_ADMIN_QID];
 
 	if (shutdown)
 		nvme_shutdown_ctrl(&dev->ctrl);
@@ -1710,11 +1710,11 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
+	result = nvme_alloc_queue(dev, NVME_ADMIN_QID, NVME_AQ_DEPTH);
 	if (result)
 		return result;
 
-	nvmeq = &dev->queues[0];
+	nvmeq = &dev->queues[NVME_ADMIN_QID];
 	aqa = nvmeq->q_depth - 1;
 	aqa |= aqa << 16;
 
@@ -1727,7 +1727,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 		return result;
 
 	nvmeq->cq_vector = 0;
-	nvme_init_queue(nvmeq, 0);
+	nvme_init_queue(nvmeq, NVME_ADMIN_QID);
 	result = queue_request_irq(nvmeq);
 	if (result) {
 		nvmeq->cq_vector = -1;
@@ -2112,7 +2112,7 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
-	struct nvme_queue *adminq = &dev->queues[0];
+	struct nvme_queue *adminq = &dev->queues[NVME_ADMIN_QID];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
@@ -2428,7 +2428,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	nvme_suspend_io_queues(dev);
-	nvme_suspend_queue(&dev->queues[0]);
+	nvme_suspend_queue(&dev->queues[NVME_ADMIN_QID]);
 	nvme_pci_disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-- 
2.16.2.dirty
