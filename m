From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 25 Mar 2019 13:28:07 +0800
Subject: [PATCH V2 6/8] skd: use blk_mq_queue_tag_inflight_iter
In-Reply-To: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1553491689-1730-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1553491689-1730-7-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_inflight_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index 7d3ad6c..0213b19 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
 {
 	int count = 0;
 
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_inc_in_flight, &count);
 
 	return count;
 }
@@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
 
 static void skd_recover_requests(struct skd_device *skdev)
 {
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
+	blk_mq_queue_tag_inflight_iter(skdev->queue, skd_recover_request, skdev);
 }
 
 static void skd_isr_msg_from_dev(struct skd_device *skdev)
-- 
2.7.4
