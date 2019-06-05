From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:29 +0200
Subject: [PATCH 06/13] ufshcd: set max_segment_size in the scsi host template
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
Message-ID: <20190605190836.32354-7-hch@lst.de>

We need to also mirror the value to the device to ensure IOMMU merging
doesn't undo it, and the SCSI host level parameter will ensure that.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/scsi/ufs/ufshcd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/ufs/ufshcd.c b/drivers/scsi/ufs/ufshcd.c
index 8c1c551f2b42..4e524ade489e 100644
--- a/drivers/scsi/ufs/ufshcd.c
+++ b/drivers/scsi/ufs/ufshcd.c
@@ -4586,8 +4586,6 @@ static int ufshcd_slave_configure(struct scsi_device *sdev)
 	struct request_queue *q = sdev->request_queue;
 
 	blk_queue_update_dma_pad(q, PRDT_DATA_BYTE_COUNT_PAD - 1);
-	blk_queue_max_segment_size(q, PRDT_DATA_BYTE_COUNT_MAX);
-
 	return 0;
 }
 
@@ -6990,6 +6988,7 @@ static struct scsi_host_template ufshcd_driver_template = {
 	.sg_tablesize		= SG_ALL,
 	.cmd_per_lun		= UFSHCD_CMD_PER_LUN,
 	.can_queue		= UFSHCD_CAN_QUEUE,
+	.max_segment_size	= PRDT_DATA_BYTE_COUNT_MAX,
 	.max_host_blocked	= 1,
 	.track_queue_depth	= 1,
 	.sdev_groups		= ufshcd_driver_groups,
-- 
2.20.1
