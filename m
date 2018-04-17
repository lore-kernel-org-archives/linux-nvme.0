From: keith.busch@intel.com (Keith Busch)
Date: Tue, 17 Apr 2018 16:03:44 -0600
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
Message-ID: <20180417220344.14698-1-keith.busch@intel.com>

When CONFIG_NVME_MULTIPATH is set, but we're not using nvme to multipath,
namespaces with multiple paths were not creating unique names due to
reusing the same instance number from the namespace's head.

This patch fixes that by allocating a unique instance for each namespace.

Reported-by: Mike Snitzer <snitzer at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
This is slightly different (and simpler) than the test-version from last
week, and will work no matter how many "heads" a subsystem has.


 drivers/nvme/host/core.c | 8 +++++++-
 drivers/nvme/host/nvme.h | 1 +
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 127a9cbf3314..3dcb0ebe9575 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -366,6 +366,7 @@ static void nvme_free_ns(struct kref *kref)
 		nvme_nvm_unregister(ns);
 
 	put_disk(ns->disk);
+	ida_simple_remove(&ns->head->subsys->ns_ida, ns->instance);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
 	kfree(ns);
@@ -2905,6 +2906,10 @@ static int nvme_init_ns_head(struct nvme_ns *ns, unsigned nsid,
 	list_add_tail(&ns->siblings, &head->list);
 	ns->head = head;
 
+	ns->instance = ida_simple_get(&head->subsys->ns_ida, 1, 0, GFP_KERNEL);
+	if (ns->instance < 0)
+		ret = ns->instance;
+
 out_unlock:
 	mutex_unlock(&ctrl->subsys->lock);
 	return ret;
@@ -3013,7 +3018,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		flags = GENHD_FL_HIDDEN;
 	} else {
 		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
+				ns->instance);
 	}
 #else
 	/*
@@ -3068,6 +3073,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ctrl->subsys->lock);
+	ida_simple_remove(&ns->head->subsys->ns_ida, ns->instance);
  out_free_id:
 	kfree(id);
  out_free_queue:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..334dd5311955 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -283,6 +283,7 @@ struct nvme_ns {
 	struct kref kref;
 	struct nvme_ns_head *head;
 
+	int instance;
 	int lba_shift;
 	u16 ms;
 	u16 sgs;
-- 
2.14.3
