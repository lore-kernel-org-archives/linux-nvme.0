From: hare@suse.de (Hannes Reinecke)
Date: Fri,  2 Nov 2018 10:56:40 +0100
Subject: [PATCH 2/3] nvme-multipath: Select paths based on NUMA locality
In-Reply-To: <20181102095641.28504-1-hare@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
Message-ID: <20181102095641.28504-3-hare@suse.de>

This patch creates a per-controller map to hold the NUMA locality
information. With that we can route I/O to the controller which is
'nearest' to the issuing CPU and decrease the latency there.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 32 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c | 30 +++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/rdma.c      |  3 ++-
 5 files changed, 65 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6dfcb72aa907..113ddacd6127 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2204,6 +2204,16 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
 	return count;
 }
 
+void nvme_set_ctrl_node(struct nvme_ctrl *ctrl, int numa_node)
+{
+	ctrl->numa_node = numa_node;
+	if (numa_node == NUMA_NO_NODE)
+		return;
+	ctrl->node_map = kzalloc(num_possible_nodes() * sizeof(int),
+				 GFP_KERNEL);
+}
+EXPORT_SYMBOL_GPL(nvme_set_ctrl_node);
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2834,6 +2844,23 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_sysfs_show_node_map(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int node;
+	ssize_t offset = 0;
+
+	for_each_node(node)
+		offset += snprintf(buf + offset, PAGE_SIZE - offset,
+				   "%d ", ctrl->node_map[node]);
+	offset += snprintf(buf + offset, PAGE_SIZE - offset, "\n");
+
+	return offset;
+}
+static DEVICE_ATTR(node_map, S_IRUGO, nvme_sysfs_show_node_map, NULL);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -2847,6 +2874,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_node_map.attr,
 	NULL
 };
 
@@ -2860,7 +2888,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
-
+	if (a == &dev_attr_node_map.attr && !ctrl->node_map)
+		return 0;
 	return a->mode;
 }
 
@@ -3511,6 +3540,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	kfree(ctrl->node_map);
 	nvme_mpath_uninit(ctrl);
 
 	if (subsys) {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a22ff6fb82bc..43c60ca49b3f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3000,7 +3000,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
+	nvme_set_ctrl_node(&ctrl->ctrl, dev_to_node(lport->dev));
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8e03cda770c5..6d1412af7332 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,7 +141,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
-		distance = node_distance(node, ns->ctrl->numa_node);
+		distance = ns->ctrl->node_map ?
+			ns->ctrl->node_map[node] : INT_MAX;
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -258,6 +259,31 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+void nvme_mpath_balance_subsys(struct nvme_subsystem *subsys)
+{
+	struct nvme_ctrl *ctrl;
+	int node;
+
+	mutex_lock(&subsys->lock);
+
+	/*
+	 * Reset set NUMA distance
+	 *    During creation the NUMA distance is only set
+	 *    per controller, so after connecting the other
+	 *    controllers the NUMA information on the existing
+	 *    ones is incorrect.
+	 */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		for_each_node(node) {
+			if (!ctrl->node_map)
+				continue;
+			ctrl->node_map[node] =
+				node_distance(node, ctrl->numa_node);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+}
+
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
 	struct request_queue *q;
@@ -548,6 +574,8 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
 
+	nvme_mpath_balance_subsys(ctrl->subsys);
+
 	if (!nvme_ctrl_use_ana(ctrl))
 		return 0;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f608fc11d329..aebf78b2946e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -154,6 +154,7 @@ struct nvme_ctrl {
 	struct device *dev;
 	int instance;
 	int numa_node;
+	int *node_map;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
@@ -438,6 +439,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+void nvme_set_ctrl_node(struct nvme_ctrl *ctrl, int node);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 4468d672ced9..85520b8d4bea 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -762,7 +762,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
+	nvme_set_ctrl_node(&ctrl->ctrl,
+			   dev_to_node(ctrl->device->dev->dma_device));
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
-- 
2.16.4
