From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Fri, 15 Mar 2019 16:57:42 +0800
Subject: [PATCH 6/8] skd: use blk_mq_queue_tag_busy_iter
In-Reply-To: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1552640264-26101-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1552640264-26101-7-git-send-email-jianchao.w.wang@oracle.com>

blk_mq_tagset_busy_iter is not safe that it could get stale request
in tags->rqs[]. Use blk_mq_queue_tag_busy_iter here.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/block/skd_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/skd_main.c b/drivers/block/skd_main.c
index ab893a7..60c34ff 100644
--- a/drivers/block/skd_main.c
+++ b/drivers/block/skd_main.c
@@ -395,7 +395,7 @@ static int skd_in_flight(struct skd_device *skdev)
 {
 	int count = 0;
 
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_inc_in_flight, &count);
+	blk_mq_queue_tag_busy_iter(skdev->queue, skd_inc_in_flight, &count, true);
 
 	return count;
 }
@@ -1916,7 +1916,7 @@ static bool skd_recover_request(struct request *req, void *data, bool reserved)
 
 static void skd_recover_requests(struct skd_device *skdev)
 {
-	blk_mq_tagset_busy_iter(&skdev->tag_set, skd_recover_request, skdev);
+	blk_mq_queue_tag_busy_iter(skdev->queue, skd_recover_request, skdev, true);
 }
 
 static void skd_isr_msg_from_dev(struct skd_device *skdev)
-- 
2.7.4
