From: Sriram.Popuri@netapp.com (Popuri, Sriram)
Date: Wed, 6 Jun 2018 12:01:04 +0000
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180601071128.7630-6-hch@lst.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
Message-ID: <BN7PR06MB40333AEEF5E96A05DC6B925592650@BN7PR06MB4033.namprd06.prod.outlook.com>

+	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
+			GFP_KERNEL);

You are assuming anagrpmax is a small value. I guess it can go upto ffffffffh.

Regards,
~Sriram

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of Christoph Hellwig
Sent: Friday, June 1, 2018 12:41 PM
To: linux-nvme at lists.infradead.org
Cc: Hannes Reinecke <hare at suse.de>
Subject: [PATCH 5/9] nvme: add ANA support

Add support for Asynchronous Namespace Access as specified in NVMe 1.3 TP 4004.  With ANA each namespace attached to a controller belongs to an ANA group that describes the characteristics of accessing the namespaces through this controller.  In the optimized and non-optimized states namespaces can be accessed regularly, although in a multi-pathing environment we should always prefer to access a namespace through a controller where an optimized relationship exists.  Namespaces in Inaccessible, Permanent-Loss or Change state for a given controller should not be accessed.

We keep a simple per-controller array of ANA states which is indexed by the ANA group ID specified in the namespace.  The states are updated through reading the ANA log page, which is read once during controller initialization, and whenever the ANA change notice AEN is received, or when one of the ANA specific status codes that signal a state change is received on a command.

There currently isn't any support for the ANA transition timeout yet.

Includes fixes and improvements from Hannes Reinecke.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c      |  30 ++++-
 drivers/nvme/host/multipath.c | 210 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  28 +++++
 3 files changed, 261 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c index d67d29e4c5ff..4a7fd138e25f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1042,7 +1042,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)  EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)  { @@ -1473,6 +1473,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
+	ns->anagrpid = le32_to_cpu(id->anagrpid);
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms); @@ -2387,6 +2388,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
+	ctrl->max_namespaces = le32_to_cpu(id->mnan);
+	ctrl->anacap = id->anacap;
+	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
+	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
 	if (id->rtd3e) {
 		/* us -> s */
@@ -2465,6 +2470,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	ret = nvme_configure_ana(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ctrl->identified = true;
 
 	return 0;
@@ -2666,6 +2675,10 @@ static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+#ifdef CONFIG_NVME_MULTIPATH
+	&dev_attr_ana_grpid.attr,
+	&dev_attr_ana_state.attr,
+#endif
 	NULL,
 };
 
@@ -2688,6 +2701,14 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+#ifdef CONFIG_NVME_MULTIPATH
+	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
+			return 0;
+		if (!nvme_get_ns_from_dev(dev)->anagrpid)
+			return 0;
+	}
+#endif
 	return a->mode;
 }
 
@@ -3391,6 +3412,11 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
+	case NVME_AER_NOTICE_ANA:
+		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
+			break;
+		queue_work(nvme_wq, &ctrl->ana_work);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -3426,6 +3452,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	cancel_work_sync(&ctrl->ana_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
@@ -3460,6 +3487,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	nvme_deconfigure_ana(ctrl);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c index 9412e5138d65..1a8791340862 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (c) 2017 Christoph Hellwig.
+ * Copyright (c) 2017-2018 Christoph Hellwig.
  *
  * This program is free software; you can redistribute it and/or modify it
  * under the terms and conditions of the GNU General Public License, @@ -41,6 +41,11 @@ void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 	}
 }
 
+static void nvme_update_ana_state(struct nvme_ns *ns, enum 
+nvme_ana_state state) {
+	WRITE_ONCE(ns->ctrl->ana_state[ns->anagrpid], state); }
+
 void nvme_failover_req(struct request *req)  {
 	struct nvme_ns *ns = req->q->queuedata; @@ -51,7 +56,31 @@ void nvme_failover_req(struct request *req)
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 	blk_mq_end_request(req, 0);
 
-	nvme_reset_ctrl(ns->ctrl);
+	/*
+	 * Reset the controller for any non-ANA error as we don't know what
+	 * caused the error:
+	 */
+	switch (nvme_req(req)->status & 0x7ff) {
+	case NVME_SC_ANA_TRANSITION:
+		/*
+		 * XXX: We should verify the controller doesn't die on during
+		 * the transition.  But that means we per-group timeout from
+		 * when we first hit the change state, so this won't be
+		 * entirely trivial..
+		 */
+		nvme_update_ana_state(ns, NVME_ANA_CHANGE);
+		break;
+	case NVME_SC_ANA_PERSISTENT_LOSS:
+		nvme_update_ana_state(ns, NVME_ANA_PERSISTENT_LOSS);
+		break;
+	case NVME_SC_ANA_INACCESSIBLE:
+		nvme_update_ana_state(ns, NVME_ANA_INACCESSIBLE);
+		break;
+	default:
+		nvme_reset_ctrl(ns->ctrl);
+		break;
+	}
+
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
@@ -77,12 +106,32 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	up_read(&ctrl->namespaces_rwsem);
 }
 
-static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
+static inline enum nvme_ana_state nvme_ns_ana_state(struct nvme_ns *ns) 
+{
+	if (!nvme_ctrl_has_ana(ns->ctrl))
+		return NVME_ANA_OPTIMIZED;
+	if (WARN_ON_ONCE(ns->anagrpid > ns->ctrl->anagrpmax))
+		return 0;
+	return READ_ONCE(ns->ctrl->ana_state[ns->anagrpid]);
+}
+
+static const char *nvme_ana_state_names[] = {
+	[0]				= "invalid state",
+	[NVME_ANA_OPTIMIZED]		= "optimized",
+	[NVME_ANA_NONOPTIMIZED]		= "non-optimized",
+	[NVME_ANA_INACCESSIBLE]		= "inaccessible",
+	[NVME_ANA_PERSISTENT_LOSS]	= "persistent-loss",
+	[NVME_ANA_CHANGE]		= "change",
+};
+
+static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head,
+		u8 ana_state)
 {
 	struct nvme_ns *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (ns->ctrl->state == NVME_CTRL_LIVE) {
+		if (ns->ctrl->state == NVME_CTRL_LIVE &&
+		    nvme_ns_ana_state(ns) == ana_state) {
 			rcu_assign_pointer(head->current_path, ns);
 			return ns;
 		}
@@ -95,8 +144,14 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)  {
 	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
 
-	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
-		ns = __nvme_find_path(head);
+	if (likely(ns && ns->ctrl->state == NVME_CTRL_LIVE &&
+			nvme_ns_ana_state(ns) == NVME_ANA_OPTIMIZED))
+		return ns;
+
+	ns = __nvme_find_path(head, NVME_ANA_OPTIMIZED);
+	if (!ns)
+		ns = __nvme_find_path(head, NVME_ANA_NONOPTIMIZED);
+	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
 	return ns;
 }
 
@@ -249,3 +304,146 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head)
 	blk_cleanup_queue(head->disk->queue);
 	put_disk(head->disk);
 }
+
+static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool 
+groups_only) {
+	void *base = ctrl->ana_log_buf;
+	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
+	int error, i;
+
+	/*
+	 * If anagrpid never changes we don't need to process the namespace
+	 * lists.
+	 */
+	if (ctrl->anacap & (1 << 6))
+		groups_only = true;
+
+	error = nvme_get_log_ext(ctrl, NULL, NVME_LOG_ANA,
+			groups_only ? NVME_ANA_LOG_RGO : 0,
+			ctrl->ana_log_buf, ctrl->ana_log_size, 0);
+	if (error) {
+		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
+		return error;
+	}
+
+	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
+		struct nvme_ana_group_desc *desc = base + offset;
+		u32 grpid = le32_to_cpu(desc->grpid);
+		u32 nr_nsids = le32_to_cpu(desc->nnsids), n = 0;
+		size_t nsid_buf_size = nr_nsids * sizeof(__le32);
+		struct nvme_ns *ns;
+
+		if (WARN_ON_ONCE(grpid == 0))
+			return -EINVAL;
+		if (WARN_ON_ONCE(grpid > ctrl->anagrpmax))
+			return -EINVAL;
+		if (WARN_ON_ONCE(desc->state == 0))
+			return -EINVAL;
+		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
+			return -EINVAL;
+
+		dev_info(ctrl->device, "ANA group %d: %s.\n",
+				grpid, nvme_ana_state_names[desc->state]);
+		WRITE_ONCE(ctrl->ana_state[grpid], desc->state);
+		offset += sizeof(*desc);
+		if (!nr_nsids)
+			continue;
+
+		if (WARN_ON_ONCE(groups_only))
+			return -EINVAL;
+		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - nsid_buf_size))
+			return -EINVAL;
+
+		down_write(&ctrl->namespaces_rwsem);
+		list_for_each_entry(ns, &ctrl->namespaces, list) {
+			u32 nsid = le32_to_cpu(desc->nsids[n]);
+
+			if (ns->head->ns_id != nsid)
+				continue;
+			ns->anagrpid = grpid;
+			if (++n == nr_nsids)
+				break;
+		}
+		up_write(&ctrl->namespaces_rwsem);
+		WARN_ON_ONCE(n < nr_nsids);
+
+		offset += nsid_buf_size;
+		if (WARN_ON_ONCE(offset > ctrl->ana_log_size - sizeof(*desc)))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void nvme_ana_work(struct work_struct *work) {
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, 
+ana_work);
+
+	nvme_process_ana_log(ctrl, false);
+	nvme_kick_requeue_lists(ctrl);
+}
+
+int nvme_configure_ana(struct nvme_ctrl *ctrl) {
+	int error;
+
+	if (!nvme_ctrl_has_ana(ctrl))
+		return 0;
+
+	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
+		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
+	if (!(ctrl->anacap & (1 << 6)))
+		ctrl->ana_log_size += ctrl->max_namespaces * sizeof(__le32);
+
+	if (ctrl->ana_log_size > ctrl->max_hw_sectors << SECTOR_SHIFT) {
+		dev_err(ctrl->device,
+			"ANA log page size (%zd) larger than MDTS (%d).\n",
+			ctrl->ana_log_size,
+			ctrl->max_hw_sectors << SECTOR_SHIFT);
+		dev_err(ctrl->device, "disabling ANA support.\n");
+		return 0;
+	}
+
+	INIT_WORK(&ctrl->ana_work, nvme_ana_work);
+	ctrl->ana_state = kcalloc(ctrl->anagrpmax, sizeof(*ctrl->ana_state),
+			GFP_KERNEL);
+	if (!ctrl->ana_state)
+		return -ENOMEM;
+
+	ctrl->ana_log_buf = kmalloc(ctrl->ana_log_size, GFP_KERNEL);
+	if (!ctrl->ana_log_buf)
+		goto out_free_ana_state;
+
+	error = nvme_process_ana_log(ctrl, true);
+	if (error)
+		goto out_free_ana_log_buf;
+	return 0;
+out_free_ana_log_buf:
+	kfree(ctrl->ana_log_buf);
+out_free_ana_state:
+	kfree(ctrl->ana_state);
+	return -ENOMEM;
+}
+
+void nvme_deconfigure_ana(struct nvme_ctrl *ctrl) {
+	kfree(ctrl->ana_log_buf);
+	kfree(ctrl->ana_state);
+}
+
+static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	return sprintf(buf, "%d\n", nvme_get_ns_from_dev(dev)->anagrpid);
+}
+DEVICE_ATTR_RO(ana_grpid);
+
+static ssize_t ana_state_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
+	enum nvme_ana_state state = nvme_ns_ana_state(ns);
+
+	return sprintf(buf, "%s\n", nvme_ana_state_names[state]); } 
+DEVICE_ATTR_RO(ana_state);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h index a9695b8645aa..4a29c736370f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -169,6 +169,7 @@ struct nvme_ctrl {
 	u16 oacs;
 	u16 nssa;
 	u16 nr_streams;
+	u32 max_namespaces;
 	atomic_t abort_limit;
 	u8 vwc;
 	u32 vs;
@@ -192,6 +193,15 @@ struct nvme_ctrl {
 #define EVENT_NS_CHANGED		(1 << 0)
 	unsigned long events;
 
+	/* asymmetric namespace access: */
+	u8 anacap;
+	u32 anagrpmax;
+	u32 nanagrpid;
+	enum nvme_ana_state *ana_state;
+	size_t ana_log_size;
+	struct nvme_ana_rsp_hdr *ana_log_buf;
+	struct work_struct ana_work;
+
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
@@ -297,6 +307,7 @@ struct nvme_ns {
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
 	u16 noiob;
+	u32 anagrpid;
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	struct nvme_fault_inject fault_inject; @@ -438,6 +449,11 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,  extern const struct attribute_group nvme_ns_id_attr_group;  extern const struct block_device_operations nvme_ns_head_ops;
 
+static inline bool nvme_ctrl_has_ana(struct nvme_ctrl *ctrl) {
+	return ctrl->subsys->cmic & (1 << 3);
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
 			struct nvme_ctrl *ctrl, int *flags); @@ -447,6 +463,8 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);  int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl,struct nvme_ns_head *head);  void nvme_mpath_add_disk(struct nvme_ns_head *head);  void nvme_mpath_remove_disk(struct nvme_ns_head *head);
+int nvme_configure_ana(struct nvme_ctrl *ctrl); void 
+nvme_deconfigure_ana(struct nvme_ctrl *ctrl);
 
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)  { @@ -465,6 +483,9 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 		kblockd_schedule_work(&head->requeue_work);
 }
 
+extern struct device_attribute dev_attr_ana_grpid; extern struct 
+device_attribute dev_attr_ana_state;
+
 #else
 /*
  * Without the multipath code enabled, multiple controller per subsystems are @@ -504,6 +525,13 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)  static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)  {  }
+static inline int nvme_configure_ana(struct nvme_ctrl *ctrl) {
+	return 0;
+}
+static inline void nvme_deconfigure_ana(struct nvme_ctrl *ctrl) { }
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
--
2.17.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
