From: pandey.alok@samsung.com (Alok Pandey)
Date: Tue, 28 Jul 2015 20:03:53 +0530
Subject: [PATCH V2] NVMe: Using PRACT bit to generate and verify PI by
 controller
Message-ID: <1438094033-2693-1-git-send-email-pandey.alok@samsung.com>

This patch enables the PRCHK and reftag support when PRACT bit is set, and
block layer integrity is disabled.

Signed-off-by: Alok Pandey <pandey.alok at samsung.com>
---
 drivers/block/nvme-core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..ede8fb6 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -815,11 +815,10 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
-	if (blk_integrity_rq(req)) {
-		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
+	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
-			control |= NVME_RW_PRINFO_PRCHK_GUARD;
+		control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
 		case NVME_NS_DPS_PI_TYPE1:
 		case NVME_NS_DPS_PI_TYPE2:
@@ -829,8 +828,12 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 					nvme_block_nr(ns, blk_rq_pos(req)));
 			break;
 		}
-	} else if (ns->ms)
-		control |= NVME_RW_PRINFO_PRACT;
+		if (blk_integrity_rq(req))
+			cmnd->rw.metadata =
+				cpu_to_le64(sg_dma_address(iod->meta_sg));
+		else
+			control |= NVME_RW_PRINFO_PRACT;
+	}
 
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
@@ -1989,7 +1992,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 								!ns->ext)
 		nvme_init_integrity(ns);
 
-	if (ns->ms && !blk_get_integrity(disk))
+	if (ns->ms && !(ns->ms == 8 && ns->pi_type) && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
-- 
1.9.1
