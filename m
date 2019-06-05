From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:30 +0200
Subject: [PATCH 07/13] storvsc: set virt_boundary_mask in the scsi host
 template
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
Message-ID: <20190605190836.32354-8-hch@lst.de>

This ensures all proper DMA layer handling is taken care of by the
SCSI midlayer.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/scsi/storvsc_drv.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8472de1007ff..e61051c026f6 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1434,9 +1434,6 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
-	/* Ensure there are no gaps in presented sgls */
-	blk_queue_virt_boundary(sdevice->request_queue, PAGE_SIZE - 1);
-
 	sdevice->no_write_same = 1;
 
 	/*
@@ -1709,6 +1706,8 @@ static struct scsi_host_template scsi_driver = {
 	.this_id =		-1,
 	/* Make sure we dont get a sg segment crosses a page boundary */
 	.dma_boundary =		PAGE_SIZE-1,
+	/* Ensure there are no gaps in presented sgls */
+	.virt_boundary_mask =	PAGE_SIZE-1,
 	.no_write_same =	1,
 	.track_queue_depth =	1,
 };
-- 
2.20.1
