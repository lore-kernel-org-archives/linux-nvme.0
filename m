From: hch@lst.de (Christoph Hellwig)
Date: Mon, 25 Sep 2017 15:40:24 +0200
Subject: [PATCH 2/9] block: add REQ_DRV bit
In-Reply-To: <20170925134031.10548-1-hch@lst.de>
References: <20170925134031.10548-1-hch@lst.de>
Message-ID: <20170925134031.10548-3-hch@lst.de>

Set aside a bit in the request/bio flags for driver use.

Signed-off-by: Christoph Hellwig <hch at lst.de>
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
2.14.1
