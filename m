From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:08 -0400
Subject: [PATCH 17/20] nvmet: override identify for file backed ns
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-18-chaitanya.kulkarni@wdc.com>

Update identify ctrl/ns to initialize file backed namespaces fields.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 75 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 75 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index b60477c50880..19b93952bd16 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -319,11 +319,39 @@ static void nvmet_identify_ctrl_init(struct nvmet_ctrl *ctrl,
 	id->psd[0].exit_lat = cpu_to_le32(0x4);
 }
 
+static u16 nvmet_identify_ctrl_init_file(struct nvmet_req *req,
+		struct nvme_id_ctrl *id)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_subsys *subsys = ctrl->subsys;
+	struct kstatfs fsstat;
+	__le64 tnvmcap;
+	__le64 unvmcap;
+	u16 status = NVME_SC_SUCCESS;
+
+	if (nvmet_vfs_statfs(subsys->mount_path, &fsstat)) {
+		status = NVME_SC_INTERNAL | NVME_SC_DNR;
+		goto out;
+	}
+
+	id->oacs = 1 << 3; /* we support namespace management */
+
+	tnvmcap = cpu_to_le64(fsstat.f_blocks * fsstat.f_bsize);
+	memcpy(id->tnvmcap, &tnvmcap, sizeof(tnvmcap));
+
+	unvmcap = cpu_to_le64(fsstat.f_bfree * fsstat.f_bsize);
+	memcpy(id->unvmcap, &tnvmcap, sizeof(unvmcap));
+
+out:
+	return status;
+}
+
 static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 {
 	struct nvmet_ctrl *ctrl = req->sq->ctrl;
 	struct nvme_id_ctrl *id;
 	u16 status = 0;
+	u16 file_status = 0;
 
 	id = kzalloc(sizeof(*id), GFP_KERNEL);
 	if (!id) {
@@ -333,8 +361,14 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	nvmet_identify_ctrl_init(ctrl, id);
 
+	if (req->sq->ctrl->subsys->mount_path)
+		file_status = nvmet_identify_ctrl_init_file(req, id);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
+	if (req->sq->ctrl->subsys->mount_path && file_status)
+		status = file_status;
+
 	kfree(id);
 out:
 	nvmet_req_complete(req, status);
@@ -367,11 +401,46 @@ static void nvmet_identify_ns_init(struct nvmet_ns *ns, struct nvme_id_ns *id)
 	id->lbaf[0].ds = ns->blksize_shift;
 }
 
+static int nvmet_identify_ns_file_stats(struct nvmet_ns *ns,
+		struct nvme_id_ns *id)
+{
+	u64 alloc_blk;
+	u64 blk_size = (1 << ns->blksize_shift);
+	struct kstat stat;
+	__le64 size;
+
+	if (nvmet_vfs_stat(ns->device_path, &stat))
+		return -1;
+
+	alloc_blk = DIV_ROUND_UP((stat.blocks * (1 << 9)), blk_size);
+
+	id->nsze = cpu_to_le64(DIV_ROUND_UP(stat.size, blk_size));
+	id->ncap = id->nuse = cpu_to_le64(alloc_blk);
+
+	memcpy(id->nvmcap, &size, sizeof(size));
+
+	return 0;
+}
+
+static int nvmet_identify_ns_init_file(struct nvmet_ns *ns,
+		struct nvme_id_ns *id)
+{
+	int ret;
+
+	ret = nvmet_identify_ns_file_stats(ns, id);
+	if (ret)
+		return NVME_SC_INVALID_NS;
+
+	id->nsfeat = 1 << 0;
+	return 0;
+}
+
 static void nvmet_execute_identify_ns(struct nvmet_req *req)
 {
 	struct nvmet_ns *ns;
 	struct nvme_id_ns *id;
 	u16 status = 0;
+	u16 file_status = 0;
 
 	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
 	if (!ns) {
@@ -387,8 +456,14 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 
 	nvmet_identify_ns_init(ns, id);
 
+	if (req->sq->ctrl->subsys->mount_path)
+		file_status = nvmet_identify_ns_init_file(ns, id);
+
 	status = nvmet_copy_to_sgl(req, 0, id, sizeof(*id));
 
+	if (req->sq->ctrl->subsys->mount_path && file_status)
+		status = file_status;
+
 	kfree(id);
 out_put_ns:
 	nvmet_put_namespace(ns);
-- 
2.14.1
