From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jun 2018 08:13:06 -0600
Subject: [PATCH 3/6] nvme-pci: Queue creation fixes
In-Reply-To: <20180606141309.19389-1-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
Message-ID: <20180606141309.19389-4-keith.busch@intel.com>

We've been ignoring NVMe error status on queue creations. Fortunately they
are uncommon, but we should handle these anyway. This patch adds checks
for the a positive error return value that indicates an NVMe status.

If we do see a negative return, the controller isn't usable, so this
patch returns immediately in since we can't unwind that failure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 94d9abbe2d45..ed9fac721b8c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1466,11 +1466,13 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	 */
 	vector = dev->num_vecs == 1 ? 0 : qid;
 	result = adapter_alloc_cq(dev, qid, nvmeq, vector);
-	if (result < 0)
-		goto out;
+	if (result)
+		return result;
 
 	result = adapter_alloc_sq(dev, qid, nvmeq);
 	if (result < 0)
+		return result;
+	else if (result)
 		goto release_cq;
 
 	/*
@@ -1492,7 +1494,6 @@ static int nvme_create_queue(struct nvme_queue *nvmeq, int qid)
 	adapter_delete_sq(dev, qid);
 release_cq:
 	adapter_delete_cq(dev, qid);
-out:
 	return result;
 }
 
-- 
2.14.3
