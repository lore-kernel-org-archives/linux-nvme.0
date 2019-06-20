From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Jun 2019 10:12:36 -0600
Subject: [RFC PATCH 24/28] block: Remove PCI_P2PDMA queue flag
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
References: <20190620161240.22738-1-logang@deltatee.com>
Message-ID: <20190620161240.22738-25-logang@deltatee.com>

This flag has been superseded by the DMA_DIRECT functionality.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 include/linux/blkdev.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index a5b856324276..9ea800645cf5 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -615,8 +615,7 @@ struct request_queue {
 #define QUEUE_FLAG_REGISTERED	22	/* queue has been registered to a disk */
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 23	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED	24	/* queue has been quiesced */
-#define QUEUE_FLAG_PCI_P2PDMA	25	/* device supports PCI p2p requests */
-#define QUEUE_FLAG_DMA_DIRECT	26	/* device supports dma-addr requests */
+#define QUEUE_FLAG_DMA_DIRECT	25	/* device supports dma-addr requests */
 
 #define QUEUE_FLAG_MQ_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP))
@@ -641,8 +640,6 @@ bool blk_queue_flag_test_and_set(unsigned int flag, struct request_queue *q);
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
-#define blk_queue_pci_p2pdma(q)	\
-	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 #define blk_queue_dma_direct(q)	\
 	test_bit(QUEUE_FLAG_DMA_DIRECT, &(q)->queue_flags)
 
-- 
2.20.1
