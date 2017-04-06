From: hch@lst.de (Christoph Hellwig)
Date: Thu,  6 Apr 2017 17:39:30 +0200
Subject: [PATCH 11/25] null_blk: don't pass always-0 req->errors to
 blk_mq_complete_request
In-Reply-To: <20170406153944.10058-1-hch@lst.de>
References: <20170406153944.10058-1-hch@lst.de>
Message-ID: <20170406153944.10058-12-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/null_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index f93906ff31e8..24ca85a70fd8 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -281,7 +281,7 @@ static inline void null_handle_cmd(struct nullb_cmd *cmd)
 	case NULL_IRQ_SOFTIRQ:
 		switch (queue_mode)  {
 		case NULL_Q_MQ:
-			blk_mq_complete_request(cmd->rq, cmd->rq->errors);
+			blk_mq_complete_request(cmd->rq, 0);
 			break;
 		case NULL_Q_RQ:
 			blk_complete_request(cmd->rq);
-- 
2.11.0
