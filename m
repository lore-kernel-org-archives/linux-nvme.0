From: hch@lst.de (Christoph Hellwig)
Date: Tue, 21 Jun 2016 18:04:19 +0200
Subject: [PATCH 1/3] block: Export blk_poll
In-Reply-To: <1466525061-3686-1-git-send-email-hch@lst.de>
References: <1466525061-3686-1-git-send-email-hch@lst.de>
Message-ID: <1466525061-3686-2-git-send-email-hch@lst.de>

From: Sagi Grimberg <sagi@grimberg.me>

The new NVMe over fabrics target will make use of this outside from a
module.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index c94c7ad..d66509f 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -3390,6 +3390,7 @@ bool blk_poll(struct request_queue *q, blk_qc_t cookie)
 
 	return false;
 }
+EXPORT_SYMBOL_GPL(blk_poll);
 
 #ifdef CONFIG_PM
 /**
-- 
2.1.4
