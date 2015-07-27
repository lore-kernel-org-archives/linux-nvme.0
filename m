From: pandey.alok@samsung.com (Alok Pandey)
Date: Mon, 27 Jul 2015 17:53:14 +0530
Subject: [PATCH] nvme: Using PRACT bit to generate and verify PI by controller
Message-ID: <1437999794-31257-1-git-send-email-pandey.alok@samsung.com>

Hi,

I am trying to use PRACT bit so that controller should generate and verify PI if controller is formatted with PI support.

In current implementation of mq-based nvme driver, the driver will set The PRACT bit = 1 in below 2 different scenarios
a)  If CONFIG_BLK_DEV_INTEGRITY is not set and device is formatted to support metadata. And
b)  If CONFIG_BLK_DEV_INTEGRITY is set but driver does not register for Integrity. Is there any way to do this by using any sysfs entry option?

To test support for PRACT bit, I disabled CONFIG_BLK_DEV_INTEGRITY and formatted the device.

It gives errors when I run FIO in two scenarios

a. Device is formatted with PI Type 1, LBA sie 512
   [Jul16 19:40] blk_update_request: I/O error, dev nvme0n1, sector 0
   [  +0.001820] Buffer I/O error on dev nvme0n1, logical block 0, async page read
   [ +29.972852] blk_update_request: I/O error, dev nvme0n1, sector 0
   [  +0.001818] Buffer I/O error on dev nvme0n1, logical block 0, async page read

b. Device is formatted with PI Type 3,LBA size 512
    [ +30.226253] blk_update_request: I/O error, dev nvme0n1, sector 0
    [  +0.001863] Buffer I/O error on dev nvme0n1, logical block 0, async page read

With the attached patch, I tested the nvme driver to make it work with PRACT = 1

The patch considers if device is formatted with metadata support and CONFIG_BLK_DEV_INTEGRITY is disabled.
The Host needs to
a) set the PRACT bit to 1
a) Provides the relevant PRCHK bits set for the supported PI type
b) If CONFIG_BLK_DEV_INTEGRITY is not set then always set the device actual capacity (not zero).

Signed-off-by: Alok Pandey <pandey.alok at samsung.com>
---
 drivers/block/nvme-core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..242a26c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -815,8 +815,12 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	cmnd->rw.slba = cpu_to_le64(nvme_block_nr(ns, blk_rq_pos(req)));
 	cmnd->rw.length = cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
-	if (blk_integrity_rq(req)) {
+	if (blk_integrity_rq(req))
 		cmnd->rw.metadata = cpu_to_le64(sg_dma_address(iod->meta_sg));
+	else if (ns->ms)
+		control |= NVME_RW_PRINFO_PRACT;
+
+	if (ns->ms) {
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE3:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
@@ -827,10 +831,8 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 					NVME_RW_PRINFO_PRCHK_REF;
 			cmnd->rw.reftag = cpu_to_le32(
 					nvme_block_nr(ns, blk_rq_pos(req)));
-			break;
 		}
-	} else if (ns->ms)
-		control |= NVME_RW_PRINFO_PRACT;
+	}
 
 	cmnd->rw.control = cpu_to_le16(control);
 	cmnd->rw.dsmgmt = cpu_to_le32(dsmgmt);
@@ -1988,10 +1990,11 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	if (ns->ms && !blk_get_integrity(disk) && (disk->flags & GENHD_FL_UP) &&
 								!ns->ext)
 		nvme_init_integrity(ns);
-
+#ifdef CONFIG_BLK_DEV_INTEGRITY
 	if (ns->ms && !blk_get_integrity(disk))
 		set_capacity(disk, 0);
 	else
+#endif
 		set_capacity(disk, le64_to_cpup(&id->nsze) << (ns->lba_shift - 9));
 
 	if (dev->oncs & NVME_CTRL_ONCS_DSM)
-- 
1.9.1
