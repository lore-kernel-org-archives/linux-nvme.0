From: sagig@mellanox.com (Sagi Grimberg)
Date: Mon, 16 Nov 2015 11:32:03 +0200
Subject: [PATCH RFC] nvmet: Reference namespaces percpu
Message-ID: <1447666323-16796-1-git-send-email-sagig@mellanox.com>

In order to avoid cross-cpu or cross-socket contention
on our namespaces referencing in the hot path, use the
much more efficient percpu_ref.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
FYI, with this patch applied I'm able to get 95% IOPs
out of nvme_loop comparing to raw null_blk. I'm also
able to survive hot namespace removal during stress IO.

 drivers/nvme/target/core.c  |   38 ++++++++++++++++++++++++++++++++------
 drivers/nvme/target/nvmet.h |    4 +++-
 2 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index dc99909..e2a8893 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -37,16 +37,18 @@ struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
 
 	rcu_read_lock();
 	ns = __nvmet_find_namespace(ctrl, nsid);
-	if (ns && !kref_get_unless_zero(&ns->ref))
-		ns = NULL;
+	if (ns)
+		percpu_ref_get(&ns->ref);
 	rcu_read_unlock();
 
 	return ns;
 }
 
-static void nvmet_destroy_namespace(struct kref *ref)
+static void nvmet_free_ns(struct work_struct *work)
 {
-	struct nvmet_ns *ns = container_of(ref, struct nvmet_ns, ref);
+	struct nvmet_ns *ns = container_of(work, struct nvmet_ns, work);
+
+	percpu_ref_exit(&ns->ref);
 
 	if (ns->bdev)
 		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
@@ -54,9 +56,19 @@ static void nvmet_destroy_namespace(struct kref *ref)
 	kfree(ns);
 }
 
+static void nvmet_destroy_namespace(struct percpu_ref *ref)
+{
+	struct nvmet_ns *ns = container_of(ref, struct nvmet_ns, ref);
+
+	/* Now that we're off the ns list, we can safely kill percpu_ref */
+	percpu_ref_kill(&ns->ref);
+	INIT_WORK(&ns->work, nvmet_free_ns);
+	schedule_work(&ns->work);
+}
+
 void nvmet_put_namespace(struct nvmet_ns *ns)
 {
-	kref_put(&ns->ref, nvmet_destroy_namespace);
+	percpu_ref_put(&ns->ref);
 }
 
 int nvmet_ns_enable(struct nvmet_ns *ns, const char *path)
@@ -109,22 +121,36 @@ void nvmet_ns_free(struct nvmet_ns *ns)
 		list_del_init(&ns->dev_link);
 	mutex_unlock(&subsys->lock);
 
+	/* Should be the final ref! */
 	nvmet_put_namespace(ns);
 }
 
 struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
 {
 	struct nvmet_ns *ns;
+	int ret;
 
 	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
 	if (!ns)
 		return NULL;
 
 	INIT_LIST_HEAD(&ns->dev_link);
-	kref_init(&ns->ref);
+	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
+				0, GFP_KERNEL);
+	if (ret)
+		goto free_ns;
+
+	percpu_ref_get(&ns->ref);
+
 	ns->nsid = nsid;
 	ns->subsys = subsys;
+
 	return ns;
+
+free_ns:
+	kfree(ns);
+
+	return NULL;
 }
 
 void nvmet_req_complete(struct nvmet_req *req, u16 status)
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3903d25..4d7a620 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -5,6 +5,7 @@
 #include <linux/types.h>
 #include <linux/device.h>
 #include <linux/kref.h>
+#include <linux/percpu-refcount.h>
 #include <linux/list.h>
 #include <linux/mutex.h>
 #include <linux/nvme.h>
@@ -13,7 +14,7 @@
 
 struct nvmet_ns {
 	struct list_head	dev_link;
-	struct kref		ref;
+	struct percpu_ref	ref;
 	struct block_device	*bdev;
 	u32			nsid;
 	u32			blksize_shift;
@@ -26,6 +27,7 @@ struct nvmet_ns {
 	struct config_group	default_groups[2];
 	struct config_group	group;
 	struct rcu_head		rcu;
+	struct work_struct	work;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
1.7.1
