From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 May 2019 10:36:23 -0600
Subject: [PATCH 4/6] nvme-pci: Sync queues on reset
In-Reply-To: <20190515163625.21776-1-keith.busch@intel.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
Message-ID: <20190515163625.21776-4-keith.busch@intel.com>

A controller with multiple namespaces may have multiple request_queues
with their own timeout work. If a live controller fails with IO
outstanding to diffent namespaces, each request queue may attempt to
disable and reset the controller in different threads. Synchronize each
queue prior to starting the controller to ensure there no previously
scheduled timeout work is running.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d7de0642c832..a116ea037f83 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3880,6 +3880,18 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_sync_queue(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
+EXPORT_SYMBOL_GPL(nvme_sync_queues);
+
 /*
  * Check we didn't inadvertently grow the command structure sizes:
  */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5ee75b5ff83f..55553d293a98 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -441,6 +441,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze_timeout(struct nvme_ctrl *ctrl, long timeout);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8df176ffcbc1..599065ed6a32 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2492,6 +2492,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
 	result = nvme_pci_enable(dev);
-- 
2.14.4
