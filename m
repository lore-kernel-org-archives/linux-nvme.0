From: jonathan.derrick@intel.com (Jon Derrick)
Date: Thu, 25 Feb 2016 19:36:37 -0700
Subject: [Patchv2 2/3] NVMe: Introduce sysfs entries for submission queues in
 CMB
In-Reply-To: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
References: <1456454198-26683-1-git-send-email-jonathan.derrick@intel.com>
Message-ID: <1456454198-26683-3-git-send-email-jonathan.derrick@intel.com>

Currently submission queues are always mapped to the CMB if possible and
allowed by a module parameter. To allow userspace more control over the
CMB, this patch introduces a sysfs/cmb framework into the core nvme code
and refactors the pci portion.

If the controller supports SQes in the CMB, sysfs files cmb_sq_depth and
cmb_sq_offset are visible. To apply changes to the queues, users must
write the sysfs reset_controller entry after changing cmb parameters.

Signed-off-by: Jon Derrick <jonathan.derrick at intel.com>
---
 drivers/nvme/host/core.c | 136 +++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h |  23 ++++++
 drivers/nvme/host/pci.c  | 200 ++++++++++++++++++++++++++++++++---------------
 3 files changed, 292 insertions(+), 67 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07b7ec69..af58e3b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1035,6 +1035,89 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+static ssize_t nvme_cmb_sq_depth_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	return sprintf(buf, "%u\n", cmb->sq_depth);
+}
+
+static ssize_t nvme_cmb_sq_depth_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	u32 sq_depth;
+
+	sscanf(buf, "%u", &sq_depth);
+	if (sq_depth > 0xffff)
+		return -EINVAL;
+
+	if (sq_depth > 0 && sq_depth < ctrl->tagset->reserved_tags + 1)
+		return -EINVAL;
+
+	cmb->sq_depth = sq_depth;
+	return count;
+}
+static DEVICE_ATTR(cmb_sq_depth, S_IWUSR | S_IRUGO, nvme_cmb_sq_depth_show,
+						nvme_cmb_sq_depth_store);
+
+static ssize_t nvme_cmb_sq_offset_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	return sprintf(buf, "%llu\n", cmb->sq_offset);
+}
+
+static ssize_t nvme_cmb_sq_offset_store(struct device *dev,
+					struct device_attribute *attr,
+					const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+	u64 sq_offset;
+
+	sscanf(buf, "%llu", &sq_offset);
+	if (sq_offset >= cmb->size)
+		return -EINVAL;
+
+	cmb->sq_offset = sq_offset;
+	return count;
+}
+static DEVICE_ATTR(cmb_sq_offset, S_IWUSR | S_IRUGO, nvme_cmb_sq_offset_show,
+						nvme_cmb_sq_offset_store);
+
+static struct attribute *nvme_cmb_attrs[] = {
+	&dev_attr_cmb_sq_depth.attr,
+	&dev_attr_cmb_sq_offset.attr,
+	NULL
+};
+
+static umode_t nvme_cmb_attrs_are_visible(struct kobject *kobj,
+		struct attribute *a, int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_cmb *cmb = ctrl->cmb;
+
+	if ((a == &dev_attr_cmb_sq_depth.attr) ||
+	    (a == &dev_attr_cmb_sq_offset.attr)) {
+		if (!(cmb->flags & NVME_CMB_SQ_SUPPORTED))
+			return 0;
+	}
+	return a->mode;
+}
+
+static struct attribute_group nvme_cmb_attr_group = {
+	.attrs 		= nvme_cmb_attrs,
+	.is_visible	= nvme_cmb_attrs_are_visible,
+};
+
 static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
 								char *buf)
 {
@@ -1066,7 +1149,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	NULL,
 };
 
-static umode_t nvme_attrs_are_visible(struct kobject *kobj,
+static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -1085,7 +1168,7 @@ static umode_t nvme_attrs_are_visible(struct kobject *kobj,
 
 static const struct attribute_group nvme_ns_attr_group = {
 	.attrs		= nvme_ns_attrs,
-	.is_visible	= nvme_attrs_are_visible,
+	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
 #define nvme_show_function(field)						\
@@ -1344,6 +1427,47 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+static int nvme_init_cmb(struct nvme_ctrl *ctrl)
+{
+	/* Preserve across device resets */
+	if (ctrl->cmb)
+		return 0;
+
+	ctrl->cmb = kzalloc(sizeof(*ctrl->cmb), GFP_KERNEL);
+	if (!ctrl->cmb)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void nvme_release_cmb(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->cmb) {
+		kfree(ctrl->cmb);
+		ctrl->cmb = NULL;
+	}
+}
+
+void nvme_map_cmb(struct nvme_ctrl *ctrl)
+{
+	struct device *dev = ctrl->device;
+
+	if (ctrl->ops->map_cmb(ctrl))
+		return;
+
+	if (sysfs_create_group(&dev->kobj, &nvme_cmb_attr_group))
+		dev_warn(dev, "failed to create sysfs group for CMB\n");
+}
+EXPORT_SYMBOL_GPL(nvme_map_cmb);
+
+void nvme_unmap_cmb(struct nvme_ctrl *ctrl)
+{
+	struct device *dev = ctrl->device;
+	ctrl->ops->unmap_cmb(ctrl);
+	sysfs_remove_group(&dev->kobj, &nvme_cmb_attr_group);
+}
+EXPORT_SYMBOL_GPL(nvme_unmap_cmb);
+
 static DEFINE_IDA(nvme_instance_ida);
 
 static int nvme_set_instance(struct nvme_ctrl *ctrl)
@@ -1388,6 +1512,7 @@ static void nvme_free_ctrl(struct kref *kref)
 	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
 
 	put_device(ctrl->device);
+	nvme_release_cmb(ctrl);
 	nvme_release_instance(ctrl);
 
 	ctrl->ops->free_ctrl(ctrl);
@@ -1430,11 +1555,18 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	}
 	get_device(ctrl->device);
 
+	ret = nvme_init_cmb(ctrl);
+	if (ret)
+		goto out_destroy_device;
+
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
 	spin_unlock(&dev_list_lock);
 
 	return 0;
+out_destroy_device:
+	put_device(ctrl->device);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 out_release_instance:
 	nvme_release_instance(ctrl);
 out:
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 63ba8a5..b5d0814 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -72,6 +72,7 @@ struct nvme_ctrl {
 	struct mutex namespaces_mutex;
 	struct device *device;	/* char device */
 	struct list_head node;
+	struct nvme_cmb *cmb;
 
 	char name[12];
 	char serial[20];
@@ -116,6 +117,23 @@ struct nvme_ns {
 	u32 mode_select_block_len;
 };
 
+struct nvme_cmb {
+	void __iomem *cmb;
+	dma_addr_t dma_addr;
+	u64 size;
+	u64 sq_offset;
+	u16 sq_depth;
+	unsigned long flags;
+};
+
+enum nvme_cmb_flags {
+	NVME_CMB_SQ_SUPPORTED	= (1 << 0),
+	NVME_CMB_CQ_SUPPORTED	= (1 << 1),
+	NVME_CMB_WD_SUPPORTED	= (1 << 2),
+	NVME_CMB_RD_SUPPORTED	= (1 << 3),
+	NVME_CMB_PRP_SUPPORTED	= (1 << 4),
+};
+
 struct nvme_ctrl_ops {
 	struct module *module;
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
@@ -124,6 +142,8 @@ struct nvme_ctrl_ops {
 	bool (*io_incapable)(struct nvme_ctrl *ctrl);
 	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
+	int (*map_cmb)(struct nvme_ctrl *ctrl);
+	void (*unmap_cmb)(struct nvme_ctrl *ctrl);
 };
 
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
@@ -239,6 +259,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl);
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
+void nvme_map_cmb(struct nvme_ctrl *ctrl);
+void nvme_unmap_cmb(struct nvme_ctrl *ctrl);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fec7479..97a46f4 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -60,10 +60,6 @@
 static int use_threaded_interrupts;
 module_param(use_threaded_interrupts, int, 0);
 
-static bool use_cmb_sqes = true;
-module_param(use_cmb_sqes, bool, 0644);
-MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
-
 static LIST_HEAD(dev_list);
 static DEFINE_SPINLOCK(dev_list_lock);
 static struct task_struct *nvme_thread;
@@ -102,10 +98,6 @@ struct nvme_dev {
 	struct work_struct remove_work;
 	struct mutex shutdown_lock;
 	bool subsystem;
-	void __iomem *cmb;
-	dma_addr_t cmb_dma_addr;
-	u64 cmb_size;
-	u32 cmbsz;
 	unsigned long flags;
 
 #define NVME_CTRL_RESETTING    0
@@ -999,13 +991,29 @@ static void nvme_cancel_queue_ios(struct request *req, void *data, bool reserved
 	blk_mq_complete_request(req, status);
 }
 
-static void nvme_free_queue(struct nvme_queue *nvmeq)
+static void nvme_release_sq(struct nvme_queue *nvmeq)
 {
-	dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
-				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
 	if (nvmeq->sq_cmds)
 		dma_free_coherent(nvmeq->q_dmadev, SQ_SIZE(nvmeq->q_depth),
 					nvmeq->sq_cmds, nvmeq->sq_dma_addr);
+
+	nvmeq->sq_cmds = NULL;
+	nvmeq->sq_cmds_io = NULL;
+}
+
+static void nvme_release_cq(struct nvme_queue *nvmeq)
+{
+	if (nvmeq->cqes)
+		dma_free_coherent(nvmeq->q_dmadev, CQ_SIZE(nvmeq->q_depth),
+				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
+
+	nvmeq->cqes = NULL;
+}
+
+static void nvme_free_queue(struct nvme_queue *nvmeq)
+{
+	nvme_release_sq(nvmeq);
+	nvme_release_cq(nvmeq);
 	kfree(nvmeq);
 }
 
@@ -1076,38 +1084,31 @@ static void nvme_disable_admin_queue(struct nvme_dev *dev, bool shutdown)
 	spin_unlock_irq(&nvmeq->q_lock);
 }
 
-static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
-				int entry_size)
+static int nvme_cmb_sq_depth(struct nvme_dev *dev, int nr_io_queues)
 {
-	int q_depth = dev->q_depth;
-	unsigned q_size_aligned = roundup(q_depth * entry_size,
-					  dev->ctrl.page_size);
+	struct nvme_cmb *cmb = dev->ctrl.cmb;
+	u32 sq_size;
+	u64 sqes_size;
 
-	if (q_size_aligned * nr_io_queues > dev->cmb_size) {
-		u64 mem_per_q = div_u64(dev->cmb_size, nr_io_queues);
-		mem_per_q = round_down(mem_per_q, dev->ctrl.page_size);
-		q_depth = div_u64(mem_per_q, entry_size);
+	if (!cmb->sq_depth)
+		return -EINVAL;
 
-		/*
-		 * Ensure the reduced q_depth is above some threshold where it
-		 * would be better to map queues in system memory with the
-		 * original depth
-		 */
-		if (q_depth < 64)
-			return -ENOMEM;
-	}
+	sq_size = cmb->sq_depth * sizeof(struct nvme_command);
+	sqes_size = sq_size * nr_io_queues;
+	if (cmb->sq_offset + sqes_size > cmb->size)
+		return -ENOMEM;
 
-	return q_depth;
+	return cmb->sq_depth;
 }
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid, int depth)
 {
-	if (qid && dev->cmb && use_cmb_sqes && NVME_CMB_SQS(dev->cmbsz)) {
-		unsigned offset = (qid - 1) * roundup(SQ_SIZE(depth),
-						      dev->ctrl.page_size);
-		nvmeq->sq_dma_addr = dev->cmb_dma_addr + offset;
-		nvmeq->sq_cmds_io = dev->cmb + offset;
+	struct nvme_cmb *cmb = dev->ctrl.cmb;
+	if (qid && cmb->cmb && cmb->sq_depth) {
+		u32 offset = (qid - 1) * SQ_SIZE(depth);
+		nvmeq->sq_dma_addr = cmb->dma_addr + offset;
+		nvmeq->sq_cmds_io = cmb->cmb + offset;
 	} else {
 		nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
 					&nvmeq->sq_dma_addr, GFP_KERNEL);
@@ -1118,6 +1119,27 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 	return 0;
 }
 
+static bool nvme_queue_needs_remap(struct nvme_dev *dev, struct nvme_queue *nvmeq)
+{
+	if (dev->queue_count > 1) {
+		struct nvme_cmb *cmb = dev->ctrl.cmb;
+		/*
+		 * This condition occurs if SQes were previously mapped
+		 * in Memory or CMB and need to be switched over to the
+		 * other. This also occurs if SQes are currently mapped
+		 * in the CMB and CMB parameters change.
+		 *
+		 * However it doesn't hurt to remap CMB SQes if the
+		 * parameters don't change, so to simplify we can check
+		 * if they are currently in the CMB or will be in the
+		 * CMB after queue creation.
+		 */
+		return (nvmeq->sq_cmds_io || cmb->sq_depth);
+	}
+
+	return false;
+}
+
 static struct nvme_queue *nvme_alloc_queue(struct nvme_dev *dev, int qid,
 							int depth)
 {
@@ -1370,6 +1392,30 @@ static int nvme_kthread(void *data)
 	return 0;
 }
 
+static int nvme_remap_queue(struct nvme_dev *dev, struct nvme_queue *nvmeq)
+{
+	struct nvme_cmb *cmb = dev->ctrl.cmb;
+
+	nvme_release_sq(nvmeq);
+	nvme_release_cq(nvmeq);
+
+	if (!cmb->sq_depth)
+		dev->q_depth = dev->tagset.queue_depth;
+	nvmeq->q_depth = dev->q_depth;
+
+	nvmeq->cqes = dma_zalloc_coherent(dev->dev, CQ_SIZE(nvmeq->q_depth),
+					  &nvmeq->cq_dma_addr, GFP_KERNEL);
+	if (!nvmeq->cqes)
+		return -ENOMEM;
+
+	if (nvme_alloc_sq_cmds(dev, nvmeq, nvmeq->qid, nvmeq->q_depth)) {
+		dma_free_coherent(dev->dev, CQ_SIZE(nvmeq->q_depth),
+				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
+		return -ENOMEM;
+	}
+	return 0;
+}
+
 static int nvme_create_io_queues(struct nvme_dev *dev)
 {
 	unsigned i, max;
@@ -1384,6 +1430,14 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 
 	max = min(dev->max_qid, dev->queue_count - 1);
 	for (i = dev->online_queues; i <= max; i++) {
+		if (nvme_queue_needs_remap(dev, dev->queues[i])) {
+			ret = nvme_remap_queue(dev, dev->queues[i]);
+			if (ret) {
+				nvme_free_queues(dev, i);
+				break;
+			}
+		}
+
 		ret = nvme_create_queue(dev->queues[i], i);
 		if (ret) {
 			nvme_free_queues(dev, i);
@@ -1400,31 +1454,33 @@ static int nvme_create_io_queues(struct nvme_dev *dev)
 	return ret >= 0 ? 0 : ret;
 }
 
-static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
+static int nvme_pci_map_cmb(struct nvme_ctrl *ctrl)
 {
 	u64 szu, size, offset;
-	u32 cmbloc;
+	u32 cmbsz, cmbloc;
 	resource_size_t bar_size;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	void __iomem *cmb;
+	struct nvme_cmb *cmb = ctrl->cmb;
+	struct pci_dev *pdev = to_pci_dev(ctrl->dev);
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
 	dma_addr_t dma_addr;
+	void __iomem *cmb_ioaddr;
 
-	if (!use_cmb_sqes)
-		return NULL;
-
-	dev->cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
-	if (!(NVME_CMB_SZ(dev->cmbsz)))
-		return NULL;
+	cmbsz = readl(dev->bar + NVME_REG_CMBSZ);
+	if (!(NVME_CMB_SZ(cmbsz)))
+		return -EINVAL;
 
 	cmbloc = readl(dev->bar + NVME_REG_CMBLOC);
 
-	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(dev->cmbsz));
-	size = szu * NVME_CMB_SZ(dev->cmbsz);
+	szu = (u64)1 << (12 + 4 * NVME_CMB_SZU(cmbsz));
+	size = szu * NVME_CMB_SZ(cmbsz);
 	offset = szu * NVME_CMB_OFST(cmbloc);
 	bar_size = pci_resource_len(pdev, NVME_CMB_BIR(cmbloc));
 
-	if (offset > bar_size)
-		return NULL;
+	if (offset > bar_size) {
+		dev_warn(dev->dev, "CMB supported but offset does not fit "
+			"within bar (%#llx/%#llx)\n", offset, bar_size);
+		return -ENOMEM;
+	}
 
 	/*
 	 * Controllers may support a CMB size larger than their BAR,
@@ -1435,20 +1491,28 @@ static void __iomem *nvme_map_cmb(struct nvme_dev *dev)
 		size = bar_size - offset;
 
 	dma_addr = pci_resource_start(pdev, NVME_CMB_BIR(cmbloc)) + offset;
-	cmb = ioremap_wc(dma_addr, size);
-	if (!cmb)
-		return NULL;
+	cmb_ioaddr = ioremap_wc(dma_addr, size);
+	if (!cmb_ioaddr)
+		return -ENOMEM;
 
-	dev->cmb_dma_addr = dma_addr;
-	dev->cmb_size = size;
-	return cmb;
+	cmb->cmb = cmb_ioaddr;
+	cmb->dma_addr = dma_addr;
+	cmb->size = size;
+	cmb->flags |= NVME_CMB_SQS(cmbsz) ? NVME_CMB_SQ_SUPPORTED : 0;
+	cmb->flags |= NVME_CMB_CQS(cmbsz) ? NVME_CMB_CQ_SUPPORTED : 0;
+	cmb->flags |= NVME_CMB_WDS(cmbsz) ? NVME_CMB_WD_SUPPORTED : 0;
+	cmb->flags |= NVME_CMB_RDS(cmbsz) ? NVME_CMB_RD_SUPPORTED : 0;
+	cmb->flags |= NVME_CMB_LISTS(cmbsz) ? NVME_CMB_PRP_SUPPORTED : 0;
+	return 0;
 }
 
-static inline void nvme_release_cmb(struct nvme_dev *dev)
+static void nvme_pci_unmap_cmb(struct nvme_ctrl *ctrl)
 {
-	if (dev->cmb) {
-		iounmap(dev->cmb);
-		dev->cmb = NULL;
+	struct nvme_cmb *cmb = ctrl->cmb;
+	if (cmb->cmb) {
+		iounmap(cmb->cmb);
+		cmb->cmb = NULL;
+		cmb->dma_addr = 0;
 	}
 }
 
@@ -1461,6 +1525,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = dev->queues[0];
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct nvme_cmb *cmb = dev->ctrl.cmb;
 	int result, i, vecs, nr_io_queues, size;
 
 	nr_io_queues = num_possible_cpus();
@@ -1480,13 +1545,12 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 		result = 0;
 	}
 
-	if (dev->cmb && NVME_CMB_SQS(dev->cmbsz)) {
-		result = nvme_cmb_qdepth(dev, nr_io_queues,
-				sizeof(struct nvme_command));
+	if (cmb->flags & NVME_CMB_SQ_SUPPORTED) {
+		result = nvme_cmb_sq_depth(dev, nr_io_queues);
 		if (result > 0)
 			dev->q_depth = result;
 		else
-			nvme_release_cmb(dev);
+			cmb->sq_depth = 0;
 	}
 
 	size = db_bar_size(dev, nr_io_queues);
@@ -1675,6 +1739,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 			return 0;
 		dev->ctrl.tagset = &dev->tagset;
 	} else {
+		blk_mq_update_nr_hw_requests(&dev->tagset, dev->q_depth);
 		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
 
 		/* Free previously allocated queues that are no longer usable */
@@ -1744,7 +1809,7 @@ static int nvme_dev_map(struct nvme_dev *dev)
 	}
 
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2))
-		dev->cmb = nvme_map_cmb(dev);
+		nvme_map_cmb(&dev->ctrl);
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
@@ -1827,6 +1892,7 @@ static void nvme_dev_list_remove(struct nvme_dev *dev)
 
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
+	struct nvme_cmb *cmb = dev->ctrl.cmb;
 	int i;
 	u32 csts = -1;
 
@@ -1846,6 +1912,9 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 		nvme_disable_io_queues(dev);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
+
+	if (cmb->cmb)
+		nvme_unmap_cmb(&dev->ctrl);
 	nvme_dev_unmap(dev);
 
 	for (i = dev->queue_count - 1; i >= 0; i--)
@@ -2032,6 +2101,8 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.io_incapable		= nvme_pci_io_incapable,
 	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
+	.map_cmb		= nvme_pci_map_cmb,
+	.unmap_cmb		= nvme_pci_unmap_cmb,
 };
 
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
@@ -2118,11 +2189,10 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	nvme_remove_namespaces(&dev->ctrl);
-	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
+	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
-	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
-- 
2.1.4
