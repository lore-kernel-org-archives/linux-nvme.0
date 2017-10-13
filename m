From: jsmart2021@gmail.com (James Smart)
Date: Fri, 13 Oct 2017 13:38:00 -0700
Subject: [PATCH] nvmet: protect sqhd update by a lock
Message-ID: <20171013203800.24125-1-jsmart2021@gmail.com>

In testing target io in read write mix, we did indeed get into cases
where sqhd didn't update properly and slowly missed enough updates to
shutdown the queue.

Protect the read/modify/set update of sqhd under a lock for coherency.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/core.c  | 8 +++++++-
 drivers/nvme/target/nvmet.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index cfc35cbb6fe2..c753826390d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -387,11 +387,16 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 
 static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 {
+	unsigned long flags;
+
 	if (status)
 		nvmet_set_status(req, status);
 
-	if (req->sq->size)
+	if (req->sq->size) {
+		spin_lock_irqsave(&req->sq->sqhd_lock, flags);
 		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
+		spin_unlock_irqrestore(&req->sq->sqhd_lock, flags);
+	}
 	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
@@ -425,6 +430,7 @@ void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 	sq->size = size;
 
 	ctrl->sqs[qid] = sq;
+	spin_lock_init(&sq->sqhd_lock);
 }
 
 static void nvmet_confirm_sq(struct percpu_ref *ref)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ed38b44a7007..bdb904bdf676 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -77,6 +77,7 @@ struct nvmet_sq {
 	u16			sqhd;
 	struct completion	free_done;
 	struct completion	confirm_done;
+	spinlock_t		sqhd_lock;
 };
 
 /**
-- 
2.13.1
