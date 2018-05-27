From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 27 May 2018 18:50:10 +0300
Subject: [PATCH 05/17] nvme: Fix extended data LBA supported setting
In-Reply-To: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
References: <1527436222-15494-1-git-send-email-maxg@mellanox.com>
Message-ID: <1527436222-15494-6-git-send-email-maxg@mellanox.com>

This value depands on the metadata support value.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71..d8254b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1443,8 +1443,8 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
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
1.8.3.1
