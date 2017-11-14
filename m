From: colin.king@canonical.com (Colin King)
Date: Tue, 14 Nov 2017 14:26:27 +0000
Subject: [PATCH] nvme: fix spelling mistake: "requeing" -> "requeuing"
Message-ID: <20171114142627.20663-1-colin.king@canonical.com>

From: Colin Ian King <colin.king@canonical.com>

Trivial fix to spelling mistake in dev_warn_ratelimited message text

Signed-off-by: Colin Ian King <colin.king at canonical.com>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 78d92151a904..1218a9fca846 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -131,7 +131,7 @@ static blk_qc_t nvme_ns_head_make_request(struct request_queue *q,
 		bio->bi_opf |= REQ_NVME_MPATH;
 		ret = direct_make_request(bio);
 	} else if (!list_empty_careful(&head->list)) {
-		dev_warn_ratelimited(dev, "no path available - requeing I/O\n");
+		dev_warn_ratelimited(dev, "no path available - requeuing I/O\n");
 
 		spin_lock_irq(&head->requeue_lock);
 		bio_list_add(&head->requeue_list, bio);
-- 
2.14.1
