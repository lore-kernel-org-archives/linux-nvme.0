From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:54 -0600
Subject: [PATCHv3 3/9] nvme: Move all IO out of controller reset
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-4-keith.busch@intel.com>

IO may be retryable, so don't wait for them in the reset path. These
commands may trigger a reset if that IO expires without a completion,
placing it on the requeue list, so waiting for these would deadlock the
reset handler.

To fix the theoretical deadlock, this patch unblocks IO submission from
the reset_work as before, but moves the waiting to the scan_work, where
waiting for IO is safe so that reset_work may proceed to completion. Since
unfreezing the queues now happens in the controller LIVE state, nvme_dev
now tracks if the queues were frozen now to prevent incorrect freeze
depths.

This patch is also renaming the function 'nvme_dev_add' to a
more appropriate name that describes what it's actually doing:
nvme_alloc_io_tags.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c |  2 ++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 46 +++++++++++++++++++++++++++++++---------------
 3 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 33034e469bbc..0f0eb85c64b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3175,6 +3175,8 @@ static void nvme_scan_work(struct work_struct *work)
 	struct nvme_id_ctrl *id;
 	unsigned nn;
 
+	if (ctrl->ops->update_hw_ctx)
+		ctrl->ops->update_hw_ctx(ctrl);
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4f43918cd902..df4d634e0efd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -316,6 +316,7 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	int (*reinit_request)(void *data, struct request *rq);
 	void (*stop_ctrl)(struct nvme_ctrl *ctrl);
+	void (*update_hw_ctx)(struct nvme_ctrl *ctrl);
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bc2e377e029d..243534139df7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -99,6 +99,7 @@ struct nvme_dev {
 	u32 cmbloc;
 	struct nvme_ctrl ctrl;
 	struct completion ioq_wait;
+	bool queues_froze;
 
 	/* shadow doorbell buffer support: */
 	u32 *dbbuf_dbs;
@@ -2075,10 +2076,32 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 	}
 }
 
+static void nvme_pci_update_hw_ctx(struct nvme_ctrl *ctrl)
+{
+	struct nvme_dev *dev = to_nvme_dev(ctrl);
+	bool unfreeze;
+
+	mutex_lock(&dev->shutdown_lock);
+	unfreeze = dev->queues_froze;
+	mutex_unlock(&dev->shutdown_lock);
+
+	if (!unfreeze)
+		return;
+
+	nvme_wait_freeze(&dev->ctrl);
+	blk_mq_update_nr_hw_queues(ctrl->tagset, dev->online_queues - 1);
+	nvme_free_queues(dev, dev->online_queues);
+	nvme_unfreeze(&dev->ctrl);
+
+	mutex_lock(&dev->shutdown_lock);
+	dev->queues_froze = false;
+	mutex_unlock(&dev->shutdown_lock);
+}
+
 /*
  * return error value only when tagset allocation failed
  */
-static int nvme_dev_add(struct nvme_dev *dev)
+static int nvme_alloc_io_tags(struct nvme_dev *dev)
 {
 	int ret;
 
@@ -2106,13 +2129,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		dev->ctrl.tagset = &dev->tagset;
 
 		nvme_dbbuf_set(dev);
-	} else {
-		blk_mq_update_nr_hw_queues(&dev->tagset, dev->online_queues - 1);
-
-		/* Free previously allocated queues that are no longer usable */
-		nvme_free_queues(dev, dev->online_queues);
 	}
-
 	return 0;
 }
 
@@ -2211,7 +2228,10 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	     dev->ctrl.state == NVME_CTRL_RESETTING)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
-		nvme_start_freeze(&dev->ctrl);
+		if (!dev->queues_froze)	{
+			nvme_start_freeze(&dev->ctrl);
+			dev->queues_froze = true;
+		}
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
 			pci_channel_offline(pdev) || !pci_is_enabled(pdev));
 	}
@@ -2388,13 +2408,8 @@ static void nvme_reset_work(struct work_struct *work)
 		nvme_kill_queues(&dev->ctrl);
 		nvme_remove_namespaces(&dev->ctrl);
 		new_state = NVME_CTRL_ADMIN_ONLY;
-	} else {
-		nvme_start_queues(&dev->ctrl);
-		nvme_wait_freeze(&dev->ctrl);
-		/* hit this only when allocate tagset fails */
-		if (nvme_dev_add(dev))
-			new_state = NVME_CTRL_ADMIN_ONLY;
-		nvme_unfreeze(&dev->ctrl);
+	} else if (nvme_alloc_io_tags(dev)) {
+		new_state = NVME_CTRL_ADMIN_ONLY;
 	}
 
 	/*
@@ -2459,6 +2474,7 @@ static const struct nvme_ctrl_ops nvme_pci_ctrl_ops = {
 	.reg_read64		= nvme_pci_reg_read64,
 	.free_ctrl		= nvme_pci_free_ctrl,
 	.submit_async_event	= nvme_pci_submit_async_event,
+	.update_hw_ctx		= nvme_pci_update_hw_ctx,
 	.get_address		= nvme_pci_get_address,
 };
 
-- 
2.14.3
