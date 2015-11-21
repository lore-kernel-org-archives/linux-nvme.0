From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:19:44 +0100
Subject: [PATCH 04/47] block: provide a new BLK_EH_QUIESCED timeout return
 value
In-Reply-To: <1448090427-18749-1-git-send-email-hch@lst.de>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
Message-ID: <1448090427-18749-5-git-send-email-hch@lst.de>

This marks the request as one that's not actually completed yet, but
should be reaped next time blk_mq_complete_request comes in.  This is
useful it the abort handler kicked of a reset that will complete all
pending requests.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c         | 6 +++++-
 block/blk-softirq.c    | 3 ++-
 block/blk-timeout.c    | 3 +++
 block/blk.h            | 1 +
 include/linux/blkdev.h | 1 +
 5 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8354601..76773dc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -383,7 +383,8 @@ void blk_mq_complete_request(struct request *rq, int error)
 
 	if (unlikely(blk_should_fake_timeout(q)))
 		return;
-	if (!blk_mark_rq_complete(rq)) {
+	if (!blk_mark_rq_complete(rq) ||
+	    test_and_clear_bit(REQ_ATOM_QUIESCED, &rq->atomic_flags)) {
 		rq->errors = error;
 		__blk_mq_complete_request(rq);
 	}
@@ -586,6 +587,9 @@ void blk_mq_rq_timed_out(struct request *req, bool reserved)
 		break;
 	case BLK_EH_NOT_HANDLED:
 		break;
+	case BLK_EH_QUIESCED:
+		set_bit(REQ_ATOM_QUIESCED, &req->atomic_flags);
+		break;
 	default:
 		printk(KERN_ERR "block: bad eh return: %d\n", ret);
 		break;
diff --git a/block/blk-softirq.c b/block/blk-softirq.c
index 53b1737..9d47fbc 100644
--- a/block/blk-softirq.c
+++ b/block/blk-softirq.c
@@ -167,7 +167,8 @@ void blk_complete_request(struct request *req)
 {
 	if (unlikely(blk_should_fake_timeout(req->q)))
 		return;
-	if (!blk_mark_rq_complete(req))
+	if (!blk_mark_rq_complete(req) ||
+	    test_and_clear_bit(REQ_ATOM_QUIESCED, &req->atomic_flags))
 		__blk_complete_request(req);
 }
 EXPORT_SYMBOL(blk_complete_request);
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index aedd128..b3a7f20 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -96,6 +96,9 @@ static void blk_rq_timed_out(struct request *req)
 		blk_add_timer(req);
 		blk_clear_rq_complete(req);
 		break;
+	case BLK_EH_QUIESCED:
+		set_bit(REQ_ATOM_QUIESCED, &req->atomic_flags);
+		break;
 	case BLK_EH_NOT_HANDLED:
 		/*
 		 * LLD handles this for now but in the future
diff --git a/block/blk.h b/block/blk.h
index 37b9165..f4c98f8 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -120,6 +120,7 @@ void blk_account_io_done(struct request *req);
 enum rq_atomic_flags {
 	REQ_ATOM_COMPLETE = 0,
 	REQ_ATOM_STARTED,
+	REQ_ATOM_QUIESCED,
 };
 
 /*
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 9a8424a..5df5fb13 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -223,6 +223,7 @@ enum blk_eh_timer_return {
 	BLK_EH_NOT_HANDLED,
 	BLK_EH_HANDLED,
 	BLK_EH_RESET_TIMER,
+	BLK_EH_QUIESCED,
 };
 
 typedef enum blk_eh_timer_return (rq_timed_out_fn)(struct request *);
-- 
1.9.1
