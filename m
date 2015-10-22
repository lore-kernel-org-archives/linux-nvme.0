From: keith.busch@intel.com (Busch, Keith)
Date: Thu, 22 Oct 2015 20:36:50 +0000
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <20151022181240.GA22482@lst.de>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
 <20151022181014.GE21840@localhost.localdomain>
 <20151022181240.GA22482@lst.de>
Message-ID: <20151022203650.GF21840@localhost.localdomain>

On Thu, Oct 22, 2015@08:12:40PM +0200, Christoph Hellwig wrote:
> Oops - I'm queing it both on the system workqueue and nvme_workq, which
> is clearly broken.  I'll fix it in the next resend.

Ha, let's just get rid of nvme_workq.

I've got that plus a couple other fixups below. I noticed that earlier
in the recent changes (18/18 from the previous series) we lost the
"device_remove_file()" on the reset controller attribute. We also don't
want to leave the nvme management handle available when we're trying to
release it, so we need to delete the sysfs and char dev immediately on
removal instead of after all references are released.

This fixes a WARN in fs/sysfs/group.c line 222.

Here's all my "fixes", also pushed to my linux-nvme master:
---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f4075f1..ebeb797 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -919,18 +919,22 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 	spin_unlock(&dev_list_lock);
 }
 
-static void nvme_free_ctrl(struct kref *kref)
+void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
+	device_remove_file(ctrl->device, &dev_attr_reset_controller);
+	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
+}
+
+static void nvme_free_ctrl(struct kref *kref)
+{
+	struct nvme_ctrl *ctrl = container_of(kref, struct nvme_ctrl, kref);
 
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
-	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
-
 	ctrl->ops->free_ctrl(ctrl);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1658048..a879f9e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -189,6 +189,7 @@ static inline int nvme_error_status(u16 status)
 	}
 }
 
+void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, u16 vendor,
 		unsigned long quirks);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 437c3dc..e20952d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -69,7 +69,6 @@ MODULE_PARM_DESC(use_cmb_sqes, "use controller's memory buffer for I/O SQes");
 
 static LIST_HEAD(dev_list);
 static struct task_struct *nvme_thread;
-static struct workqueue_struct *nvme_workq;
 static wait_queue_head_t nvme_kthread_wait;
 
 struct nvme_dev;
@@ -1057,12 +1056,10 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * the admin queue.
 	 */
 	if (!nvmeq->qid || cmd_rq->aborted) {
-		if (queue_work(nvme_workq, &dev->reset_work)) {
+		if (schedule_work(&dev->reset_work))
 			dev_warn(dev->dev,
 				 "I/O %d QID %d timeout, reset controller\n",
 				 req->tag, nvmeq->qid);
-		}
-
 		req->errors = -EIO;
 		return BLK_EH_HANDLED;
 	}
@@ -1563,7 +1560,7 @@ static int nvme_kthread(void *data)
 
 			if ((dev->subsystem && (csts & NVME_CSTS_NSSRO)) ||
 							csts & NVME_CSTS_CFS) {
-				if (queue_work(nvme_workq, &dev->reset_work)) {
+				if (schedule_work(&dev->reset_work)) {
 					dev_warn(dev->dev,
 						"Failed status: %x, reset controller\n",
 						readl(dev->bar + NVME_REG_CSTS));
@@ -2284,7 +2281,7 @@ static int nvme_reset(struct nvme_dev *dev)
 	if (!dev->ctrl.admin_q || blk_queue_dying(dev->ctrl.admin_q))
 		return -ENODEV;
 
-	if (!queue_work(nvme_workq, &dev->reset_work))
+	if (!schedule_work(&dev->reset_work))
 		return -EBUSY;
 
 	flush_work(&dev->reset_work);
@@ -2412,6 +2409,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
+	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_free_queues(dev, 0);
 	nvme_release_cmb(dev);
 	nvme_release_prp_pools(dev);
@@ -2485,13 +2483,9 @@ static int __init nvme_init(void)
 
 	init_waitqueue_head(&nvme_kthread_wait);
 
-	nvme_workq = create_singlethread_workqueue("nvme");
-	if (!nvme_workq)
-		return -ENOMEM;
-
 	result = nvme_core_init();
 	if (result < 0)
-		goto kill_workq;
+		return result;
 
 	result = pci_register_driver(&nvme_driver);
 	if (result)
@@ -2500,8 +2494,6 @@ static int __init nvme_init(void)
 
  core_exit:
 	nvme_core_exit();
- kill_workq:
-	destroy_workqueue(nvme_workq);
 	return result;
 }
 
@@ -2509,7 +2501,6 @@ static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
 	nvme_core_exit();
-	destroy_workqueue(nvme_workq);
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
 }
--
