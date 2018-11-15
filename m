From: hch@lst.de (Christoph Hellwig)
Date: Thu, 15 Nov 2018 12:40:05 +0100
Subject: [PATCH v3 1/4] nvmet: support fabrics sq flow control
In-Reply-To: <20181114182534.28807-2-sagi@grimberg.me>
References: <20181114182534.28807-1-sagi@grimberg.me>
 <20181114182534.28807-2-sagi@grimberg.me>
Message-ID: <20181115114005.GA16759@lst.de>

>  complete:
>  	nvmet_req_complete(req, status);
> +	if (req->sq->sqhd_disabled)
> +		req->sq->sqhd = 0;

We drop the sq ref in nvmet_req_complete, so this introduces a
use-after-free.  What about this variant instead:

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e3e158ff207a..74e253eb873f 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -597,25 +597,29 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	return ns;
 }
 
-static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
+static void nvmet_update_sq_head(struct nvmet_req *req)
 {
-	u32 old_sqhd, new_sqhd;
-	u16 sqhd;
-
-	if (status)
-		nvmet_set_status(req, status);
-
 	if (req->sq->size) {
+		u32 old_sqhd, new_sqhd;
+
 		do {
 			old_sqhd = req->sq->sqhd;
 			new_sqhd = (old_sqhd + 1) % req->sq->size;
 		} while (cmpxchg(&req->sq->sqhd, old_sqhd, new_sqhd) !=
 					old_sqhd);
 	}
-	sqhd = req->sq->sqhd & 0x0000FFFF;
-	req->rsp->sq_head = cpu_to_le16(sqhd);
+
+	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd & 0x0000FFFF);
+}
+
+static void __nvmet_req_complete(struct nvmet_req *req, u16 status)
+{
+	if (!req->sq->sqhd_disabled)
+		nvmet_update_sq_head(req);
 	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
 	req->rsp->command_id = req->cmd->common.command_id;
+	if (status)
+		nvmet_set_status(req, status);
 
 	if (req->ns)
 		nvmet_put_namespace(req->ns);
@@ -765,6 +769,7 @@ bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
 	req->sg_cnt = 0;
 	req->transfer_len = 0;
 	req->rsp->status = 0;
+	req->rsp->sq_head = 0;
 	req->ns = NULL;
 
 	/* no support for fused commands yet */
diff --git a/drivers/nvme/target/fabrics-cmd.c b/drivers/nvme/target/fabrics-cmd.c
index d84ae004cb85..328ae46d8344 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -115,6 +115,12 @@ static u16 nvmet_install_queue(struct nvmet_ctrl *ctrl, struct nvmet_req *req)
 	/* note: convert queue size from 0's-based value to 1's-based value */
 	nvmet_cq_setup(ctrl, req->cq, qid, sqsize + 1);
 	nvmet_sq_setup(ctrl, req->sq, qid, sqsize + 1);
+
+	if (c->cattr & NVME_CONNECT_DISABLE_SQFLOW) {
+		req->sq->sqhd_disabled = true;
+		req->rsp->sq_head = cpu_to_le16(0xffff);
+	}
+
 	return 0;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 31474940e373..ab8e68966e73 100644
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
