From: hch@lst.de (Christoph Hellwig)
Date: Mon, 23 Oct 2017 16:51:11 +0200
Subject: [PATCH 02/17] block: add REQ_DRV bit
In-Reply-To: <20171023145126.2471-1-hch@lst.de>
References: <20171023145126.2471-1-hch@lst.de>
Message-ID: <20171023145126.2471-3-hch@lst.de>

Set aside a bit in the request/bio flags for driver use.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 include/linux/blk_types.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index acc2f3cdc2fc..7ec2ed097a8a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -229,6 +229,9 @@ enum req_flag_bits {
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
 
+	/* for driver use */
+	__REQ_DRV,
+
 	__REQ_NR_BITS,		/* stops here */
 };
 
@@ -249,6 +252,8 @@ enum req_flag_bits {
 
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 
+#define REQ_DRV			(1ULL << __REQ_DRV)
+
 #define REQ_FAILFAST_MASK \
 	(REQ_FAILFAST_DEV | REQ_FAILFAST_TRANSPORT | REQ_FAILFAST_DRIVER)
 
-- 
2.14.2
