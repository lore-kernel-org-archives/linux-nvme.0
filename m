From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:01 -0400
Subject: [PATCH 10/20] nvmet: isolate id ctrl/ns field initialization
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-11-chaitanya.kulkarni@wdc.com>

This is a preparation patch to implement the ns-mgmt commands
for file-backed namespaces.

We isolate the identify-ctrl and identify-ns default fields
initialization code into helper functions.

File-backed namespaces can use this code and override
the necessary members of the respective data structures.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 64 ++++++++++++++++++++++++-----------------
 1 file changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 602995f7a1b3..97fea3f1d3e4 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -169,19 +169,11 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
+static void nvmet_identify_ctrl_init(struct nvmet_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
 {
-	struct nvmet_ctrl *ctrl = req->sq->ctrl;
-	struct nvme_id_ctrl *id;
-	u16 status = 0;
 	const char model[] = "Linux";
 
-	id = kzalloc(sizeof(*id), GFP_KERNEL);
-	if (!id) {
-		status = NVME_SC_INTERNAL;
-		goto out;
-	}
-
 	/* XXX: figure out how to assign real vendors IDs. */
 	id->vid = 0;
 	id->ssvid = 0;
@@ -274,32 +266,31 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->psd[0].max_power = cpu_to_le16(0x9c4);
 	id->psd[0].entry_lat = cpu_to_le32(0x10);
 	id->psd[0].exit_lat = cpu_to_le32(0x4);
-
-	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
-
-	kfree(id);
-out:
-	nvmet_req_complete(req, status);
 }
 
-static void nvmet_execute_identify_ns(struct nvmet_req *req)
+static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
-	struct nvmet_ns *ns;
-	struct nvme_id_ns *id;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_id_ctrl *id;
 	u16 status = 0;
 
-	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
-	if (!ns) {
-		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
-		goto out;
-	}
-
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
 		status = NVME_SC_INTERNAL;
-		goto out_put_ns;
+		goto out;
 	}
 
+	nvmet_identify_ctrl_init(ctrl, id);
+
+	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
+
+	kfree(id);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_identify_ns_init(struct nvmet_ns *ns, struct nvme_id_ns *id)
+{
 	/*
 	 * nuse = ncap = nsze isn't always true, but we have no way to find
 	 * that out from the underlying device.
@@ -323,6 +314,27 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	memcpy(&id->nguid, &ns->nguid, sizeof(uuid_le));
 
 	id->lbaf[0].ds = ns->blksize_shift;
+}
+
+static void nvmet_execute_identify_ns(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns;
+	struct nvme_id_ns *id;
+	u16 status = 0;
+
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	id = kzalloc(sizeof(*id), GFP_KERNEL);
+	if (!id) {
+		status = NVME_SC_INTERNAL;
+		goto out_put_ns;
+	}
+
+	nvmet_identify_ns_init(ns, id);
 
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
-- 
2.14.1
