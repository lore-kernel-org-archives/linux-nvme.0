From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Tue, 26 Jun 2018 18:32:47 -0400
Subject: [PATCH V3] nvmet: use shared workqueue for file-ns
Message-ID: <20180626223247.2522-1-chaitanya.kulkarni@wdc.com>

This patch removes the per-ns workqueue and adds a global workqueue
which is shared across all the namespaces of multiple subsystems to
offload the I/O submission for buffered I/Os when namespace is
file-backed.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
Changes since V2 :-
1. Change the worqeueue name identifier to "nvmet-buffered-io-wq"
   along with global workqueue variable name from "file_wq" ->
   "buffered_io_wq".
2. Please note that this patch is generated on the top of flush all
   patche series "[PATCH V4 0/2] nvmet: implement flush all support " :-
   http://lists.infradead.org/pipermail/linux-nvme/2018-June/018967.html
   http://lists.infradead.org/pipermail/linux-nvme/2018-June/018965.html
   http://lists.infradead.org/pipermail/linux-nvme/2018-June/018966.html

Changes since V1 :-
1. Don't use per subsys based workqueue, make it global.
---
 drivers/nvme/target/core.c        |  8 ++++++++
 drivers/nvme/target/io-cmd-file.c | 17 +++--------------
 drivers/nvme/target/nvmet.h       |  3 ++-
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4fe474c632f2..5d27c46363b8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -18,6 +18,7 @@
 
 #include "nvmet.h"
 
+struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
@@ -1199,6 +1200,12 @@ static int __init nvmet_init(void)
 {
 	int error;
 
+	buffered_io_wq = alloc_workqueue("nvmet-buffered-io-wq",
+			WQ_MEM_RECLAIM, 0);
+	if (!buffered_io_wq) {
+		error = -ENOMEM;
+		goto out;
+	}
 	error = nvmet_init_discovery();
 	if (error)
 		goto out;
@@ -1219,6 +1226,7 @@ static void __exit nvmet_exit(void)
 	nvmet_exit_configfs();
 	nvmet_exit_discovery();
 	ida_destroy(&cntlid_ida);
+	destroy_workqueue(buffered_io_wq);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index d1c79a3c4f9b..ef8942f0d3d8 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -16,11 +16,8 @@
 void nvmet_file_ns_disable(struct nvmet_ns *ns)
 {
 	if (ns->file) {
-		if (ns->buffered_io) {
-			flush_workqueue(ns->file_wq);
-			destroy_workqueue(ns->file_wq);
-			ns->file_wq = NULL;
-		}
+		if (ns->buffered_io)
+			flush_workqueue(buffered_io_wq);
 		mempool_destroy(ns->bvec_pool);
 		ns->bvec_pool = NULL;
 		kmem_cache_destroy(ns->bvec_cache);
@@ -70,14 +67,6 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 		goto err;
 	}
 
-	if (ns->buffered_io) {
-		ns->file_wq = alloc_workqueue("nvmet-file", WQ_MEM_RECLAIM, 0);
-		if (!ns->file_wq) {
-			ret = -ENOMEM;
-			goto err;
-		}
-	}
-
 	return ret;
 err:
 	ns->size = 0;
@@ -215,7 +204,7 @@ static void nvmet_file_buffered_io_work(struct work_struct *w)
 static void nvmet_file_execute_rw_buffered_io(struct nvmet_req *req)
 {
 	INIT_WORK(&req->work, nvmet_file_buffered_io_work);
-	queue_work(req->ns->file_wq, &req->work);
+	queue_work(buffered_io_wq, &req->work);
 }
 
 void nvmet_file_flush_work(struct work_struct *w)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 48928b1acded..a949f6604152 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -66,7 +66,6 @@ struct nvmet_ns {
 	uuid_t			uuid;
 
 	bool			buffered_io;
-	struct workqueue_struct *file_wq;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
@@ -272,6 +271,8 @@ struct nvmet_req {
 	const struct nvmet_fabrics_ops *ops;
 };
 
+extern struct workqueue_struct *buffered_io_wq;
+
 static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
 {
 	req->rsp->status = cpu_to_le16(status << 1);
-- 
2.17.0
