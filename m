From: keith.busch@intel.com (Keith Busch)
Date: Wed,  3 Dec 2014 17:07:13 -0700
Subject: [PATCH] NVMe: Fix command setup on IO retry
Message-ID: <1417651633-16862-1-git-send-email-keith.busch@intel.com>

On retry, the req->special is pointing to an already setup IOD, but we
still need to setup the command context and callback, otherwise you'll
see false twice completed errors and leak requests.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 0da7756..23dd4fd 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -641,8 +641,6 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	iod->private = req;
 	req->special = iod;
 
-	nvme_set_info(cmd, iod, req_completion);
-
 	if (req->cmd_flags & REQ_DISCARD) {
 		void *range;
 		/*
@@ -678,6 +676,7 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
  submit_iod:
+	nvme_set_info(cmd, iod, req_completion);
 	spin_lock_irq(&nvmeq->q_lock);
 	if (req->cmd_flags & REQ_DISCARD)
 		nvme_submit_discard(nvmeq, ns, req, iod);
-- 
1.7.10.4
