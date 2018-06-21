From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 21 Jun 2018 17:47:36 -0400
Subject: [PATCH] nvmet: use shared workqueue for file-ns
Message-ID: <20180621214736.6238-1-chaitanya.kulkarni@wdc.com>

This patch removes the per-ns workqueue and adds per-subsys workqueue
which is shared by all the namespaces belongs to the same subsystem to
offload the I/O submission for buffered I/Os for the file-backed namespace.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c        |  7 +++++++
 drivers/nvme/target/io-cmd-file.c | 17 +++--------------
 drivers/nvme/target/nvmet.h       |  2 +-
 3 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 322f7cfc37a4..85cce07e6c39 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1077,6 +1077,12 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
 
+	subsys->file_wq = alloc_workqueue("nvmet-file", WQ_MEM_RECLAIM, 0);
+	if (!subsys->file_wq) {
+		kfree(subsys->subsysnqn);
+		kfree(subsys);
+		return NULL;
+	}
 	return subsys;
 }
 
@@ -1087,6 +1093,7 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
+	destroy_workqueue(subsys->file_wq);
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 16502018fbfd..300a6d9e1e7c 100644
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
+			flush_workqueue(ns->subsys->file_wq);
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
 	INIT_WORK(&req->f.work, nvmet_file_buffered_io_work);
-	queue_work(req->ns->file_wq, &req->f.work);
+	queue_work(req->ns->subsys->file_wq, &req->f.work);
 }
 
 static void nvmet_file_flush_work(struct work_struct *w)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index c4aa54d933f1..5e9273f06133 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -66,7 +66,6 @@ struct nvmet_ns {
 	uuid_t			uuid;
 
 	bool			buffered_io;
-	struct workqueue_struct *file_wq;
 	bool			enabled;
 	struct nvmet_subsys	*subsys;
 	const char		*device_path;
@@ -181,6 +180,7 @@ struct nvmet_subsys {
 	u64			serial;
 	char			*subsysnqn;
 
+	struct workqueue_struct *file_wq;
 	struct config_group	group;
 
 	struct config_group	namespaces_group;
-- 
2.17.0
