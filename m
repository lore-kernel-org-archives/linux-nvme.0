From: xerofoify@gmail.com (Nicholas Krause)
Date: Thu,  2 Jul 2015 11:39:33 -0400
Subject: [PATCH] nvme:Make the function nvme_submit_iod void
Message-ID: <1435851573-21805-1-git-send-email-xerofoify@gmail.com>

This makes the function nvme_submit_iod void due to always completing
successfully without any non recoverable errors ever time this function
is called.

Signed-off-by: Nicholas Krause <xerofoify at gmail.com>
---
 drivers/block/nvme-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 34338d7..b9f6c8f 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -788,7 +788,7 @@ static void nvme_submit_flush(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	writel(nvmeq->sq_tail, nvmeq->q_db);
 }
 
-static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
+static void nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							struct nvme_ns *ns)
 {
 	struct request *req = iod_get_private(iod);
@@ -838,8 +838,6 @@ static int nvme_submit_iod(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (++nvmeq->sq_tail == nvmeq->q_depth)
 		nvmeq->sq_tail = 0;
 	writel(nvmeq->sq_tail, nvmeq->q_db);
-
-	return 0;
 }
 
 /*
-- 
2.1.4
