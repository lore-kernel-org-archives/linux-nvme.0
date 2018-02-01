From: keith.busch@intel.com (Keith Busch)
Date: Thu,  1 Feb 2018 14:41:15 -0700
Subject: [PATCH] blk-mq-sched: Enable merging discard bio into request
Message-ID: <20180201214115.24909-1-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 block/blk-mq-sched.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index 55c0a745b427..25c14c58385c 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -259,6 +259,8 @@ bool blk_mq_sched_try_merge(struct request_queue *q, struct bio *bio,
 		if (!*merged_request)
 			elv_merged_request(q, rq, ELEVATOR_FRONT_MERGE);
 		return true;
+	case ELEVATOR_DISCARD_MERGE:
+		return bio_attempt_discard_merge(q, rq, bio);
 	default:
 		return false;
 	}
-- 
2.14.3
