From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 14 Nov 2018 10:25:30 -0800
Subject: [PATCH v3 1/4] nvmet: support fabrics sq flow control
In-Reply-To: <20181114182534.28807-1-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
Message-ID: <20181114182534.28807-2-sagi@grimberg.me>

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
 drivers/nvme/target/core.c        | 21 ++++++++++++++-------
 drivers/nvme/target/fabrics-cmd.c |  8 +++++++-
 drivers/nvme/target/nvmet.h       |  3 ++-
 include/linux/nvme.h              |  4 ++++
 4 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e3e158ff207a..9240b0a245a1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -597,15 +597,12 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
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
+	if (!req->sq->sqhd_disabled && req->sq->size) {
 		do {
 			old_sqhd = req->sq->sqhd;
 			new_sqhd = (old_sqhd + 1) % req->sq->size;
@@ -614,9 +611,18 @@ static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
 	}
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
@@ -639,9 +645,10 @@ void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
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
index 31474940e373..613a37683eae 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -106,6 +106,7 @@ struct nvmet_sq {
 	u16			qid;
 	u16			size;
 	u32			sqhd;
+	bool			sqhd_disabled;
 	struct completion	free_done;
 	struct completion	confirm_done;
 };
@@ -386,7 +387,7 @@ void nvmet_execute_keep_alive(struct nvmet_req *req);
 void nvmet_cq_setup(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
 		u16 size);
 void nvmet_sq_setup(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
-		u16 size);
+		u16 size, bool sqhd_disabled);
 void nvmet_sq_destroy(struct nvmet_sq *sq);
 int nvmet_sq_init(struct nvmet_sq *sq);
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 77d320d32ee5..e7d731776f62 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -1044,6 +1044,10 @@ struct nvmf_disc_rsp_page_hdr {
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
