From: igor.j.konopko@intel.com (Igor Konopko)
Date: Tue, 29 May 2018 15:45:15 +0200
Subject: [PATCH] Set extended metadata field properly
Message-ID: <20180529134515.3452-1-igor.j.konopko@intel.com>

When setting extended metadata indicator in namespace
structure we take metadata size into consideration.
Unfortunately up-to-date metadata size is
not yet set during this calculation, which results
in incorrect setting of that field in some cases.

This patch fixes that issue.

Signed-off-by: Igor Konopko <igor.j.konopko at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5e1d6d69b307..553af7531329 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1448,8 +1448,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
 	ns->noiob = le16_to_cpu(id->noiob);
-	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
+	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	/* the PI implementation requires metadata equal t10 pi tuple size */
 	if (ns->ms == sizeof(struct t10_pi_tuple))
 		ns->pi_type = id->dps & NVME_NS_DPS_PI_MASK;
-- 
2.14.3
