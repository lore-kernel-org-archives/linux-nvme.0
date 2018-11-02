From: hare@suse.de (Hannes Reinecke)
Date: Fri,  2 Nov 2018 10:56:39 +0100
Subject: [PATCH 1/3] nvme: NUMA locality information for fabrics
In-Reply-To: <20181102095641.28504-1-hare@suse.de>
References: <20181102095641.28504-1-hare@suse.de>
Message-ID: <20181102095641.28504-2-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

Add a new field 'numa_node' to the nvme_ctrl structure to hold the
NUMA locality information of the underlying hardware.
With that we can allocate the memory structures on the same NUMA
node as the underlying hardware.

Signed-off-by: Hannes Reinecke <hare at suse.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c      | 4 +++-
 drivers/nvme/host/fc.c        | 5 +++--
 drivers/nvme/host/multipath.c | 4 ++--
 drivers/nvme/host/nvme.h      | 1 +
 drivers/nvme/host/rdma.c      | 5 +++--
 5 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2e65be8b1387..6dfcb72aa907 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2766,6 +2766,7 @@ static ssize_t  field##_show(struct device *dev,				\
 static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
 
 nvme_show_int_function(cntlid);
+nvme_show_int_function(numa_node);
 
 static ssize_t nvme_sysfs_delete(struct device *dev,
 				struct device_attribute *attr, const char *buf,
@@ -2845,6 +2846,7 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_subsysnqn.attr,
 	&dev_attr_address.attr,
 	&dev_attr_state.attr,
+	&dev_attr_numa_node.attr,
 	NULL
 };
 
@@ -3055,7 +3057,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	struct gendisk *disk;
 	struct nvme_id_ns *id;
 	char disk_name[DISK_NAME_LEN];
-	int node = dev_to_node(ctrl->dev), flags = GENHD_FL_EXT_DEVT;
+	int node = ctrl->numa_node, flags = GENHD_FL_EXT_DEVT;
 
 	ns = kzalloc_node(sizeof(*ns), GFP_KERNEL, node);
 	if (!ns)
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b70c8bab045..a22ff6fb82bc 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2433,7 +2433,7 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 	ctrl->tag_set.ops = &nvme_fc_mq_ops;
 	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
 	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-	ctrl->tag_set.numa_node = NUMA_NO_NODE;
+	ctrl->tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 	ctrl->tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
@@ -3000,6 +3000,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	ctrl->ctrl.opts = opts;
 	ctrl->ctrl.nr_reconnects = 0;
+	ctrl->ctrl.numa_node = dev_to_node(lport->dev);
 	INIT_LIST_HEAD(&ctrl->ctrl_list);
 	ctrl->lport = lport;
 	ctrl->rport = rport;
@@ -3038,7 +3039,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->admin_tag_set.ops = &nvme_fc_admin_mq_ops;
 	ctrl->admin_tag_set.queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 	ctrl->admin_tag_set.reserved_tags = 2; /* fabric connect + Keep-Alive */
-	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
+	ctrl->admin_tag_set.numa_node = ctrl->ctrl.numa_node;
 	ctrl->admin_tag_set.cmd_size =
 		struct_size((struct nvme_fcp_op_w_sgl *)NULL, priv,
 			    ctrl->lport->ops->fcprqst_priv_sz);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5e3cc8c59a39..8e03cda770c5 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -141,7 +141,7 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
 
-		distance = node_distance(node, dev_to_node(ns->ctrl->dev));
+		distance = node_distance(node, ns->ctrl->numa_node);
 
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
@@ -276,7 +276,7 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!(ctrl->subsys->cmic & (1 << 1)) || !multipath)
 		return 0;
 
-	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
+	q = blk_alloc_queue_node(GFP_KERNEL, ctrl->numa_node, NULL);
 	if (!q)
 		goto out;
 	q->queuedata = head;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cee79cb388af..f608fc11d329 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -153,6 +153,7 @@ struct nvme_ctrl {
 	struct request_queue *connect_q;
 	struct device *dev;
 	int instance;
+	int numa_node;
 	struct blk_mq_tag_set *tagset;
 	struct blk_mq_tag_set *admin_tagset;
 	struct list_head namespaces;
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d181cafedc58..4468d672ced9 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -693,7 +693,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->ops = &nvme_rdma_admin_mq_ops;
 		set->queue_depth = NVME_AQ_MQ_TAG_DEPTH;
 		set->reserved_tags = 2; /* connect + keep-alive */
-		set->numa_node = NUMA_NO_NODE;
+		set->numa_node = nctrl->numa_node;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 			SG_CHUNK_SIZE * sizeof(struct scatterlist);
 		set->driver_data = ctrl;
@@ -706,7 +706,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->ops = &nvme_rdma_mq_ops;
 		set->queue_depth = nctrl->sqsize + 1;
 		set->reserved_tags = 1; /* fabric connect */
-		set->numa_node = NUMA_NO_NODE;
+		set->numa_node = nctrl->numa_node;
 		set->flags = BLK_MQ_F_SHOULD_MERGE;
 		set->cmd_size = sizeof(struct nvme_rdma_request) +
 			SG_CHUNK_SIZE * sizeof(struct scatterlist);
@@ -762,6 +762,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		return error;
 
 	ctrl->device = ctrl->queues[0].device;
+	ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
 
 	ctrl->max_fr_pages = nvme_rdma_get_max_fr_pages(ctrl->device->dev);
 
-- 
2.16.4
