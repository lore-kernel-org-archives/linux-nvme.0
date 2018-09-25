From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 25 Sep 2018 10:22:25 -0600
Subject: [PATCH v7 07/13] block: Add PCI P2P flag for request queue and check
 support for requests
In-Reply-To: <20180925162231.4354-1-logang@deltatee.com>
References: <20180925162231.4354-1-logang@deltatee.com>
Message-ID: <20180925162231.4354-8-logang@deltatee.com>

QUEUE_FLAG_PCI_P2P is introduced meaning a driver's request queue
supports targeting P2P memory. This will be used by P2P providers and
orchestrators (in subsequent patches) to ensure block devices can
support P2P memory before submitting P2P backed pages to submit_bio().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 include/linux/blkdev.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6980014357d4..87fb1963b721 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -699,6 +699,7 @@ struct request_queue {
 #define QUEUE_FLAG_SCSI_PASSTHROUGH 27	/* queue supports SCSI commands */
 #define QUEUE_FLAG_QUIESCED    28	/* queue has been quiesced */
 #define QUEUE_FLAG_PREEMPT_ONLY	29	/* only process REQ_PREEMPT requests */
+#define QUEUE_FLAG_PCI_P2PDMA  30	/* device supports pci p2p requests */
 
 #define QUEUE_FLAG_DEFAULT	((1 << QUEUE_FLAG_IO_STAT) |		\
 				 (1 << QUEUE_FLAG_SAME_COMP)	|	\
@@ -731,6 +732,8 @@ bool blk_queue_flag_test_and_clear(unsigned int flag, struct request_queue *q);
 #define blk_queue_dax(q)	test_bit(QUEUE_FLAG_DAX, &(q)->queue_flags)
 #define blk_queue_scsi_passthrough(q)	\
 	test_bit(QUEUE_FLAG_SCSI_PASSTHROUGH, &(q)->queue_flags)
+#define blk_queue_pci_p2pdma(q)	\
+	test_bit(QUEUE_FLAG_PCI_P2PDMA, &(q)->queue_flags)
 
 #define blk_noretry_request(rq) \
 	((rq)->cmd_flags & (REQ_FAILFAST_DEV|REQ_FAILFAST_TRANSPORT| \
-- 
2.19.0
