From: hare@suse.de (Hannes Reinecke)
Date: Fri, 26 Oct 2018 14:57:17 +0200
Subject: [PATCH 2/3] nvme-multipath: Select paths based on NUMA locality
In-Reply-To: <20181026125718.122767-1-hare@suse.de>
References: <20181026125718.122767-1-hare@suse.de>
Message-ID: <20181026125718.122767-3-hare@suse.de>

This patch creates a per-controller map to hold the NUMA locality
information. With that we can route I/O to the controller which is
'nearest' to the issuing CPU and decrease the latency there.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 37 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c |  9 +++++++--
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/pci.c       |  2 +-
 drivers/nvme/host/rdma.c      |  3 ++-
 6 files changed, 49 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ad7abeb7442b..02a697c6b983 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2204,6 +2204,21 @@ static int nvme_active_ctrls(struct nvme_subsystem *subsys)
 	return count;
 }
 
+void nvme_set_ctrl_node(struct nvme_ctrl *ctrl, int node_id)
+{
+	int node;
+
+	ctrl->node_id = node_id;
+	if (node_id == NUMA_NO_NODE)
+		return;
+	ctrl->node_map = kzalloc(num_possible_nodes() * sizeof(int),
+				 GFP_KERNEL);
+	if (ctrl->node_map)
+		for_each_node(node)
+			ctrl->node_map[node] = node_distance(node, node_id);
+}
+EXPORT_SYMBOL_GPL(nvme_set_ctrl_node);
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -2834,6 +2849,23 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
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
@@ -2847,6 +2879,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_node_id.attr,
+	&dev_attr_node_map.attr,
 	NULL
 };
 
@@ -2860,7 +2893,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
-
+	if (a == &dev_attr_node_map.attr && !ctrl->node_map)
+		return 0;
 	return a->mode;
 }
 
@@ -3507,6 +3541,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	kfree(ctrl->node_map);
 	nvme_mpath_uninit(ctrl);
 
 	if (subsys) {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 500d9d6ec7ce..ce01140450c4 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3000,7 +3000,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.node_id = dev_to_node(lport->dev);
+	nvme_set_ctrl_node(&ctrl->ctrl, dev_to_node(lport->dev));
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 123292187b40..a589a1a7b6ce 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,7 +141,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
-		distance = node_distance(node, ns->ctrl->node_id);
+		distance = ns->ctrl->node_map ?
+			ns->ctrl->node_map[node] : INT_MAX;
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -163,8 +164,11 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 	if (!found)
 		found = fallback;
-	if (found)
+	if (found) {
+		dev_dbg(disk_to_dev(head->disk), "none: node %d path %s\n",
+			node, found->disk->disk_name);
 		rcu_assign_pointer(head->current_path[node], found);
+	}
 	return found;
 }
 
@@ -528,6 +532,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		nvme_mpath_set_live(ns);
 		mutex_unlock(&ns->head->lock);
 	}
+	nvme_mpath_clear_current_path(ns);
 }
 
 void nvme_mpath_remove_disk(struct nvme_ns_head *head)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 55347a547d84..0027f5d41ff8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -154,6 +154,7 @@ struct nvme_ctrl {
 	struct device *dev;
 	int instance;
 	int node_id;
+	int *node_map;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
@@ -437,6 +438,7 @@ void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
 void nvme_start_freeze(struct nvme_ctrl *ctrl);
+void nvme_set_ctrl_node(struct nvme_ctrl *ctrl, int node);
 
 #define NVME_QID_ANY -1
 struct request *nvme_alloc_request(struct request_queue *q,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4e023cd007e1..461116bd5a03 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2509,7 +2509,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		result = -ENOMEM;
 		goto release_pools;
 	}
-
+	nvme_set_ctrl_node(&dev->ctrl, node);
 	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_pci_ctrl_ops,
 			quirks);
 	if (result)
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 31712d77b372..e9d34a9305b8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -762,7 +762,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.node_id = dev_to_node(ctrl->device->dev->dma_device);
+	nvme_set_ctrl_node(&ctrl->ctrl,
+			   dev_to_node(ctrl->device->dev->dma_device));
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
-- 
2.16.4
