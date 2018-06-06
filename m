From: keith.busch@intel.com (Keith Busch)
Date: Wed,  6 Jun 2018 08:13:04 -0600
Subject: [PATCH 1/6] nvme-pci: Remove unnecessary nested locking
In-Reply-To: <20180606141309.19389-1-keith.busch@intel.com>
References: <20180606141309.19389-1-keith.busch@intel.com>
Message-ID: <20180606141309.19389-2-keith.busch@intel.com>

The nvme pci driver no longer handles completions under the cq lock,
so the nested locking is not necesssary.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4d0bb0e45401..d42a1c361162 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2003,13 +2003,7 @@ static void nvme_del_cq_end(struct request *req, blk_status_t error)
 	if (!error) {
 		unsigned long flags;
 
-		/*
-		 * We might be called with the AQ cq_lock held
-		 * and the I/O queue cq_lock should always
-		 * nest inside the AQ one.
-		 */
-		spin_lock_irqsave_nested(&nvmeq->cq_lock, flags,
-					SINGLE_DEPTH_NESTING);
+		spin_lock_irqsave(&nvmeq->cq_lock, flags);
 		nvme_process_cq(nvmeq, &start, &end, -1);
 		spin_unlock_irqrestore(&nvmeq->cq_lock, flags);
 
-- 
2.14.3
