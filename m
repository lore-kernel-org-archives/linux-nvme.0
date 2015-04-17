From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Apr 2015 22:37:19 +0200
Subject: [PATCH 4/7] block: remove REQ_TYPE_PM_SHUTDOWN
In-Reply-To: <1429303042-12078-1-git-send-email-hch@lst.de>
References: <1429303042-12078-1-git-send-email-hch@lst.de>
Message-ID: <1429303042-12078-5-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/blkdev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 6076b9e..c2829ba 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -77,7 +77,6 @@ enum rq_cmd_type_bits {
 	REQ_TYPE_BLOCK_PC,		/* scsi command */
 	REQ_TYPE_PM_SUSPEND,		/* suspend request */
 	REQ_TYPE_PM_RESUME,		/* resume request */
-	REQ_TYPE_PM_SHUTDOWN,		/* shutdown request */
 	REQ_TYPE_DRV_PRIV,		/* driver defined types from here */
 };
 
-- 
1.9.1
