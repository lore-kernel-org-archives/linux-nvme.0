From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 20 Jun 2018 00:01:41 -0400
Subject: [PATCH V4] nvmet: add buffered I/O support for file backed ns
Message-ID: <20180620040141.9553-1-chaitanya.kulkarni@wdc.com>

This is an incremental patch based on adding support for file backed
namespaces for NVMeOF target:-

http://lists.infradead.org/pipermail/linux-nvme/2018-May/017775.html/
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017777.html.

We introduce "buffered_io" a new target namespace attribute. In default
execution, we set "buffered_io" to false, use O_DIRECT flag when opening
backend file and set the appropriate direct I/O flags when submitting
I/Os. In order to switch between the modes user needs to disable
namespace through configfs and then set the value of the "buffered_io".
This new value will have an effect after namespace is enabled manually.

In order to handle Read/Write requests when "buffered_io" is set we
introduce per namespace workqueue.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V3 :-
1. Remove transparent mode switch and allow to switch the buffered
   and direct I/O mode only when ns is disabled manually.
2. Change the patch title.

Changes since V2 :-
1. Add support for transparent mode switch between buffered and
   direct I/O.

Changes since V1 :-
1. Rename the "vwc" namespace configfs attribute to the "buffered_io". 
---
 drivers/nvme/target/configfs.c    | 30 +++++++++++++++++++++
 drivers/nvme/target/core.c        |  1 +
 drivers/nvme/target/io-cmd-file.c | 43 +++++++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 71 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d3f3b3ec4d1a..3c06c517f009 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -407,11 +407,41 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_ns_, enable);
 
+static ssize_t nvmet_ns_buffered_io_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->buffered_io);
+}
+
+static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool buffered_io;
+	int ret = 0;
+
+	if (strtobool(page, &buffered_io))
+		return -EINVAL;
+
+	mutex_unlock(&ns->subsys->lock);
+	if (ns->enabled == false)
+		ns->buffered_io = buffered_io;
+	else {
+		pr_err("disable ns before setting buffered_io value.\n");
+		ret = -EINVAL;
+	}
+	mutex_unlock(&ns->subsys->lock);
+
+	return ret ? ret : count;
+}
+
+CONFIGFS_ATTR(nvmet_ns_, buffered_io);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
 	&nvmet_ns_attr_device_uuid,
 	&nvmet_ns_attr_enable,
+	&nvmet_ns_attr_buffered_io,
 	NULL,
 };
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index a03da764ecae..2888ed6d8665 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -437,6 +437,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
+	ns->buffered_io = false;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 8c42b3a8c420..09d793442833 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -16,6 +16,11 @@
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->file) {
+		if (ns->buffered_io) {
+			flush_workqueue(ns->file_wq);
+			destroy_workqueue(ns->file_wq);
+			ns->file_wq = NULL;
+		}
 		mempool_destroy(ns->bvec_pool);
 		ns->bvec_pool = NULL;
 		kmem_cache_destroy(ns->bvec_cache);
@@ -27,11 +32,14 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
-	int ret;
+	int flags = O_RDWR | O_LARGEFILE;
 	struct kstat stat;
+	int ret;
+
+	if (!ns->buffered_io)
+		flags |= O_DIRECT;
 
-	ns->file = filp_open(ns->device_path,
-			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
+	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->file));
@@ -62,6 +70,15 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 	}
 
+	if (ns->buffered_io) {
+		ns->file_wq = alloc_workqueue("nvmet-file",
+				WQ_UNBOUND_MAX_ACTIVE | WQ_MEM_RECLAIM, 0);
+		if (!ns->file_wq) {
+			ret = -ENOMEM;
+			goto err;
+		}
+	}
+
 	return ret;
 err:
 	ns->size = 0;
@@ -100,7 +117,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
-	iocb->ki_flags = IOCB_DIRECT | ki_flags;
+	iocb->ki_flags = ki_flags | iocb_flags(req->ns->file);
 
 	ret = call_iter(iocb, &iter);
 
@@ -189,6 +206,19 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
 	nvmet_file_submit_bvec(req, pos, bv_cnt, total_len);
 }
 
+static void nvmet_file_buffered_io_work(struct work_struct *w)
+{
+	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
+
+	nvmet_file_execute_rw(req);
+}
+
+static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
+{
+	INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
+	queue_work(req->ns->file_wq, &req->f.work);
+}
+
 static void nvmet_file_flush_work(struct work_struct *w)
 {
 	struct nvmet_req *req = container_of(w, struct nvmet_req, f.work);
@@ -280,7 +310,10 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
 	switch (cmd->common.opcode) {
 	case nvme_cmd_read:
 	case nvme_cmd_write:
-		req->execute = nvmet_file_execute_rw;
+		if (!req->ns->buffered_io)
+			req->execute = nvmet_file_execute_rw;
+		else
+			req->execute = nvmet_file_execute_rw_buffered_io;
 		req->data_len = nvmet_rw_len(req);
 		return 0;
 	case nvme_cmd_flush:
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 480dfe10fad9..c4aa54d933f1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -65,6 +65,8 @@ struct nvmet_ns {
 	u8			nguid[16];
 	uuid_t			uuid;
 
+	bool			buffered_io;
+	struct workqueue_struct *file_wq;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
-- 
2.17.0
