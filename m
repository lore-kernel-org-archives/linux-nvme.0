From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  3 Oct 2018 01:13:19 -0700
Subject: [PATCH v2 1/4] nvmet: support fabrics sq flow control
In-Reply-To: <20181003081323.7504-1-sagi@grimberg.me>
References: <20181003081323.7504-1-sagi@grimberg.me>
Message-ID: <20181003081323.7504-2-sagi@grimberg.me>

Technical proposal 8005 "fabrics SQ flow control" introduces a mode
where a host and controller agree to omit sq_head pointer updates
when sending nvme completions.

In case the host indicated desire to operate in this mode (connect attribute)
the controller will return back a connect completion with sq_head value
of 0xffff as indication that it will omit sq_head pointer updates.

This mode saves us an atomic update in the I/O path.

Reviewed-by: Hannes Reinecke <hare at suse.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/core.c        | 34 ++++++++++++++++++++-----------
 drivers/nvme/target/fabrics-cmd.c |  8 +++++++-
 drivers/nvme/target/nvmet.h       |  3 ++-
 include/linux/nvme.h              |  4 ++++
 4 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 7084704b468d..df2af5e3e4d6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -503,26 +503,35 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 }
 
-static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
+static void nvmet_update_sq_head(struct nvmet_req *req)
 {
 	u32 old_sqhd, new_sqhd;
 	u16 sqhd;
 
-	if (status)
-		nvmet_set_status(req, status);
-
-	if (req->sq->size) {
-		do {
-			old_sqhd = req->sq->sqhd;
-			new_sqhd = (old_sqhd + 1) % req->sq->size;
-		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
-					old_sqhd);
+	if (!req->sq->sqhd_disabled) {
+		if (req->sq->size) {
+			do {
+				old_sqhd = req->sq->sqhd;
+				new_sqhd = (old_sqhd + 1) % req->sq->size;
+			} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
+						old_sqhd);
+		}
 	}
+
 	sqhd = req->sq->sqhd & 0x0000FFFF;
 	req->rsp->sq_head = cpu_to_le16(sqhd);
+}
+
+static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
+{
+	if (status)
+		nvmet_set_status(req, status);
+
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
 
+	nvmet_update_sq_head(req);
+
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
 	req->ops->queue_response(req);
@@ -545,9 +554,10 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
 }
 
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
-		u16 qid, u16 size)
+		u16 qid, u16 size, bool sqhd_disabled)
 {
-	sq->sqhd = 0;
+	sq->sqhd_disabled = sqhd_disabled;
+	sq->sqhd = sq->sqhd_disabled ? 0xffff : 0;
 	sq->qid = qid;
 	sq->size = size;
 
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d84ae004cb85..1f05d8507e35 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -114,7 +114,9 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
-	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
+	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1,
+			!!(c->cattr & NVME_CONNECT_DISABLE_SQFLOW));
+
 	return 0;
 }
 
@@ -173,6 +175,8 @@ static void nvmet_execute_admin_connect(struct nvmet_req *req)
 	kfree(d);
 complete:
 	nvmet_req_complete(req, status);
+	if (req->sq->sqhd_disabled)
+		req->sq->sqhd = 0;
 }
 
 static void nvmet_execute_io_connect(struct nvmet_req *req)
@@ -229,6 +233,8 @@ static void nvmet_execute_io_connect(struct nvmet_req *req)
 	kfree(d);
 complete:
 	nvmet_req_complete(req, status);
+	if (req->sq->sqhd_disabled)
+		req->sq->sqhd = 0;
 	return;
 
 out_ctrl_put:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c5255e743f63..9681be52f6e6 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -95,6 +95,7 @@ struct nvmet_sq {
 	u16			qid;
 	u16			size;
 	u32			sqhd;
+	bool			sqhd_disabled;
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
@@ -343,7 +344,7 @@ void nvmet_req_complete(struct nvmet_req *req, u16 status);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
-		u16 size);
+		u16 size, bool sqhd_disabled);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 429c4cf90899..60c9dfc67627 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1035,6 +1035,10 @@ struct nvmf_disc_rsp_page_hdr {
 	struct nvmf_disc_rsp_page_entry entries[0];
 };
 
+enum {
+	NVME_CONNECT_DISABLE_SQFLOW	= (1 << 2),
+};
+
 struct nvmf_connect_command {
 	__u8		opcode;
 	__u8		resv1;
-- 
2.17.1
