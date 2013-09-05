From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:09 -0600
Subject: [PATCH 3/9] NVMe: Fail device if unresponsive during init
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-4-git-send-email-keith.busch@intel.com>

This handles identifying namespace errors differently depending on
the error. If the controller is unresponsive during this point of
initialization, the namespaces are freed and the pci probe is failed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Yes, part of this undoes a patch I submitted removing 'dead code',
but that code wasn't reachable before! :)

 drivers/block/nvme-core.c |   18 +++++++++++++++---
 1 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 8b22068..db15c3d 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1879,7 +1879,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 {
 	int res;
 	unsigned nn, i;
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *next;
 	struct nvme_id_ctrl *ctrl;
 	struct nvme_id_ns *id_ns;
 	void *mem;
@@ -1912,16 +1912,22 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	id_ns = mem;
 	for (i = 1; i <= nn; i++) {
 		res = nvme_identify(dev, i, 0, dma_addr);
-		if (res)
+		if (res) {
+			if (res < 0)
+				goto out_free;
 			continue;
+		}
 
 		if (id_ns->ncap == 0)
 			continue;
 
 		res = nvme_get_features(dev, NVME_FEAT_LBA_RANGE, i,
 							dma_addr + 4096, NULL);
-		if (res)
+		if (res) {
+			if (res < 0)
+				goto out_free;
 			memset(mem + 4096, 0, 4096);
+		}
 
 		ns = nvme_alloc_ns(dev, i, mem, mem + 4096);
 		if (ns)
@@ -1930,7 +1936,13 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	list_for_each_entry(ns, &dev->namespaces, list)
 		add_disk(ns->disk);
 	res = 0;
+	goto out;
 
+ out_free:
+	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
+		list_del(&ns->list);
+		nvme_ns_free(ns);
+	}
  out:
 	dma_free_coherent(&dev->pci_dev->dev, 8192, mem, dma_addr);
 	return res;
-- 
1.7.0.4
