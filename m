From: keith.busch@intel.com (Keith Busch)
Date: Fri, 23 Mar 2018 16:19:22 -0600
Subject: [PATCH 2/3] nvme-pci: Remove unused queue parameter
In-Reply-To: <20180323221923.24545-1-keith.busch@intel.com>
References: <20180323221923.24545-1-keith.busch@intel.com>
Message-ID: <20180323221923.24545-2-keith.busch@intel.com>

All nvme queue memory is allocated up front. We don't take the node
into consideration when creating queues anymore, so removing the unused
parameter.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index cef5ce851a92..632166f7d8f2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1379,8 +1379,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	return 0;
 }
 
-static int nvme_alloc_queue(struct nvme_dev *dev, int qid,
-		int depth, int node)
+static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
@@ -1595,8 +1594,7 @@ static int nvme_pci_configure_admin_queue(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH,
-			dev_to_node(dev->dev));
+	result = nvme_alloc_queue(dev, 0, NVME_AQ_DEPTH);
 	if (result)
 		return result;
 
@@ -1629,9 +1627,7 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	int ret = 0;
 
 	for (i = dev->ctrl.queue_count; i <= dev->max_qid; i++) {
-		/* vector == qid - 1, match nvme_create_queue */
-		if (nvme_alloc_queue(dev, i, dev->q_depth,
-		     pci_irq_get_node(to_pci_dev(dev->dev), i - 1))) {
+		if (nvme_alloc_queue(dev, i, dev->q_depth)) {
 			ret = -ENOMEM;
 			break;
 		}
-- 
2.14.3
