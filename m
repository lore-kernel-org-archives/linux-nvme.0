From: hch@lst.de (Christoph Hellwig)
Date: Wed,  6 Jun 2018 16:33:07 +0200
Subject: [PATCH 06/10] nvme: don't set gendisks live that don't have an I/O
 capable path
In-Reply-To: <20180606143311.23076-1-hch@lst.de>
References: <20180606143311.23076-1-hch@lst.de>
Message-ID: <20180606143311.23076-7-hch@lst.de>

Only add the gendisk for a ns_head once we have a patch that can actually
do I/O.  Without that we'll get hangs during partition scanning.  To ensure
we don't have dangling unregisters paths make sure to register any missing
ns_head gendisk once the ANA state changes.

Reported-by: Hannes Reinecke <hare at suse.de>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c | 43 ++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/nvme.h      |  4 ++--
 3 files changed, 35 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 67bd73a98a1b..e62de51209b2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3081,7 +3081,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
 
-	nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk(ns);
 	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2ab55ca15cec..d30229a21c97 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -264,20 +264,31 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	return -ENOMEM;
 }
 
-void nvme_mpath_add_disk(struct nvme_ns_head *head)
+static void __nvme_mpath_add_disk(struct nvme_ns *ns)
 {
-	if (!head->disk)
+
+	struct nvme_ns_head *head = ns->head;
+	enum nvme_ana_state state = nvme_ns_ana_state(ns);
+
+	lockdep_assert_held(&head->subsys->lock);
+
+	if (!head->disk ||
+	    (head->disk->flags & GENHD_FL_UP) ||
+	    (state != NVME_ANA_OPTIMIZED && state != NVME_ANA_NONOPTIMIZED))
 		return;
 
-	mutex_lock(&head->subsys->lock);
-	if (!(head->disk->flags & GENHD_FL_UP)) {
-		device_add_disk(&head->subsys->dev, head->disk);
-		if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
-				&nvme_ns_id_attr_group))
-			pr_warn("%s: failed to create sysfs group for identification\n",
-				head->disk->disk_name);
-	}
-	mutex_unlock(&head->subsys->lock);
+	device_add_disk(&head->subsys->dev, head->disk);
+	if (sysfs_create_group(&disk_to_dev(head->disk)->kobj,
+			&nvme_ns_id_attr_group))
+		pr_warn("%s: failed to create sysfs group for identification\n",
+			head->disk->disk_name);
+}
+
+void nvme_mpath_add_disk(struct nvme_ns *ns)
+{
+	mutex_lock(&ns->head->subsys->lock);
+	__nvme_mpath_add_disk(ns);
+	mutex_unlock(&ns->head->subsys->lock);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
@@ -363,6 +374,16 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 			return -EINVAL;
 	}
 
+	/*
+	 * Make sure any namespaces that were first discovered in a state where
+	 * we could not do I/O are added once they can perform I/O.
+	 */
+	mutex_lock(&ctrl->subsys->lock);
+	down_write(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		__nvme_mpath_add_disk(ns);
+	up_write(&ctrl->namespaces_rwsem);
+	mutex_unlock(&ctrl->subsys->lock);
 	return 0;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 82a58bd2bf8e..be2585576bad 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -465,7 +465,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_configure_ana(struct nvme_ctrl *ctrl);
 void nvme_deconfigure_ana(struct nvme_ctrl *ctrl);
@@ -512,7 +512,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_add_disk(struct nvme_ns *ns)
 {
 }
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
-- 
2.14.2
