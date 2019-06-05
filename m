From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:27 +0200
Subject: [PATCH 04/13] mmc: also set max_segment_size in the device
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
Message-ID: <20190605190836.32354-5-hch@lst.de>

If we only set the max_segment_size on the queue an IOMMU merge might
create bigger segments again, so limit the IOMMU merges as well.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/mmc/core/queue.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mmc/core/queue.c b/drivers/mmc/core/queue.c
index b5b9c6142f08..92900a095796 100644
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@ -377,6 +377,8 @@ static void mmc_setup_queue(struct mmc_queue *mq, struct mmc_card *card)
 	blk_queue_max_segment_size(mq->queue,
 			round_down(host->max_seg_size, block_size));
 
+	dma_set_max_seg_size(mmc_dev(host), queue_max_segment_size(mq->queue));
+
 	INIT_WORK(&mq->recovery_work, mmc_mq_recovery_handler);
 	INIT_WORK(&mq->complete_work, mmc_blk_mq_complete_work);
 
-- 
2.20.1
