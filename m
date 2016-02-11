From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 13:05:38 -0700
Subject: [PATCHv2-4.5 01/10] blk-mq: End unstarted requests on dying queue
In-Reply-To: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
References: <1455221147-24228-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455221147-24228-2-git-send-email-keith.busch@intel.com>

Go directly to ending a request if it wasn't started. Previously, completing a
request may invoke a driver callback for a request it didn't initialize.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagig at mellanox.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Acked-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4c0622f..56c0a72 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -599,8 +599,10 @@ static void blk_mq_check_expired(struct blk_mq_hw_ctx *hctx,
 		 * If a request wasn't started before the queue was
 		 * marked dying, kill it here or it'll go unnoticed.
 		 */
-		if (unlikely(blk_queue_dying(rq->q)))
-			blk_mq_complete_request(rq, -EIO);
+		if (unlikely(blk_queue_dying(rq->q))) {
+			rq->errors = -EIO;
+			blk_mq_end_request(rq, rq->errors);
+		}
 		return;
 	}
 
-- 
2.6.2.307.g37023ba
