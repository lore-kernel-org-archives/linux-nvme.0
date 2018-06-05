From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Jun 2018 13:17:46 +0200
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
In-Reply-To: <20180605082905.1740-1-hare@suse.de>
References: <20180605082905.1740-1-hare@suse.de>
Message-ID: <20180605111746.GA5802@lst.de>

On Tue, Jun 05, 2018@10:29:05AM +0200, Hannes Reinecke wrote:
> When a device is in ANA inaccessible state the call to 'nvme connect'
> will hang as a parition scan is triggered and the I/O will be requeued
> indefinitely.
> Or rather, requeued until the next path is connected, but we cannot issue
> any nvme ioctls anymore as the nvmf_dev_mutex is blocked by the initial
> 'connect' call.
> 
> This patch inhibits partition scan if no working paths are found, and
> retriggers the partition scan once the device becomes active.

And what updates the state once all your inaccessible or change
state groups become optimized?

Also I see no point registering the disk if we can't do I/O to it.

I'd rather prefer something along the lines of the completely untested
patch below if we really want to go down this route:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3b55580bb9be..5d90560775e1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3080,7 +3080,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		pr_warn("%s: failed to register lightnvm sysfs group for identification\n",
 			ns->disk->disk_name);
 
-	nvme_mpath_add_disk(ns->head);
+	nvme_mpath_add_disk(ns);
 	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 6e4fdc1a0581..8058dc385df5 100644
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
@@ -299,6 +310,7 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 {
 	void *base = ctrl->ana_log_buf;
 	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
+	struct nvme_ns *ns;
 	int error, i;
 
 	/*
@@ -316,21 +328,22 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 		return error;
 	}
 
+	error = -EINVAL;
+	mutex_lock(&ctrl->subsys->lock);
 	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
 		struct nvme_ana_group_desc *desc = base + offset;
 		u32 grpid = le32_to_cpu(desc->grpid);
 		u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
 		size_t nsid_buf_size = nr_nsids * sizeof(__le32);
-		struct nvme_ns *ns;
 
 		if (WARN_ON_ONCE(grpid == 0))
-			return -EINVAL;
+			goto out_error;
 		if (WARN_ON_ONCE(grpid > ctrl->anagrpmax))
-			return -EINVAL;
+			goto out_error;
 		if (WARN_ON_ONCE(desc->state == 0))
-			return -EINVAL;
+			goto out_error;
 		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
-			return -EINVAL;
+			goto out_error;
 
 		dev_info(ctrl->device, "ANA group %d: %s.\n",
 				grpid, nvme_ana_state_names[desc->state]);
@@ -340,9 +353,9 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 			continue;
 
 		if (WARN_ON_ONCE(groups_only))
-			return -EINVAL;
+			goto out_error;
 		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
-			return -EINVAL;
+			goto out_error;
 
 		down_write(&ctrl->namespaces_rwsem);
 		list_for_each_entry(ns, &ctrl->namespaces, list) {
@@ -359,10 +372,19 @@ static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
 
 		offset += nsid_buf_size;
 		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
-			return -EINVAL;
+			goto out_error;
 	}
 
-	return 0;
+	// XXX: optimize when to actually calls this..
+	down_write(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		__nvme_mpath_add_disk(ns);
+	up_write(&ctrl->namespaces_rwsem);
+
+	error = 0;
+out_error:
+	mutex_unlock(&ctrl->subsys->lock);
+	return error;
 }
 
 static void nvme_ana_work(struct work_struct *work)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a6541b9f1548..ccbeae09599d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -460,7 +460,7 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 void nvme_failover_req(struct request *req);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);
-void nvme_mpath_add_disk(struct nvme_ns_head *head);
+void nvme_mpath_add_disk(struct nvme_ns *ns);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_configure_ana(struct nvme_ctrl *ctrl);
 void nvme_deconfigure_ana(struct nvme_ctrl *ctrl);
@@ -507,7 +507,7 @@ static inline int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,
 {
 	return 0;
 }
-static inline void nvme_mpath_add_disk(struct nvme_ns_head *head)
+static inline void nvme_mpath_add_disk(struct nvme_ns *ns)
 {
 }
 static inline void nvme_mpath_remove_disk(struct nvme_ns_head *head)
