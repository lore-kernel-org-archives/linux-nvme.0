From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:38 +0200
Subject: [PATCH 6/9] nvme: abort requests on the reqeueue list when shutting
 down a controller
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-7-git-send-email-hch@lst.de>

Otherwise we might never complete them as nvme_clear_queue won't find these
requests.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fb44100..73d015d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2116,11 +2116,15 @@ static void nvme_unfreeze_queues(struct nvme_dev *dev)
 
 static void nvme_dev_shutdown(struct nvme_dev *dev)
 {
+	struct nvme_ns *ns;
 	int i;
 	u32 csts = -1;
 
 	nvme_dev_list_remove(dev);
 
+	list_for_each_entry(ns, &dev->ctrl.namespaces, list)
+		blk_mq_abort_requeue_list(ns->queue);
+
 	if (dev->bar) {
 		nvme_freeze_queues(dev);
 		csts = readl(dev->bar + NVME_REG_CSTS);
-- 
1.9.1
