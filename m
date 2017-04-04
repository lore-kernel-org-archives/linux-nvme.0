From: keith.busch@intel.com (Keith Busch)
Date: Tue,  4 Apr 2017 18:18:12 -0400
Subject: [PATCH] nvme/pci: Don't set reserved SQ create flags
Message-ID: <1491344292-23949-1-git-send-email-keith.busch@intel.com>

The QPRIO field is only valid if weighted round robin arbitration is used,
and this driver doesn't enable that controller configuration option.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 26a5fd0..4eb0815 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -812,7 +812,7 @@ static int adapter_alloc_sq(struct nvme_dev *dev, u16 qid,
 						struct nvme_queue *nvmeq)
 {
 	struct nvme_command c;
-	int flags = NVME_QUEUE_PHYS_CONTIG | NVME_SQ_PRIO_MEDIUM;
+	int flags = NVME_QUEUE_PHYS_CONTIG;
 
 	/*
 	 * Note: we (ab)use the fact the the prp fields survive if no data
-- 
2.5.5
