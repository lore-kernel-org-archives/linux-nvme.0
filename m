From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 31 May 2018 10:07:00 -0400
Subject: [PATCH V2] nvmet: allow file backed ns to use cache
Message-ID: <20180531140700.13708-1-chaitanya.kulkarni@wdc.com>

This is an incremental patch based on adding support for file backed
namespaces over NVMeOF target:-

http://lists.infradead.org/pipermail/linux-nvme/2018-May/017775.html/
http://lists.infradead.org/pipermail/linux-nvme/2018-May/017777.html.

We introduce "buffered_io" a new target namespace attribute. In default
execution, we set "buffered_io" to false, use O_DIRECT flag when opening
backend file and IOCB_DIRECT flag when submitting I/Os. Once user set
the "buffered_io" ns attribute through configfs, we disable and enable
target namespace by calling nvmet_ns_[ enable | disable ] () in order
to set appropriate flags for file operations i.e. we don't use
O_DIRECT and IOCB_DIRECT flags for respective operations.

In order to handle Read/Write requests when "buffered_io" is set we
introduce per namespace workqueue. For NVMe flush command we also flush
this workqueue conditionally before we schedule flush work.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V1:-

1. Rename "vwc" parameter to "buffered_io" and get rid of co-relation
   between NVMe Volatile Write Cache and buffered I/O mode.
---
 drivers/nvme/target/configfs.c    | 27 +++++++++++++++++++++++++
 drivers/nvme/target/core.c        |  1 +
 drivers/nvme/target/io-cmd-file.c | 42 +++++++++++++++++++++++++++++++++++----
 drivers/nvme/target/nvmet.h       |  2 ++
 4 files changed, 68 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index ad9ff27..df0e6f4 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -403,11 +403,38 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 
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
+	if (ns->file && ns->buffered_io != buffered_io) {
+		nvmet_ns_disable(ns);
+		ns->buffered_io = buffered_io;
+		ret = nvmet_ns_enable(ns);
+	}
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
index 800aaf9..12da8cf 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -391,6 +391,7 @@ struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 	ns->nsid = nsid;
 	ns->subsys = subsys;
 	uuid_gen(&ns->uuid);
+	ns->buffered_io = false;
 
 	return ns;
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ca1ccf8..3cebc0a 100644
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
@@ -27,11 +32,11 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
-	int ret;
+	int flags = O_RDWR | O_LARGEFILE | ns->buffered_io ? 0 : O_DIRECT;
 	struct kstat stat;
+	int ret;
 
-	ns->file = filp_open(ns->device_path,
-			O_RDWR | O_LARGEFILE | O_DIRECT, 0);
+	ns->file = filp_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
 		pr_err("failed to open file %s: (%ld)\n",
 				ns->device_path, PTR_ERR(ns->bdev));
@@ -58,6 +63,15 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	if (!ns->bvec_pool)
 		goto err;
 
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
@@ -97,6 +111,7 @@ static ssize_t nvmet_file_submit_bvec(struct nvmet_req *req, loff_t pos,
 	iocb->ki_pos = pos;
 	iocb->ki_filp = req->ns->file;
 	iocb->ki_flags = IOCB_DIRECT | ki_flags;
+	iocb->ki_flags = ki_flags | req->ns->buffered_io ? 0 : IOCB_DIRECT;
 
 	ret = call_iter(iocb, &iter);
 
@@ -185,6 +200,19 @@ static void nvmet_file_execute_rw(struct nvmet_req *req)
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
@@ -197,6 +225,9 @@ static void nvmet_file_flush_work(struct work_struct *w)
 
 static void nvmet_file_execute_flush(struct nvmet_req *req)
 {
+	if (req->ns->buffered_io)
+		flush_workqueue(req->ns->file_wq);
+
 	INIT_WORK(&req->f.work, nvmet_file_flush_work);
 	schedule_work(&req->f.work);
 }
@@ -276,7 +307,10 @@ u16 nvmet_file_parse_io_cmd(struct nvmet_req *req)
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
index 2d09afc..636eb76 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -50,6 +50,8 @@ struct nvmet_ns {
 	u8			nguid[16];
 	uuid_t			uuid;
 
+	bool			buffered_io;
+	struct workqueue_struct *file_wq;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
-- 
2.9.5
