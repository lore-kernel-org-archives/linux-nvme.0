From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 12 Dec 2018 15:11:37 -0800
Subject: [PATCH V2 01/12] nvme: remove nvme_common command cdw10 array
In-Reply-To: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
References: <20181212231148.4107-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20181212231148.4107-2-chaitanya.kulkarni@wdc.com>

This is a preparation patch which removes the nvme common command cdw10
array and replace with individual fields. This is needed for the nvmet
error log page implementation make is error log page entry offset
assignment easier.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c        | 18 +++++++++---------
 drivers/nvme/host/trace.h       |  4 ++--
 drivers/nvme/target/admin-cmd.c | 12 ++++++------
 drivers/nvme/target/discovery.c |  4 ++--
 drivers/nvme/target/nvmet.h     |  2 +-
 include/linux/nvme.h            |  7 ++++++-
 6 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f90576862736..090ce8f69ef2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1257,12 +1257,12 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	c.common.nsid = cpu_to_le32(cmd.nsid);
 	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
 	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
-	c.common.cdw10[0] = cpu_to_le32(cmd.cdw10);
-	c.common.cdw10[1] = cpu_to_le32(cmd.cdw11);
-	c.common.cdw10[2] = cpu_to_le32(cmd.cdw12);
-	c.common.cdw10[3] = cpu_to_le32(cmd.cdw13);
-	c.common.cdw10[4] = cpu_to_le32(cmd.cdw14);
-	c.common.cdw10[5] = cpu_to_le32(cmd.cdw15);
+	c.common.cdw10 = cpu_to_le32(cmd.cdw10);
+	c.common.cdw11 = cpu_to_le32(cmd.cdw11);
+	c.common.cdw12 = cpu_to_le32(cmd.cdw12);
+	c.common.cdw13 = cpu_to_le32(cmd.cdw13);
+	c.common.cdw14 = cpu_to_le32(cmd.cdw14);
+	c.common.cdw15 = cpu_to_le32(cmd.cdw15);
 
 	if (cmd.timeout_ms)
 		timeout = msecs_to_jiffies(cmd.timeout_ms);
@@ -1625,7 +1625,7 @@ static int nvme_pr_command(struct block_device *bdev, u32 cdw10,
 	memset(&c, 0, sizeof(c));
 	c.common.opcode = op;
 	c.common.nsid = cpu_to_le32(ns->head->ns_id);
-	c.common.cdw10[0] = cpu_to_le32(cdw10);
+	c.common.cdw10 = cpu_to_le32(cdw10);
 
 	ret = nvme_submit_sync_cmd(ns->queue, &c, data, 16);
 	nvme_put_ns_from_disk(head, srcu_idx);
@@ -1699,8 +1699,8 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 	else
 		cmd.common.opcode = nvme_admin_security_recv;
 	cmd.common.nsid = 0;
-	cmd.common.cdw10[0] = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
-	cmd.common.cdw10[1] = cpu_to_le32(len);
+	cmd.common.cdw10 = cpu_to_le32(((u32)secp) << 24 | ((u32)spsp) << 8);
+	cmd.common.cdw11 = cpu_to_le32(len);
 
 	return __nvme_submit_sync_cmd(ctrl->admin_q, &cmd, NULL, buffer, len,
 				      ADMIN_TIMEOUT, NVME_QID_ANY, 1, 0);
diff --git a/drivers/nvme/host/trace.h b/drivers/nvme/host/trace.h
index 196d5bd56718..1978deb6fcc7 100644
--- a/drivers/nvme/host/trace.h
+++ b/drivers/nvme/host/trace.h
@@ -115,8 +115,8 @@ TRACE_EVENT(nvme_setup_cmd,
 		__entry->nsid = le32_to_cpu(cmd->common.nsid);
 		__entry->metadata = le64_to_cpu(cmd->common.metadata);
 		__assign_disk_name(__entry->disk, req->rq_disk);
-		memcpy(__entry->cdw10, cmd->common.cdw10,
-		       sizeof(__entry->cdw10));
+		memcpy(__entry->cdw10, &cmd->common.cdw10,
+			6 * sizeof(__entry->cdw10));
 	    ),
 	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
 		      __entry->ctrl_id, __print_disk_name(__entry->disk),
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 753515fc8028..721b041a6b3b 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -557,7 +557,7 @@ static u16 nvmet_write_protect_flush_sync(struct nvmet_req *req)
 
 static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 {
-	u32 write_protect = le32_to_cpu(req->cmd->common.cdw10[1]);
+	u32 write_protect = le32_to_cpu(req->cmd->common.cdw11);
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
 	u16 status = NVME_SC_FEATURE_NOT_CHANGEABLE;
 
@@ -589,7 +589,7 @@ static u16 nvmet_set_feat_write_protect(struct nvmet_req *req)
 
 u16 nvmet_set_feat_kato(struct nvmet_req *req)
 {
-	u32 val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
 	req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 
@@ -600,7 +600,7 @@ u16 nvmet_set_feat_kato(struct nvmet_req *req)
 
 u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 {
-	u32 val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+	u32 val32 = le32_to_cpu(req->cmd->common.cdw11);
 
 	if (val32 & ~mask)
 		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
@@ -614,7 +614,7 @@ u16 nvmet_set_feat_async_event(struct nvmet_req *req, u32 mask)
 static void nvmet_execute_set_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
 	switch (cdw10 & 0xff) {
@@ -675,7 +675,7 @@ void nvmet_get_feat_async_event(struct nvmet_req *req)
 static void nvmet_execute_get_features(struct nvmet_req *req)
 {
 	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
-	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 status = 0;
 
 	switch (cdw10 & 0xff) {
@@ -715,7 +715,7 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_HOST_ID:
 		/* need 128-bit host identifier flag */
-		if (!(req->cmd->common.cdw10[1] & cpu_to_le32(1 << 0))) {
+		if (!(req->cmd->common.cdw11 & cpu_to_le32(1 << 0))) {
 			status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
 			break;
 		}
diff --git a/drivers/nvme/target/discovery.c b/drivers/nvme/target/discovery.c
index 4d8757ae8210..e1bb254671de 100644
--- a/drivers/nvme/target/discovery.c
+++ b/drivers/nvme/target/discovery.c
@@ -247,7 +247,7 @@ static void nvmet_execute_identify_disc_ctrl(struct nvmet_req *req)
 
 static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 {
-	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat;
 
 	switch (cdw10 & 0xff) {
@@ -268,7 +268,7 @@ static void nvmet_execute_disc_set_features(struct nvmet_req *req)
 
 static void nvmet_execute_disc_get_features(struct nvmet_req *req)
 {
-	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
 	u16 stat = 0;
 
 	switch (cdw10 & 0xff) {
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 89df51ee5bdf..dafee1af4829 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -349,7 +349,7 @@ struct nvmet_async_event {
 
 static inline void nvmet_clear_aen_bit(struct nvmet_req *req, u32 bn)
 {
-	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
+	int rae = le32_to_cpu(req->cmd->common.cdw10) & 1 << 15;
 
 	if (!rae)
 		clear_bit(bn, &req->sq->ctrl->aen_masked);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 4d7907e3771e..b94fe8fadc4f 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -662,7 +662,12 @@ struct nvme_common_command {
 	__le32			cdw2[2];
 	__le64			metadata;
 	union nvme_data_ptr	dptr;
-	__le32			cdw10[6];
+	__le32			cdw10;
+	__le32			cdw11;
+	__le32			cdw12;
+	__le32			cdw13;
+	__le32			cdw14;
+	__le32			cdw15;
 };
 
 struct nvme_rw_command {
-- 
2.17.0
