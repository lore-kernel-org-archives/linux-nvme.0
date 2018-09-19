From: keith.busch@intel.com (Keith Busch)
Date: Wed, 19 Sep 2018 09:48:52 -0600
Subject: [PATCH] nvme/pci: Fix hot removal during error handling
Message-ID: <20180919154852.28187-1-keith.busch@intel.com>

A removal waits for the reset_work to complete. If a surprise removal
occurs around the same time as an error triggered controller reset,
and reset work happened to dispatch a command to the removed controller,
the command won't be recovered since the timeout work doesn't do
anything during error recovery.

This patch fixes this by killing admin queues prior to syncing reset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 4 +++-
 drivers/nvme/host/pci.c  | 9 ++++-----
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dd8ec1dd9219..893f1fcc17cd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3592,8 +3592,10 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	down_read(&ctrl->namespaces_rwsem);
 
 	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q)
+	if (ctrl->admin_q) {
+		blk_set_queue_dying(ctrl->admin_q);
 		blk_mq_unquiesce_queue(ctrl->admin_q);
+	}
 
 	list_for_each_entry(ns, &ctrl->namespaces, list)
 		nvme_set_queue_dying(ns);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d668682f91df..800ee9b345f3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1470,7 +1470,7 @@ static const struct blk_mq_ops nvme_mq_ops = {
 
 static void nvme_dev_remove_admin(struct nvme_dev *dev)
 {
-	if (dev->ctrl.admin_q && !blk_queue_dying(dev->ctrl.admin_q)) {
+	if (dev->ctrl.admin_q) {
 		/*
 		 * If the controller was reset during removal, it's possible
 		 * user requests may be waiting on a stopped queue. Start the
@@ -1479,6 +1479,7 @@ static void nvme_dev_remove_admin(struct nvme_dev *dev)
 		blk_mq_unquiesce_queue(dev->ctrl.admin_q);
 		blk_cleanup_queue(dev->ctrl.admin_q);
 		blk_mq_free_tag_set(&dev->admin_tagset);
+		dev->ctrl.admin_q = NULL;
 	}
 }
 
@@ -2565,15 +2566,13 @@ static void nvme_remove(struct pci_dev *pdev)
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
 
-	cancel_work_sync(&dev->ctrl.reset_work);
 	pci_set_drvdata(pdev, NULL);
-
 	if (!pci_device_is_present(pdev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
+		nvme_kill_queues(&dev->ctrl);
 		nvme_dev_disable(dev, true);
 	}
-
-	flush_work(&dev->ctrl.reset_work);
+	cancel_work_sync(&dev->ctrl.reset_work);
 	nvme_stop_ctrl(&dev->ctrl);
 	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
-- 
2.14.4
