From: keith.busch@intel.com (Keith Busch)
Date: Wed,  1 May 2013 13:07:49 -0600
Subject: [PATCH] NVMe: Remove dead code in nvme_dev_add
In-Reply-To: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
References: <1367435271-15784-1-git-send-email-keith.busch@intel.com>
Message-ID: <1367435271-15784-3-git-send-email-keith.busch@intel.com>

There is no situation that could occur where we could error out of this
function and require cleaning up allocated namespaces.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    9 +--------
 1 files changed, 1 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e7d68e3..82a5f81 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1511,7 +1511,7 @@ static void nvme_free_queues(struct nvme_dev *dev)
 static int nvme_dev_add(struct nvme_dev *dev)
 {
 	int res, nn, i;
-	struct nvme_ns *ns, *next;
+	struct nvme_ns *ns;
 	struct nvme_id_ctrl *ctrl;
 	struct nvme_id_ns *id_ns;
 	void *mem;
@@ -1564,15 +1564,8 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	list_for_each_entry(ns, &dev->namespaces, list)
 		add_disk(ns->disk);
 	res = 0;
-	goto out;
 
  out_free:
-	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		list_del(&ns->list);
-		nvme_ns_free(ns);
-	}
-
- out:
 	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
 	return res;
 }
-- 
1.7.0.4
