From: mr.nuke.me@gmail.com (Alexandru Gagniuc)
Date: Thu, 10 May 2018 11:46:33 -0500
Subject: [PATCH] nvme-pci: Avoid use of goto in nvme_reset_work()
Message-ID: <20180510164645.19559-1-mr.nuke.me@gmail.com>

This patch started as a challenge from Keith relating to code
structuring with goto vs return. I think the final result improves
readability on two counts:
First, it clarifies the separation between work struct and nvme_dev.
Second, it makes it clearer what error is being passed on:
'return -ENODEV' vs 'goto out', where 'result' happens to be -ENODEV

CC: Keith Busch <keith.busch at intel.com>
Signed-off-by: Alexandru Gagniuc <mr.nuke.me at gmail.com>
---
 drivers/nvme/host/pci.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fbc71fac6f1e..bac7d30a10a7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2286,16 +2286,14 @@ static void nvme_remove_dead_ctrl(struct nvme_dev *dev, int status)
 		nvme_put_ctrl(&dev->ctrl);
 }
 
-static void nvme_reset_work(struct work_struct *work)
+static int do_nvme_reset_work(struct nvme_dev *dev)
 {
-	struct nvme_dev *dev =
-		container_of(work, struct nvme_dev, ctrl.reset_work);
 	bool was_suspend = !!(dev->ctrl.ctrl_config & NVME_CC_SHN_NORMAL);
 	int result = -ENODEV;
 	enum nvme_ctrl_state new_state = NVME_CTRL_LIVE;
 
 	if (WARN_ON(dev->ctrl.state != NVME_CTRL_RESETTING))
-		goto out;
+		return -ENODEV;
 
 	/*
 	 * If we're called to reset a live controller first shut it down before
@@ -2310,30 +2308,30 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_CONNECTING)) {
 		dev_warn(dev->ctrl.device,
-			"failed to mark controller CONNECTING\n");
-		goto out;
+			 "failed to mark controller CONNECTING\n");
+		return -ENODEV;
 	}
 
 	result = nvme_pci_enable(dev);
 	if (result)
-		goto out;
+		return result;
 
 	result = nvme_pci_configure_admin_queue(dev);
 	if (result)
-		goto out;
+		return result;
 
 	result = nvme_alloc_admin_tags(dev);
 	if (result)
-		goto out;
+		return result;
 
 	result = nvme_init_identify(&dev->ctrl);
 	if (result)
-		goto out;
+		return result;
 
 	if (dev->ctrl.oacs & NVME_CTRL_OACS_SEC_SUPP) {
 		if (!dev->ctrl.opal_dev)
 			dev->ctrl.opal_dev =
-				init_opal_dev(&dev->ctrl, &nvme_sec_submit);
+			init_opal_dev(&dev->ctrl, &nvme_sec_submit);
 		else if (was_suspend)
 			opal_unlock_from_suspend(dev->ctrl.opal_dev);
 	} else {
@@ -2351,12 +2349,12 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.hmpre) {
 		result = nvme_setup_host_mem(dev);
 		if (result < 0)
-			goto out;
+			return result;
 	}
 
 	result = nvme_setup_io_queues(dev);
 	if (result)
-		goto out;
+		return result;
 
 	/*
 	 * Keep the controller around but remove all namespaces if we don't have
@@ -2382,15 +2380,23 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (!nvme_change_ctrl_state(&dev->ctrl, new_state)) {
 		dev_warn(dev->ctrl.device,
-			"failed to mark controller state %d\n", new_state);
-		goto out;
+			 "failed to mark controller state %d\n", new_state);
+		return 0;
 	}
 
 	nvme_start_ctrl(&dev->ctrl);
-	return;
+	return 0;
+
+}
+static void nvme_reset_work(struct work_struct *work)
+{
+	struct nvme_dev *dev =
+		container_of(work, struct nvme_dev, ctrl.reset_work);
+	int result;
 
- out:
-	nvme_remove_dead_ctrl(dev, result);
+	result = do_nvme_reset_work(dev);
+	if (result < 0)
+		nvme_remove_dead_ctrl(dev, result);
 }
 
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
-- 
2.14.3
