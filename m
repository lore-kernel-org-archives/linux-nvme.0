From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:10:01 +0200
Subject: [PATCHv2 08/11] nvme: add ANA support
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-9-hare@suse.de>

From: Christoph Hellwig <hch@lst.de>

Adding sypport for Asymmetric Namespace Access (ANA)

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 335 +++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  41 +++++-
 drivers/nvme/host/nvme.h      |  17 +++
 3 files changed, 366 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b4408e1e677f..0d8167c68dff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -68,6 +68,10 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+static unsigned long ana_log_delay = 500;
+module_param(ana_log_delay, ulong, 0644);
+MODULE_PARM_DESC(ana_log_delay, "Delay in msecs before retrieving ANA log");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -1246,6 +1250,25 @@ static void nvme_put_ns_from_disk(struct nvme_ns_head *head, int idx)
 		srcu_read_unlock(&head->srcu, idx);
 }
 
+static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+{
+	struct nvme_ns *ns, *ret = NULL;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (ns->head->ns_id == nsid) {
+			if (!kref_get_unless_zero(&ns->kref))
+				continue;
+			ret = ns;
+			break;
+		}
+		if (ns->head->ns_id > nsid)
+			break;
+	}
+	up_read(&ctrl->namespaces_rwsem);
+	return ret;
+}
+
 static int nvme_ns_ioctl(struct nvme_ns *ns, unsigned cmd, unsigned long arg)
 {
 	switch (cmd) {
@@ -1357,6 +1380,228 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms, u8 pi_type)
 }
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+static const char *nvme_ana_state_names[] = {
+	[0]				= "invalid state",
+	[NVME_ANA_OPTIMIZED]		= "optimized",
+	[NVME_ANA_NONOPTIMIZED]		= "non-optimized",
+	[NVME_ANA_INACCESSIBLE]		= "inaccessible",
+	[NVME_ANA_PERSISTENT_LOSS]	= "persistent-loss",
+	[NVME_ANA_CHANGE]		= "change",
+};
+
+static int nvme_process_ana_log(struct nvme_ctrl *ctrl, bool groups_only)
+{
+	void *base = ctrl->ana_log_buf;
+	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
+	int error, i, j;
+	size_t mdts = ctrl->max_hw_sectors << 9;
+	size_t ana_log_size = ctrl->ana_log_size, ana_xfer_size;
+	off_t ana_log_offset = 0;
+
+	/*
+	 * If anagrpid never changes we don't need to process the namespace
+	 * lists.
+	 */
+	if (ctrl->anacap & (1 << 7))
+		groups_only = true;
+
+	if (groups_only)
+		ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
+			ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc);
+
+	ana_xfer_size = ana_log_size;
+	if (mdts && ana_log_size > mdts) {
+		dev_warn(ctrl->device,
+			 "ANA log too large (%lu, max %zu), truncating\n",
+			 ana_log_size, mdts);
+		ana_xfer_size = mdts;
+	}
+resubmit:
+	error = nvme_get_log_ext(ctrl, NULL, NVME_LOG_ANA,
+			groups_only ? NVME_ANA_LOG_RGO : 0,
+			ctrl->ana_log_buf + ana_log_offset,
+			ana_xfer_size, ana_log_offset);
+	if (error) {
+		dev_warn(ctrl->device, "Failed to get ANA log: %d\n", error);
+		return -EIO;
+	}
+	ana_log_offset += ana_xfer_size;
+	if (ana_log_size > ana_log_offset) {
+		if (ana_log_size - ana_log_offset < mdts)
+			ana_xfer_size = ana_log_size - ana_log_offset;
+		goto resubmit;
+	}
+
+	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
+		struct nvme_ana_group_desc *desc = base + offset;
+		u32 grpid;
+		u32 nr_nsids;
+		size_t nsid_buf_size;
+		struct nvme_ns *ns;
+
+		if (WARN_ON_ONCE(offset > ana_log_size - sizeof(*desc)))
+			return -EINVAL;
+		grpid = le32_to_cpu(desc->grpid);
+		if (WARN_ON_ONCE(grpid == 0))
+			return -EINVAL;
+		if (WARN_ON_ONCE(grpid > ctrl->anagrpmax))
+			return -EINVAL;
+		if (WARN_ON_ONCE(desc->state == 0))
+			return -EINVAL;
+		if (WARN_ON_ONCE(desc->state > NVME_ANA_CHANGE))
+			return -EINVAL;
+
+		offset += sizeof(*desc);
+		if (groups_only) {
+			down_write(&ctrl->namespaces_rwsem);
+			list_for_each_entry(ns, &ctrl->namespaces, list) {
+				if (ns->anagrpid != grpid)
+					continue;
+				if (desc->state == NVME_SC_ANA_TRANSITION)
+					error = -EAGAIN;
+				if (ns->ana_state != desc->state) {
+					ns->ana_state = desc->state;
+					nvme_mpath_clear_current_path(ns);
+				}
+				break;
+			}
+			up_write(&ctrl->namespaces_rwsem);
+			continue;
+		}
+		nr_nsids = le32_to_cpu(desc->nnsids);
+		if (!nr_nsids)
+			continue;
+
+		nsid_buf_size = nr_nsids * sizeof(__le32);
+		if (WARN_ON_ONCE(offset > ana_log_size - nsid_buf_size))
+			return -EINVAL;
+
+		for (j = 0; j < nr_nsids; j++) {
+			u32 nsid = le32_to_cpu(desc->nsids[j]);
+
+			ns = nvme_find_get_ns(ctrl, nsid);
+			if (!ns)
+				continue;
+
+			if (ns->anagrpid != grpid ||
+			    ns->ana_state != desc->state) {
+				ns->anagrpid = grpid;
+				ns->ana_state = desc->state;
+				nvme_mpath_clear_current_path(ns);
+				if (desc->state == NVME_SC_ANA_TRANSITION)
+					error = -EAGAIN;
+			}
+			nvme_put_ns(ns);
+		}
+
+		offset += nsid_buf_size;
+	}
+
+	return error;
+}
+
+static enum nvme_ana_state nvme_get_ana_state(struct nvme_ctrl *ctrl,
+					      unsigned int grpid,
+					      unsigned int nsid)
+{
+	void *base = ctrl->ana_log_buf;
+	size_t offset = sizeof(struct nvme_ana_rsp_hdr);
+	int i, j;
+
+	if (!ctrl->ana_log_buf)
+		return NVME_ANA_OPTIMIZED;
+
+	for (i = 0; i < le16_to_cpu(ctrl->ana_log_buf->ngrps); i++) {
+		struct nvme_ana_group_desc *desc = base + offset;
+		u32 nr_nsids;
+		size_t nsid_buf_size;
+
+		if (offset > ctrl->ana_log_size - sizeof(*desc))
+			break;
+
+		offset += sizeof(*desc);
+		nr_nsids = le32_to_cpu(desc->nnsids);
+		if (!nr_nsids)
+			continue;
+
+		nsid_buf_size = nr_nsids * sizeof(__le32);
+		if (offset > ctrl->ana_log_size - nsid_buf_size)
+			break;
+
+		if (grpid == le32_to_cpu(desc->grpid)) {
+			for (j = 0; j < nr_nsids; j++) {
+				if (le32_to_cpu(desc->nsids[j]) != nsid)
+					continue;
+
+				dev_info(ctrl->device,
+					 "nsid %d: ANA group %d, %s.\n",
+					 nsid, grpid,
+					 nvme_ana_state_names[desc->state]);
+				return desc->state;
+			}
+		}
+		offset += nsid_buf_size;
+	}
+
+	return NVME_ANA_OPTIMIZED;
+}
+
+static void nvme_ana_work(struct work_struct *work)
+{
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl,
+					      ana_work.work);
+	int ret;
+
+	if (!ctrl->ana_log_buf)
+		return;
+	if (ctrl->state != NVME_CTRL_LIVE)
+		return;
+	ret = nvme_process_ana_log(ctrl, false);
+	if (ret == -EAGAIN || ret == -EIO) {
+		unsigned long log_delay = ctrl->anatt * HZ;
+
+		if (ret == -EIO)
+			log_delay = msecs_to_jiffies(ana_log_delay);
+		queue_delayed_work(nvme_wq, &ctrl->ana_work, log_delay);
+	}
+	nvme_kick_requeue_lists(ctrl);
+}
+
+int nvme_configure_ana(struct nvme_ctrl *ctrl)
+{
+	int error;
+
+	if (!nvme_ctrl_has_ana(ctrl))
+		return 0;
+
+	INIT_DELAYED_WORK(&ctrl->ana_work, nvme_ana_work);
+	ctrl->ana_log_size = sizeof(struct nvme_ana_rsp_hdr) +
+		ctrl->nanagrpid * sizeof(struct nvme_ana_group_desc) +
+		ctrl->max_namespaces * sizeof(__le32);
+	ctrl->ana_log_buf = kzalloc(ctrl->ana_log_size, GFP_KERNEL);
+	if (!ctrl->ana_log_buf)
+		return -ENOMEM;
+
+	error = nvme_process_ana_log(ctrl, false);
+	if (error) {
+		if (error != -EAGAIN && error != -EIO) {
+			kfree(ctrl->ana_log_buf);
+			ctrl->ana_log_buf = NULL;
+		} else
+			error = 0;
+	}
+	return error;
+}
+
+void nvme_deconfigure_ana(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->ana_log_buf) {
+		cancel_delayed_work_sync(&ctrl->ana_work);
+		kfree(ctrl->ana_log_buf);
+		ctrl->ana_log_buf = NULL;
+	}
+}
+
 static void nvme_set_chunk_size(struct nvme_ns *ns)
 {
 	u32 chunk_size = (((u32)ns->noiob) << (ns->lba_shift - 9));
@@ -1446,7 +1691,9 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	if (ns->ms && !nvme_ns_has_pi(ns) && !blk_get_integrity(disk))
 		capacity = 0;
 
-	set_capacity(disk, capacity);
+	if (ns->ana_state == NVME_ANA_OPTIMIZED ||
+	    ns->ana_state == NVME_ANA_NONOPTIMIZED)
+		set_capacity(disk, capacity);
 	nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
 }
@@ -1462,6 +1709,7 @@ static void __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 	ns->lba_shift = id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ds;
 	if (ns->lba_shift == 0)
 		ns->lba_shift = 9;
+	ns->anagrpid = le32_to_cpu(id->anagrpid);
 	ns->noiob = le16_to_cpu(id->noiob);
 	ns->ext = ns->ms && (id->flbas & NVME_NS_FLBAS_META_EXT);
 	ns->ms = le16_to_cpu(id->lbaf[id->flbas & NVME_NS_FLBAS_LBA_MASK].ms);
@@ -1488,6 +1736,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	struct nvme_ctrl *ctrl = ns->ctrl;
 	struct nvme_id_ns *id;
 	struct nvme_ns_ids ids;
+	unsigned int grpid;
 	int ret = 0;
 
 	if (test_bit(NVME_NS_DEAD, &ns->flags)) {
@@ -1504,6 +1753,19 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 		goto out;
 	}
 
+	grpid = le32_to_cpu(id->anagrpid);
+	if (grpid) {
+		if (ns->anagrpid != grpid) {
+			dev_warn(ctrl->device, "ns %x ANA group ID changed\n",
+				 ns->head->ns_id);
+			ns->anagrpid = grpid;
+			queue_delayed_work(nvme_wq, &ctrl->ana_work,
+					   msecs_to_jiffies(ana_log_delay));
+		}
+		ns->ana_state = nvme_get_ana_state(ctrl, grpid,
+						   ns->head->ns_id);
+	}
+
 	__nvme_revalidate_disk(disk, id);
 	nvme_report_ns_ids(ctrl, ns->head->ns_id, id, &ids);
 	if (!nvme_ns_ids_equal(&ns->head->ids, &ids)) {
@@ -2363,6 +2625,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ctrl->oncs = le16_to_cpup(&id->oncs);
 	ctrl->aen_cfg = le32_to_cpu(id->oaes) &
 		(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT);
+	if (nvme_ctrl_has_ana(ctrl))
+		ctrl->aen_cfg |= NVME_AEN_CFG_ANA_CHANGE;
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
@@ -2376,6 +2640,11 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	nvme_set_queue_limits(ctrl, ctrl->admin_q);
 	ctrl->sgls = le32_to_cpu(id->sgls);
 	ctrl->kas = le16_to_cpu(id->kas);
+	ctrl->max_namespaces = le32_to_cpu(id->mnan);
+	ctrl->anacap = id->anacap;
+	ctrl->anatt = id->anatt;
+	ctrl->nanagrpid = le32_to_cpu(id->nanagrpid);
+	ctrl->anagrpmax = le32_to_cpu(id->anagrpmax);
 
 	if (id->rtd3e) {
 		/* us -> s */
@@ -2445,7 +2714,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
 		return ret;
-	
+
 	ret = nvme_configure_timestamp(ctrl);
 	if (ret < 0)
 		return ret;
@@ -2454,6 +2723,10 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	if (ret < 0)
 		return ret;
 
+	ret = nvme_configure_ana(ctrl);
+	if (ret < 0)
+		return ret;
+
 	ctrl->identified = true;
 
 	return 0;
@@ -2649,12 +2922,30 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
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
+
+	return sprintf(buf, "%s\n", nvme_ana_state_names[ns->ana_state]);
+}
+DEVICE_ATTR_RO(ana_state);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_ana_grpid.attr,
+	&dev_attr_ana_state.attr,
 	NULL,
 };
 
@@ -2663,6 +2954,7 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
 	struct nvme_ns_ids *ids = &dev_to_ns_head(dev)->ids;
+	struct nvme_ns *ns = nvme_get_ns_from_dev(dev);
 
 	if (a == &dev_attr_uuid.attr) {
 		if (uuid_is_null(&ids->uuid) &&
@@ -2677,6 +2969,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
+		if (!ns->anagrpid)
+			return 0;
+	}
 	return a->mode;
 }
 
@@ -2939,25 +3235,6 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
-{
-	struct nvme_ns *ns, *ret = NULL;
-
-	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->head->ns_id == nsid) {
-			if (!kref_get_unless_zero(&ns->kref))
-				continue;
-			ret = ns;
-			break;
-		}
-		if (ns->head->ns_id > nsid)
-			break;
-	}
-	up_read(&ctrl->namespaces_rwsem);
-	return ret;
-}
-
 static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
 	struct streams_directive_params s;
@@ -2991,6 +3268,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
 	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
+	unsigned int grpid;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
@@ -3002,6 +3280,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ns->queue);
 	ns->queue->queuedata = ns;
 	ns->ctrl = ctrl;
+	ns->ana_state = NVME_ANA_OPTIMIZED;
 
 	kref_init(&ns->kref);
 	ns->lba_shift = 9; /* set to a default value for 512 until disk is validated */
@@ -3019,7 +3298,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_init_ns_head(ns, nsid, id))
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
-	
+
 #ifdef CONFIG_NVME_MULTIPATH
 	/*
 	 * If multipathing is enabled we need to always use the subsystem
@@ -3063,6 +3342,10 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	memcpy(disk->disk_name, disk_name, DISK_NAME_LEN);
 	ns->disk = disk;
 
+	grpid = le32_to_cpu(id->anagrpid);
+	if (grpid)
+		ns->ana_state = nvme_get_ana_state(ctrl, grpid, nsid);
+
 	__nvme_revalidate_disk(disk, id);
 
 	down_write(&ctrl->namespaces_rwsem);
@@ -3371,6 +3654,12 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 	case NVME_AER_NOTICE_FW_ACT_STARTING:
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
+	case NVME_AER_NOTICE_ANA:
+		if (WARN_ON_ONCE(!ctrl->ana_log_buf))
+			break;
+		queue_delayed_work(nvme_wq, &ctrl->ana_work,
+				   msecs_to_jiffies(ana_log_delay));
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
@@ -3406,6 +3695,7 @@ void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	cancel_delayed_work_sync(&ctrl->ana_work);
 	cancel_work_sync(&ctrl->fw_act_work);
 	if (ctrl->ops->stop_ctrl)
 		ctrl->ops->stop_ctrl(ctrl);
@@ -3440,6 +3730,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	nvme_deconfigure_ana(ctrl);
 
 	if (subsys) {
 		mutex_lock(&subsys->lock);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2802cbc7b7d0..e10bfa5e4aa5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -29,7 +29,30 @@ void nvme_failover_req(struct request *req)
 	spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
 	blk_mq_end_request(req, 0);
 
-	nvme_reset_ctrl(ns->ctrl);
+	/*
+	 * Reset the controller for any non-ANA error as we don't know what
+	 * caused the error:
+	 */
+	switch (nvme_req(req)->status & 0x7ff) {
+	case NVME_SC_ANA_TRANSITION:
+		queue_delayed_work(nvme_wq, &ns->ctrl->ana_work,
+				   ns->ctrl->anatt * HZ);
+	case NVME_SC_ANA_PERSISTENT_LOSS:
+	case NVME_SC_ANA_INACCESSIBLE:
+		/*
+		 * We could try to update the ANA group state here instead of
+		 * waiting for the AER and log page read.  But concurrency would
+		 * be nasy.
+		 */
+		nvme_mpath_clear_current_path(ns);
+		if (ns->head->disk)
+			kblockd_schedule_work(&ns->head->requeue_work);
+		break;
+	default:
+		nvme_reset_ctrl(ns->ctrl);
+		break;
+	}
+
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
@@ -54,12 +77,14 @@ void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl)
 	up_read(&ctrl->namespaces_rwsem);
 }
 
-static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
+static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head,
+		u8 ana_state)
 {
 	struct nvme_ns *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (ns->ctrl->state == NVME_CTRL_LIVE) {
+		if (ns->ctrl->state == NVME_CTRL_LIVE &&
+		    ns->ana_state == ana_state) {
 			rcu_assign_pointer(head->current_path, ns);
 			return ns;
 		}
@@ -72,8 +97,14 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
 
-	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
-		ns = __nvme_find_path(head);
+	if (likely(ns && ns->ctrl->state == NVME_CTRL_LIVE &&
+			ns->ana_state == NVME_ANA_OPTIMIZED))
+		return ns;
+
+	ns = __nvme_find_path(head, NVME_ANA_OPTIMIZED);
+	if (!ns)
+		ns = __nvme_find_path(head, NVME_ANA_NONOPTIMIZED);
+	/* XXX: try an inaccessible path as last resort per 8.18.3.3 */
 	return ns;
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3f9a4f8aa310..6ea3584fa62f 100644
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
@@ -190,6 +191,15 @@ struct nvme_ctrl {
 	struct nvme_command ka_cmd;
 	struct work_struct fw_act_work;
 
+	/* asymmetric namespace access: */
+	u8 anacap;
+	u8 anatt;
+	u32 anagrpmax;
+	u32 nanagrpid;
+	size_t ana_log_size;
+	struct nvme_ana_rsp_hdr *ana_log_buf;
+	struct delayed_work ana_work;
+
 	/* Power saving configuration */
 	u64 ps_max_latency_us;
 	bool apst_enabled;
@@ -295,6 +305,8 @@ struct nvme_ns {
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
 	u16 noiob;
+	u32 anagrpid;
+	enum nvme_ana_state ana_state;
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 	struct nvme_fault_inject fault_inject;
@@ -437,6 +449,11 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
+static inline bool nvme_ctrl_has_ana(struct nvme_ctrl *ctrl)
+{
+	return ctrl->subsys->cmic & (1 << 3);
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 void nvme_failover_req(struct request *req);
 bool nvme_req_needs_failover(struct request *req, blk_status_t error);
-- 
2.12.3
