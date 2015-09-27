From: hch@lst.de (Christoph Hellwig)
Date: Sun, 27 Sep 2015 21:01:52 +0200
Subject: [PATCH 04/10] blk-mq: kill undead requests during CPU hotplug notify
In-Reply-To: <1443380518-6829-1-git-send-email-hch@lst.de>
References: <1443380518-6829-1-git-send-email-hch@lst.de>
Message-ID: <1443380518-6829-5-git-send-email-hch@lst.de>

REQ_NO_TIMEOUT requests can linger out basically forever, so we need
to kill them before waiting for all requests to complete in the
hotplug CPU notification.  Note that we really should be doing an
abort here, but that will require much more invasive changes to allow
certain preemptable requests to be started while the queue has already
been frozen.  As this new code isn't any worse than the early request
freeing done currently by the nvme driver I'd like to get it in for now
and sort the full hornet's nest later.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 block/blk-mq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 732f15c..f11c745 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2092,6 +2092,13 @@ static void blk_mq_queue_reinit(struct request_queue *q)
 	blk_mq_sysfs_register(q);
 }
 
+static void blk_mq_kill_undead(struct blk_mq_hw_ctx *hctx,
+		struct request *rq, void *priv, bool reserved)
+{
+	if (rq->cmd_flags & REQ_NO_TIMEOUT)
+		blk_mq_complete_request(rq, -EINTR);
+}
+
 static int blk_mq_queue_reinit_notify(struct notifier_block *nb,
 				      unsigned long action, void *hcpu)
 {
@@ -2116,8 +2123,10 @@ static int blk_mq_queue_reinit_notify(struct notifier_block *nb,
 	 * one swoop and then wait for the completions so that freezing can
 	 * take place in parallel.
 	 */
-	list_for_each_entry(q, &all_q_list, all_q_node)
+	list_for_each_entry(q, &all_q_list, all_q_node) {
 		blk_mq_freeze_queue_start(q);
+		blk_mq_queue_tag_busy_iter(q, blk_mq_kill_undead, NULL);
+	}
 	list_for_each_entry(q, &all_q_list, all_q_node) {
 		blk_mq_freeze_queue_wait(q);
 
-- 
1.9.1
