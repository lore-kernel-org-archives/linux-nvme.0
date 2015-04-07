From: keith.busch@intel.com (Keith Busch)
Date: Tue,  7 Apr 2015 15:48:26 -0600
Subject: [PATCH] NVMe: Remove check for null
Message-ID: <1428443306-3495-1-git-send-email-keith.busch@intel.com>

Checking fails static analysis due to additional arithmetic prior to
the NULL check. Mapping doesn't return NULL here anyway, so removing
the check.

Reported-by: Dan Carpenter <dan.carpenter at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ef43278..8729266 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -517,8 +517,6 @@ static void nvme_dif_remap(struct request *req,
 		return;
 
 	pmap = kmap_atomic(bip->bip_vec->bv_page) + bip->bip_vec->bv_offset;
-	if (!pmap)
-		return;
 
 	p = pmap;
 	virt = bip_get_seed(bip);
-- 
1.7.10.4
