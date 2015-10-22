From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 14:03:41 +0200
Subject: [PATCH 9/9] nvme: switch abort_limit to an atomic_t
In-Reply-To: <1445515421-4940-1-git-send-email-hch@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
Message-ID: <1445515421-4940-10-git-send-email-hch@lst.de>

There is no lock to sychronize access to the abort_limit field of
struct nvme_ctrl, so switch it to an atomic_t.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 drivers/nvme/host/nvme.h | 2 +-
 drivers/nvme/host/pci.c  | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index edfc75e..f4075f1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -625,7 +625,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	ctrl->oncs = le16_to_cpup(&id->oncs);
-	ctrl->abort_limit = id->acl + 1;
+	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	memcpy(ctrl->serial, id->sn, sizeof(id->sn));
 	memcpy(ctrl->model, id->mn, sizeof(id->mn));
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index da63835..1658048 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -56,7 +56,7 @@ struct nvme_ctrl {
 	u32 stripe_size;
 	u32 page_size;
 	u16 oncs;
-	u16 abort_limit;
+	atomic_t abort_limit;
 	u8 event_limit;
 	u8 vwc;
 	u32 vs;
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e1fe093..794ca2c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -384,7 +384,7 @@ static void abort_completion(struct nvme_queue *nvmeq, void *ctx,
 	blk_mq_free_request(req);
 
 	dev_warn(nvmeq->q_dmadev, "Abort status:%x result:%x", status, result);
-	++nvmeq->dev->ctrl.abort_limit;
+	atomic_inc(&nvmeq->dev->ctrl.abort_limit);
 }
 
 static void async_completion(struct nvme_queue *nvmeq, void *ctx,
@@ -1067,13 +1067,15 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_HANDLED;
 	}
 
-	if (!dev->ctrl.abort_limit)
+	if (atomic_dec_and_test(&dev->ctrl.abort_limit))
 		return BLK_EH_RESET_TIMER;
 
 	abort_req = blk_mq_alloc_request(dev->ctrl.admin_q, WRITE, GFP_ATOMIC,
 									false);
-	if (IS_ERR(abort_req))
+	if (IS_ERR(abort_req)) {
+		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
+	}
 
 	abort_cmd = blk_mq_rq_to_pdu(abort_req);
 	nvme_set_info(abort_cmd, abort_req, abort_completion);
@@ -1084,7 +1086,6 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	cmd.abort.sqid = cpu_to_le16(nvmeq->qid);
 	cmd.abort.command_id = abort_req->tag;
 
-	--dev->ctrl.abort_limit;
 	cmd_rq->aborted = 1;
 
 	dev_warn(nvmeq->q_dmadev, "I/O %d QID %d timeout, aborting\n",
-- 
1.9.1
