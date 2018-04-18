From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:07 -0400
Subject: [PATCH 16/20] nvmet: add ns-mgmt command handlers
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-17-chaitanya.kulkarni@wdc.com>

Add ns-mgmt command handlers for file-backed ns. We use
previously initialize target subsystems "mount_path"
to manage the file backed namespaces.

The host can issue nvme-create ns commands to create a file
backed namespace on the target side under mount_path.
e.g.

nvme create-ns /dev/nvme1 --nsze=204800 --ncap=204800 --flbas=9

The above command will create and initialize the namespace
on the target side. It will use --flbas value as a power of 2
exponent to determine the block size. The total size of the file
will be calculated as a combination of the flbas and nsze value.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 169 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 169 insertions(+)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index e696f1e45e3a..b60477c50880 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -613,6 +613,166 @@ static void nvmet_execute_keep_alive(struct nvmet_req *req)
 	nvmet_req_complete(req, 0);
 }
 
+static int nvmet_create_ns_path_file(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns = req->ns;
+	int ret = 0;
+	char *mount_point = req->sq->ctrl->subsys->mount_path;
+	int cntlid = req->sq->ctrl->cntlid;
+	char *ns_path;
+	int flags = O_RDWR | O_LARGEFILE | O_DIRECT | O_CREAT;
+	int alloc = FALLOC_FL_ZERO_RANGE;
+	int holes = FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE;
+	loff_t start;
+
+	ns_path = kzalloc(PATH_MAX, GFP_KERNEL);
+	if (!ns_path) {
+		ns->device_path = NULL;
+		return -ENOMEM;
+	}
+
+	snprintf(ns_path, PATH_MAX, "%s/nvme%dn%d", mount_point,
+			cntlid, ns->nsid);
+	ns->device_path = kstrdup(ns_path, GFP_KERNEL);
+
+	ns->filp = filp_open(ns->device_path, flags, 0);
+	if (!ns->filp || IS_ERR(ns->filp)) {
+		pr_err("failed to open file %s: (%ld)\n",
+				ns->device_path, PTR_ERR(ns->filp));
+		ns->filp = NULL;
+		ret = -1;
+		goto out;
+	}
+
+	ns->size = ns->nsze * (1 << ns->flbas);
+	ret = vfs_fallocate(ns->filp, alloc, 0, ns->size);
+	if (ret) {
+		pr_err("failed to allocate ns %s: size %llu (%d)\n",
+				ns->device_path, ns->size, ret);
+		goto close_file;
+	}
+
+	start = ns->ncap * (1 << ns->flbas);
+	ret = vfs_fallocate(ns->filp, holes, start, ns->size);
+	if (ret) {
+		pr_err("failed to punch holes ns %s: size %llu (%d)\n",
+				ns->device_path, ns->size, ret);
+		goto close_file;
+	}
+	/* everything is okay we can close the file now */
+close_file:
+	filp_close(req->ns->filp, NULL);
+out:
+	kfree(ns_path);
+	return ret;
+}
+
+static u16 nvmet_delete_ns_file_path(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns = req->ns;
+	int ret;
+	u16 status = NVME_SC_SUCCESS;
+	struct dentry *ns_dentry;
+	struct path parent_path;
+
+	ns_dentry = kern_path_locked(ns->device_path, &parent_path);
+	if (IS_ERR(ns_dentry)) {
+		pr_err("failed to get dentry %ld\n",
+				PTR_ERR(ns_dentry));
+
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto err;
+	}
+	ret = vfs_unlink(d_inode(parent_path.dentry),
+			ns_dentry, NULL);
+	if (ret) {
+		pr_err("vfs_unlink() failed %d\n", ret);
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+	}
+	dput(ns_dentry);
+err:
+	inode_unlock(d_inode(parent_path.dentry));
+	path_put(&parent_path);
+
+	return status;
+}
+
+static u16 nvmet_create_ns_file(struct nvmet_req *req)
+{
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvme_id_ns *id;
+
+	id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
+	if (!id)
+		goto out;
+
+	nvmet_copy_from_sgl(req, 0, id, sizeof(*id));
+	req->ns = nvmet_ns_alloc(subsys, nvmet_get_next_nsid(subsys));
+	if (!req->ns)
+		goto err;
+
+	req->ns->nsze = le64_to_cpu(id->nsze);
+	req->ns->ncap = le64_to_cpu(id->ncap);
+	req->ns->nuse = le64_to_cpu(id->nuse);
+	req->ns->flbas = id->flbas == 0 ? 9 : le64_to_cpu(id->flbas);
+
+	if (nvmet_create_ns_path_file(req))
+		goto ns_free;
+
+	if (nvmet_ns_enable(req->ns)) {
+		nvmet_delete_ns_file_path(req);
+		goto ns_free;
+	}
+
+	nvmet_set_result(req, req->ns->nsid);
+	return NVME_SC_SUCCESS;
+
+ns_free:
+	kfree(req->ns->device_path);
+	req->ns->device_path = NULL;
+	kfree(req->ns);
+	req->ns = NULL;
+err:
+	kfree(id);
+out:
+	return NVME_SC_INTERNAL | NVME_SC_DNR;
+}
+
+static u16 nvmet_delete_ns_file(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (unlikely(!req->ns)) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	nvmet_free_nsid(req->sq->ctrl->subsys, req->ns->nsid);
+
+	nvmet_ns_disable(req->ns);
+
+	status = nvmet_delete_ns_file_path(req);
+	kfree(req->ns->device_path);
+	req->ns->device_path = NULL;
+	kfree(req->ns);
+	req->ns = NULL;
+out:
+	return status;
+}
+
+static void nvmet_execute_ns_mgmt_file(struct nvmet_req *req)
+{
+	u16 status;
+
+	if (req->cmd->common.cdw10[0] == 0)
+		status = nvmet_create_ns_file(req);
+	else
+		status = nvmet_delete_ns_file(req);
+
+	nvmet_req_complete(req, status);
+}
+
 u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 {
 	struct nvme_command *cmd = req->cmd;
@@ -673,6 +833,15 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		req->execute = nvmet_execute_keep_alive;
 		req->data_len = 0;
 		return 0;
+	case nvme_admin_ns_mgmt:
+		if (req->sq->ctrl->subsys->mount_path) {
+			req->execute = nvmet_execute_ns_mgmt_file;
+			req->data_len = 0;
+			if (cmd->common.cdw10[0] == 0)
+				req->data_len = NVME_IDENTIFY_DATA_SIZE;
+			return 0;
+		}
+		/* fall thru */
 	}
 
 	pr_err("unhandled cmd %d on qid %d\n", cmd->common.opcode,
-- 
2.14.1
