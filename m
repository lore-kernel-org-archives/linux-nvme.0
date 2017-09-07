From: jsmart2021@gmail.com (James Smart)
Date: Thu,  7 Sep 2017 13:18:36 -0700
Subject: [PATCH] nvmet: implement valid sqhd values in completions
Message-ID: <20170907201836.25067-1-jsmart2021@gmail.com>

To support sqhd, for initiators that are following the spec and
paying attention to sqhd vs their sqtail values:
- add sqhd to struct nvmet_sq
- initialize sqhd to 0 in nvmet_sq_setup
- rather than propagate the 0's-based qsize value from the connect message
  which requires a +1 in every sqhd update, and as nothing else references
  it, convert to 1's-based value in nvmt_sq/cq_setup() calls.
- validate connect message sqsize being non-zero per spec.
- updated assign sqhd for every completion that goes back.

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/core.c        | 9 +++++----
 drivers/nvme/target/fabrics-cmd.c | 9 +++++++--
 drivers/nvme/target/nvmet.h       | 1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7c23eaf8e563..434394ead4a2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -390,8 +390,8 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	if (status)
 		nvmet_set_status(req, status);
 
-	/* XXX: need to fill in something useful for sq_head */
-	req->rsp->sq_head = 0;
+	req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
+	req->rsp->sq_head = req->sq->sqhd;
 	if (likely(req->sq)) /* may happen during early failure */
 		req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
@@ -412,7 +412,7 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 		u16 qid, u16 size)
 {
 	cq->qid = qid;
-	cq->size = size;
+	cq->size = size;	/* 1's-based number now ! */
 
 	ctrl->cqs[qid] = cq;
 }
@@ -420,8 +420,9 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
 		u16 qid, u16 size)
 {
+	sq->sqhd = 0;
 	sq->qid = qid;
-	sq->size = size;
+	sq->size = size;	/* 1's-based number now ! */
 
 	ctrl->sqs[qid] = sq;
 }
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index 859a66725291..db3bf6b8bf9e 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -109,9 +109,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 		pr_warn("queue already connected!\n");
 		return NVME_SC_CONNECT_CTRL_BUSY | NVME_SC_DNR;
 	}
+	if (!sqsize) {
+		pr_warn("queue size zero!\n");
+		return NVME_SC_CONNECT_INVALID_PARAM | NVME_SC_DNR;
+	}
 
-	nvmet_cq_setup(ctrl, req->cq, qid, sqsize);
-	nvmet_sq_setup(ctrl, req->sq, qid, sqsize);
+	/* note: convert queue size from 0's-based value to 1's-based value */
+	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
+	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 7d261ab894f4..7b8e20adf760 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -74,6 +74,7 @@ struct nvmet_sq {
 	struct percpu_ref	ref;
 	u16			qid;
 	u16			size;
+	u16			sqhd;
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
-- 
2.13.1
