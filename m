From: hch@lst.de (Christoph Hellwig)
Date: Thu,  8 Jun 2017 15:08:36 +0200
Subject: [PATCH] nvme: move reset workqueue handling to common code
Message-ID: <20170608130836.31891-1-hch@lst.de>

This moves the nvme_reset function from the PCIe driver to common code,
renaming it to nvme_reset_ctrl in the process.  Additionally a new
helper nvme_reset_ctrl_sync is added for the case where we want to
wait for the reset.  To facilitate that the reset_work work structure is
move to the common nvme_ctrl structure and the ->reset_ctrl method is
removed.  For now the drivers initialize the reset_work with their own
callback, but longer term we should move to callouts for specific
parts of the reset process and move even more code to the core.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c   | 28 +++++++++++++++++++++++++---
 drivers/nvme/host/fc.c     | 36 ++++--------------------------------
 drivers/nvme/host/nvme.h   |  3 ++-
 drivers/nvme/host/pci.c    | 45 +++++++++++----------------------------------
 drivers/nvme/host/rdma.c   | 23 +++--------------------
 drivers/nvme/target/loop.c | 25 ++++---------------------
 6 files changed, 49 insertions(+), 111 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4026d96e65de..afba749cac31 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -73,6 +73,28 @@ static DEFINE_SPINLOCK(dev_list_lock);
 
 static struct class *nvme_class;
 
+int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
+{
+	if (!ctrl->admin_q || blk_queue_dying(ctrl->admin_q))
+		return -ENODEV;
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		return -EBUSY;
+	if (!queue_work(nvme_wq, &ctrl->reset_work))
+		return -EBUSY;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_reset_ctrl);
+
+static int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl)
+{
+	int ret;
+
+	ret = nvme_reset_ctrl(ctrl);
+	if (!ret)
+		flush_work(&ctrl->reset_work);
+	return ret;
+}
+
 static int nvme_error_status(struct request *req)
 {
 	switch (nvme_req(req)->status & 0x7ff) {
@@ -601,7 +623,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	if (nvme_keep_alive(ctrl)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed\n");
-		ctrl->ops->reset_ctrl(ctrl);
+		nvme_reset_ctrl_sync(ctrl);
 		return;
 	}
 }
@@ -1739,7 +1761,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
 		dev_warn(ctrl->device, "resetting controller\n");
-		return ctrl->ops->reset_ctrl(ctrl);
+		return nvme_reset_ctrl_sync(ctrl);
 	case NVME_IOCTL_SUBSYS_RESET:
 		return nvme_reset_subsystem(ctrl);
 	case NVME_IOCTL_RESCAN:
@@ -1765,7 +1787,7 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
 	int ret;
 
-	ret = ctrl->ops->reset_ctrl(ctrl);
+	ret = nvme_reset_ctrl_sync(ctrl);
 	if (ret < 0)
 		return ret;
 	return count;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e8504a8c2a9a..5c956c53bf13 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -161,7 +161,6 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct work_struct	delete_work;
-	struct work_struct	reset_work;
 	struct delayed_work	connect_work;
 
 	struct kref		ref;
@@ -1775,10 +1774,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 		return;
 	}
 
-	if (!queue_work(nvme_wq, &ctrl->reset_work))
-		dev_err(ctrl->ctrl.device,
-			"NVME-FC{%d}: error_recovery: Failed to schedule "
-			"reset work\n", ctrl->cnum);
+	nvme_reset_ctrl(&ctrl->ctrl);
 }
 
 static enum blk_eh_timer_return
@@ -2527,7 +2523,7 @@ nvme_fc_delete_ctrl_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 		container_of(work, struct nvme_fc_ctrl, delete_work);
 
-	cancel_work_sync(&ctrl->reset_work);
+	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	/*
@@ -2621,7 +2617,7 @@ static void
 nvme_fc_reset_ctrl_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *ctrl =
-			container_of(work, struct nvme_fc_ctrl, reset_work);
+		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 	int ret;
 
 	/* will block will waiting for io to terminate */
@@ -2635,29 +2631,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 			"NVME-FC{%d}: controller reset complete\n", ctrl->cnum);
 }
 
-/*
- * called by the nvme core layer, for sysfs interface that requests
- * a reset of the nvme controller
- */
-static int
-nvme_fc_reset_nvme_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
-
-	dev_info(ctrl->ctrl.device,
-		"NVME-FC{%d}: admin requested controller reset\n", ctrl->cnum);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return -EBUSY;
-
-	if (!queue_work(nvme_wq, &ctrl->reset_work))
-		return -EBUSY;
-
-	flush_work(&ctrl->reset_work);
-
-	return 0;
-}
-
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
 	.module			= THIS_MODULE,
@@ -2665,7 +2638,6 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.reset_ctrl		= nvme_fc_reset_nvme_ctrl,
 	.free_ctrl		= nvme_fc_nvme_ctrl_freed,
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_del_nvme_ctrl,
@@ -2740,7 +2712,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	kref_init(&ctrl->ref);
 
 	INIT_WORK(&ctrl->delete_work, nvme_fc_delete_ctrl_work);
-	INIT_WORK(&ctrl->reset_work, nvme_fc_reset_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
 	spin_lock_init(&ctrl->lock);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 436acf78b01d..0196777313f7 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -133,6 +133,7 @@ struct nvme_ctrl {
 	struct device *device;	/* char device */
 	struct list_head node;
 	struct ida ns_ida;
+	struct work_struct reset_work;
 
 	struct opal_dev *opal_dev;
 
@@ -220,7 +221,6 @@ struct nvme_ctrl_ops {
 	int (*reg_read32)(struct nvme_ctrl *ctrl, u32 off, u32 *val);
 	int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val);
 	int (*reg_read64)(struct nvme_ctrl *ctrl, u32 off, u64 *val);
-	int (*reset_ctrl)(struct nvme_ctrl *ctrl);
 	void (*free_ctrl)(struct nvme_ctrl *ctrl);
 	void (*submit_async_event)(struct nvme_ctrl *ctrl, int aer_idx);
 	int (*delete_ctrl)(struct nvme_ctrl *ctrl);
@@ -327,6 +327,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_start_keep_alive(struct nvme_ctrl *ctrl);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 
 struct sg_io_hdr;
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5c835be7ccaa..5564a3bd647c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -74,7 +74,6 @@ MODULE_PARM_DESC(max_host_mem_size_mb,
 struct nvme_dev;
 struct nvme_queue;
 
-static int nvme_reset(struct nvme_dev *dev);
 static void nvme_process_cq(struct nvme_queue *nvmeq);
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 
@@ -96,7 +95,6 @@ struct nvme_dev {
 	u32 db_stride;
 	void __iomem *bar;
 	unsigned long bar_mapped_size;
-	struct work_struct reset_work;
 	struct work_struct remove_work;
 	struct mutex shutdown_lock;
 	bool subsystem;
@@ -1021,7 +1019,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	if (nvme_should_reset(dev, readl(dev->bar + NVME_REG_CSTS))) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
-		nvme_reset(dev);
+		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_HANDLED;
 	}
 
@@ -1060,7 +1058,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-		nvme_reset(dev);
+		nvme_reset_ctrl(&dev->ctrl);
 
 		/*
 		 * Mark the request as handled, since the inline shutdown
@@ -2091,7 +2089,8 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 
 static void nvme_reset_work(struct work_struct *work)
 {
-	struct nvme_dev *dev = container_of(work, struct nvme_dev, reset_work);
+	struct nvme_dev *dev =
+		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 
@@ -2195,17 +2194,6 @@ static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_reset(struct nvme_dev *dev)
-{
-	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
-		return -ENODEV;
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
-		return -EBUSY;
-	if (!queue_work(nvme_wq, &dev->reset_work))
-		return -EBUSY;
-	return 0;
-}
-
 static int nvme_pci_reg_read32(struct nvme_ctrl *ctrl, u32 off, u32 *val)
 {
 	*val = readl(to_nvme_dev(ctrl)->bar + off);
@@ -2224,16 +2212,6 @@ static int nvme_pci_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 	return 0;
 }
 
-static int nvme_pci_reset_ctrl(struct nvme_ctrl *ctrl)
-{
-	struct nvme_dev *dev = to_nvme_dev(ctrl);
-	int ret = nvme_reset(dev);
-
-	if (!ret)
-		flush_work(&dev->reset_work);
-	return ret;
-}
-
 static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.name			= "pcie",
 	.module			= THIS_MODULE,
@@ -2241,7 +2219,6 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read32		= nvme_pci_reg_read32,
 	.reg_write32		= nvme_pci_reg_write32,
 	.reg_read64		= nvme_pci_reg_read64,
-	.reset_ctrl		= nvme_pci_reset_ctrl,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
 };
@@ -2307,7 +2284,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto free;
 
-	INIT_WORK(&dev->reset_work, nvme_reset_work);
+	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
 	mutex_init(&dev->shutdown_lock);
 	init_completion(&dev->ioq_wait);
@@ -2326,7 +2303,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING);
 	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
 
-	queue_work(nvme_wq, &dev->reset_work);
+	queue_work(nvme_wq, &dev->ctrl.reset_work);
 	return 0;
 
  release_pools:
@@ -2347,7 +2324,7 @@ static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
 	if (prepare)
 		nvme_dev_disable(dev, false);
 	else
-		nvme_reset(dev);
+		nvme_reset_ctrl(&dev->ctrl);
 }
 
 static void nvme_shutdown(struct pci_dev *pdev)
@@ -2367,7 +2344,7 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
-	cancel_work_sync(&dev->reset_work);
+	cancel_work_sync(&dev->ctrl.reset_work);
 	pci_set_drvdata(pdev, NULL);
 
 	if (!pci_device_is_present(pdev)) {
@@ -2375,7 +2352,7 @@ static void nvme_remove(struct pci_dev *pdev)
 		nvme_dev_disable(dev, false);
 	}
 
-	flush_work(&dev->reset_work);
+	flush_work(&dev->ctrl.reset_work);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_free_host_mem(dev);
@@ -2419,7 +2396,7 @@ static int nvme_resume(struct device *dev)
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct nvme_dev *ndev = pci_get_drvdata(pdev);
 
-	nvme_reset(ndev);
+	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
 }
 #endif
@@ -2458,7 +2435,7 @@ static pci_ers_result_t nvme_slot_reset(struct pci_dev *pdev)
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset(dev);
+	nvme_reset_ctrl(&dev->ctrl);
 	return PCI_ERS_RESULT_RECOVERED;
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index d0aa1dae921b..c0934b13c5fd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -108,7 +108,6 @@ struct nvme_rdma_ctrl {
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
 	struct work_struct	delete_work;
-	struct work_struct	reset_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1723,8 +1722,8 @@ static void nvme_rdma_remove_ctrl_work(struct work_struct *work)
 
 static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
-					struct nvme_rdma_ctrl, reset_work);
+	struct nvme_rdma_ctrl *ctrl =
+		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 	bool changed;
 
@@ -1768,21 +1767,6 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	WARN_ON(!queue_work(nvme_wq, &ctrl->delete_work));
 }
 
-static int nvme_rdma_reset_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return -EBUSY;
-
-	if (!queue_work(nvme_wq, &ctrl->reset_work))
-		return -EBUSY;
-
-	flush_work(&ctrl->reset_work);
-
-	return 0;
-}
-
 static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.name			= "rdma",
 	.module			= THIS_MODULE,
@@ -1790,7 +1774,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.reset_ctrl		= nvme_rdma_reset_ctrl,
 	.free_ctrl		= nvme_rdma_free_ctrl,
 	.submit_async_event	= nvme_rdma_submit_async_event,
 	.delete_ctrl		= nvme_rdma_del_ctrl,
@@ -1899,7 +1882,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 			nvme_rdma_reconnect_ctrl_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->delete_work, nvme_rdma_del_ctrl_work);
-	INIT_WORK(&ctrl->reset_work, nvme_rdma_reset_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 4ca30a451608..f1554bef25f9 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -58,7 +58,6 @@ struct nvme_loop_ctrl {
 
 	struct nvmet_ctrl	*target_ctrl;
 	struct work_struct	delete_work;
-	struct work_struct	reset_work;
 };
 
 static inline struct nvme_loop_ctrl *to_loop_ctrl(struct nvme_ctrl *ctrl)
@@ -150,7 +149,7 @@ nvme_loop_timeout(struct request *rq, bool reserved)
 	struct nvme_loop_iod *iod = blk_mq_rq_to_pdu(rq);
 
 	/* queue error recovery */
-	queue_work(nvme_wq, &iod->queue->ctrl->reset_work);
+	nvme_reset_ctrl(&iod->queue->ctrl->ctrl);
 
 	/* fail with DNR on admin cmd timeout */
 	nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
@@ -500,8 +499,8 @@ static void nvme_loop_delete_ctrl(struct nvmet_ctrl *nctrl)
 
 static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 {
-	struct nvme_loop_ctrl *ctrl = container_of(work,
-					struct nvme_loop_ctrl, reset_work);
+	struct nvme_loop_ctrl *ctrl =
+		container_of(work, struct nvme_loop_ctrl, ctrl.reset_work);
 	bool changed;
 	int ret;
 
@@ -539,21 +538,6 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
-static int nvme_loop_reset_ctrl(struct nvme_ctrl *nctrl)
-{
-	struct nvme_loop_ctrl *ctrl = to_loop_ctrl(nctrl);
-
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
-		return -EBUSY;
-
-	if (!queue_work(nvme_wq, &ctrl->reset_work))
-		return -EBUSY;
-
-	flush_work(&ctrl->reset_work);
-
-	return 0;
-}
-
 static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.name			= "loop",
 	.module			= THIS_MODULE,
@@ -561,7 +545,6 @@ static const struct nvme_ctrl_ops nvme_loop_ctrl_ops = {
 	.reg_read32		= nvmf_reg_read32,
 	.reg_read64		= nvmf_reg_read64,
 	.reg_write32		= nvmf_reg_write32,
-	.reset_ctrl		= nvme_loop_reset_ctrl,
 	.free_ctrl		= nvme_loop_free_ctrl,
 	.submit_async_event	= nvme_loop_submit_async_event,
 	.delete_ctrl		= nvme_loop_del_ctrl,
@@ -628,7 +611,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	INIT_LIST_HEAD(&ctrl->list);
 
 	INIT_WORK(&ctrl->delete_work, nvme_loop_del_ctrl_work);
-	INIT_WORK(&ctrl->reset_work, nvme_loop_reset_ctrl_work);
+	INIT_WORK(&ctrl->ctrl.reset_work, nvme_loop_reset_ctrl_work);
 
 	ret = nvme_init_ctrl(&ctrl->ctrl, dev, &nvme_loop_ctrl_ops,
 				0 /* no quirks, we're perfect! */);
-- 
2.11.0
