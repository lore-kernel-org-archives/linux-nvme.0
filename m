From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:09 -0400
Subject: [PATCH 18/20] nvmet: allow host to configure sync vs direct IO
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-19-chaitanya.kulkarni@wdc.com>

Add support to switch between O_SYNC and O_DIRECT.
We use NVMe Feature Volatile write cache field to toggle between
the two modes.

This also replaces existing mechanism of using the previously
added sync configfs namespaces attribute and allow the host to
switch between the modes.

The newly introduced field vwc is set when host side issues
nvme-set-feature for configuring the volatile write cache and
passed to each namespace.

At the time of initialization of the namespace we use the
subsystem vwc to initialize namespace vwc, having vwc
field in the target ns will allow implementing per namespace
vwc configuration in future.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 54 +++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/configfs.c  | 27 ---------------------
 drivers/nvme/target/core.c      |  8 +++---
 drivers/nvme/target/io-cmd.c    |  4 +--
 drivers/nvme/target/nvmet.h     |  6 ++++-
 5 files changed, 65 insertions(+), 34 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 19b93952bd16..b119a31eb6f9 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -836,6 +836,56 @@ static u16 nvmet_delete_ns_file(struct nvmet_req *req)
 	return status;
 }
 
+static void nvmet_set_features_vwc_file(struct nvmet_req *req)
+{
+	u16 status = NVME_SC_SUCCESS;
+	struct nvmet_ns *ns;
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+
+	if (subsys->vwc != le32_to_cpu(req->cmd->features.dword11)) {
+		subsys->vwc = le32_to_cpu(req->cmd->features.dword11);
+		mutex_lock(&subsys->lock);
+		list_for_each_entry_rcu(ns, &subsys->namespaces, dev_link) {
+			percpu_ref_get(&ns->ref);
+			mutex_unlock(&subsys->lock);
+			if (ns->vwc != subsys->vwc) {
+				/* improve error handling here */
+				nvmet_ns_disable(ns);
+				ns->vwc = subsys->vwc;
+				nvmet_ns_enable(ns);
+			}
+			mutex_lock(&subsys->lock);
+			percpu_ref_put(&ns->ref);
+		}
+		mutex_unlock(&subsys->lock);
+	}
+
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_set_features_file(struct nvmet_req *req)
+{
+	switch (le32_to_cpu(req->cmd->features.fid)) {
+	case NVME_FEAT_VOLATILE_WC:
+		nvmet_set_features_vwc_file(req);
+		break;
+	default:
+		nvmet_execute_set_features(req);
+	}
+}
+
+static void nvmet_execute_get_features_file(struct nvmet_req *req)
+{
+	switch (le32_to_cpu(req->cmd->features.fid)) {
+	case NVME_FEAT_VOLATILE_WC:
+		nvmet_set_result(req, req->sq->ctrl->subsys->vwc);
+		nvmet_req_complete(req, 0);
+		break;
+	default:
+		nvmet_execute_get_features(req);
+	}
+}
+
 static void nvmet_execute_ns_mgmt_file(struct nvmet_req *req)
 {
 	u16 status;
@@ -894,10 +944,14 @@ u16 nvmet_parse_admin_cmd(struct nvmet_req *req)
 		return 0;
 	case nvme_admin_set_features:
 		req->execute = nvmet_execute_set_features;
+		if (req->sq->ctrl->subsys->mount_path)
+			req->execute = nvmet_execute_set_features_file;
 		req->data_len = 0;
 		return 0;
 	case nvme_admin_get_features:
 		req->execute = nvmet_execute_get_features;
+		if (req->sq->ctrl->subsys->mount_path)
+			req->execute = nvmet_execute_get_features_file;
 		req->data_len = 0;
 		return 0;
 	case nvme_admin_async_event:
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index f571dffbecdc..152d180af94b 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -407,38 +407,11 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, enable);
 
-static ssize_t nvmet_ns_sync_show(struct config_item *item, char *page)
-{
-	return sprintf(page, "%d\n", to_nvmet_ns(item)->sync);
-}
-
-static ssize_t nvmet_ns_sync_store(struct config_item *item,
-		const char *page, size_t count)
-{
-	struct nvmet_ns *ns = to_nvmet_ns(item);
-	bool sync;
-	int ret = 0;
-
-	if (strtobool(page, &sync))
-		return -EINVAL;
-
-	if (ns->filp && ns->sync != sync) {
-		nvmet_ns_disable(ns);
-		ns->sync = sync;
-		ret = nvmet_ns_enable(ns);
-	}
-
-	return ret ? ret : count;
-}
-
-CONFIGFS_ATTR(nvmet_ns_, sync);
-
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
-	&nvmet_ns_attr_sync,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 0b0649dc705c..36f0dacec042 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -295,7 +295,7 @@ static int nvmet_ns_enable_file(struct nvmet_ns *ns)
 	int flags = O_RDWR | O_LARGEFILE;
 	struct kstat stat;
 
-	flags |= ns->sync ? O_SYNC : O_DIRECT;
+	flags |= ns->vwc ? O_SYNC : O_DIRECT;
 	ns->filp = filp_open(ns->device_path, flags, 0);
 	if (!ns->filp || IS_ERR(ns->filp)) {
 		pr_err("failed to open file %s: (%ld)\n",
@@ -311,7 +311,7 @@ static int nvmet_ns_enable_file(struct nvmet_ns *ns)
 	ns->size = stat.size;
 	ns->blksize_shift = ns->filp->f_inode->i_blkbits;
 
-	if (ns->sync) {
+	if (ns->vwc) {
 		ns->file_wq = alloc_workqueue("nvmet-file",
 				WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
 
@@ -349,7 +349,7 @@ static void nvmet_ns_dev_disable(struct nvmet_ns *ns)
 		blkdev_put(ns->bdev, FMODE_WRITE | FMODE_READ);
 		ns->bdev = NULL;
 	} else if (ns->filp) {
-		if (ns->sync) {
+		if (ns->vwc) {
 			flush_workqueue(ns->file_wq);
 			destroy_workqueue(ns->file_wq);
 			ns->file_wq = NULL;
@@ -472,7 +472,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
-	ns->sync = false;
+	ns->vwc = subsys->vwc;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 6d355b2dac56..96bb17353a29 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -108,7 +108,7 @@ static void nvmet_execute_rw_file(struct nvmet_req *req)
 	struct sg_mapping_iter miter;
 	loff_t pos;
 	ssize_t len = 0, ret;
-	int ki_flags = req->ns->sync ? IOCB_SYNC : IOCB_DIRECT;
+	int ki_flags = req->ns->vwc ? IOCB_SYNC : IOCB_DIRECT;
 	int bv_cnt = 0, rw = READ;
 
 	if (req->cmd->rw.opcode == nvme_cmd_write) {
@@ -348,7 +348,7 @@ u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 	case nvme_cmd_read:
 	case nvme_cmd_write:
 		if (req->ns->filp) {
-			if (req->ns->sync) {
+			if (req->ns->vwc) {
 				req->execute = nvmet_execute_rw_sync_file;
 				INIT_WORK(&req->sync_work,
 						nvmet_sync_work_file);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index a365dc44a10e..acb9c266573b 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -53,7 +53,6 @@ struct nvmet_ns {
 	uuid_t			uuid;
 
 	bool			enabled;
-	bool			sync;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
 
@@ -61,6 +60,8 @@ struct nvmet_ns {
 	u64			ncap;
 	u64			nuse;
 	u8			flbas;
+	u8			vwc;
+
 	struct workqueue_struct *file_wq;
 	struct config_group	device_group;
 	struct config_group	group;
@@ -169,6 +170,9 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+
+
+	u8			vwc;
 	char			*mount_path;
 	unsigned long		nsid_map[1024]; /* MAX LIMIT ? */
 };
-- 
2.14.1
