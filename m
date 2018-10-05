From: hare@suse.de (Hannes Reinecke)
Date: Fri,  5 Oct 2018 11:29:15 +0200
Subject: [PATCH 2/2] nvme-multipath: manual NUMA configuration
In-Reply-To: <20181005092915.126636-1-hare@suse.de>
References: <20181005092915.126636-1-hare@suse.de>
Message-ID: <20181005092915.126636-3-hare@suse.de>

Not every NUMA configuration allows for an automatic setup via
the distance between nodes, or even the admin might have some
specific ideas on how things should be setup.
This patch adds a new sysfs attribute 'node_map' to allow to
specify the NUMA mapping for each controller.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c      | 64 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/multipath.c |  9 ++++--
 drivers/nvme/host/nvme.h      |  2 ++
 drivers/nvme/host/pci.c       |  3 +-
 drivers/nvme/host/rdma.c      |  3 +-
 6 files changed, 76 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 21c1d317415a..57271c0a765f 100644
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
@@ -2834,6 +2849,50 @@ static ssize_t nvme_sysfs_show_address(struct device *dev,
 }
 static DEVICE_ATTR(address, S_IRUGO, nvme_sysfs_show_address, NULL);
 
+static ssize_t nvme_sysfs_store_node_map(struct device *dev,
+					 struct device_attribute *attr,
+					 const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	int i = 0, node_id, ret;
+	char *ptr, *node_str, *node_ptr;
+
+	ptr = node_str = kstrdup(buf, GFP_KERNEL);
+	if (!ptr)
+		return -ENOMEM;
+	while (ptr && i < num_possible_nodes()) {
+		printk("%s\n", ptr);
+		node_ptr = strsep(&ptr, " ");
+		ret = kstrtoint(node_ptr, 0, &node_id);
+		if (ret < 0)
+			break;
+		ctrl->node_map[i] = node_id;
+		i++;
+	}
+	kfree(node_str);
+	if (ptr)
+		ret = -EINVAL;
+	return ret < 0 ? ret : count;
+}
+
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
+static DEVICE_ATTR(node_map, S_IRUGO | S_IWUSR, nvme_sysfs_show_node_map,
+		   nvme_sysfs_store_node_map);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -2847,6 +2906,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
 	&dev_attr_node_id.attr,
+	&dev_attr_node_map.attr,
 	NULL
 };
 
@@ -2860,7 +2920,8 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 		return 0;
 	if (a == &dev_attr_address.attr && !ctrl->ops->get_address)
 		return 0;
-
+	if (a == &dev_attr_node_map.attr && !ctrl->node_map)
+		return 0;
 	return a->mode;
 }
 
@@ -3507,6 +3568,7 @@ static void nvme_free_ctrl(struct device *dev)
 
 	ida_simple_remove(&nvme_instance_ida, ctrl->instance);
 	kfree(ctrl->effects);
+	kfree(ctrl->node_map);
 	nvme_mpath_uninit(ctrl);
 
 	if (subsys) {
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 7f246dd04bc5..9ceea2c91249 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2990,7 +2990,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
-	ctrl->ctrl.node_id = dev_to_node(lport->dev);
+	nvme_set_ctrl_node(&ctrl->ctrl, dev_to_node(lport->dev));
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8d456c6f0e02..b9c617cbe2c4 100644
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
 
@@ -519,6 +523,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
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
index b5d37aacf212..3df9d380e59b 100644
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
@@ -2517,7 +2517,6 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	dev->ctrl.node_id = node;
 	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 707e158561ba..70375acff812 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -755,7 +755,8 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
-	ctrl->ctrl.node_id = dev_to_node(ctrl->device->dev->dma_device);
+	nvme_set_ctrl_node(&ctrl->ctrl,
+			   dev_to_node(ctrl->device->dev->dma_device));
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
-- 
2.16.4
