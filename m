From: keith.busch@intel.com (Keith Busch)
Date: Fri, 13 Jul 2018 14:56:06 -0600
Subject: [PATCHv4 1/4] nvme: Sync request queues on reset
In-Reply-To: <20180713205609.19701-1-keith.busch@intel.com>
References: <20180713205609.19701-1-keith.busch@intel.com>
Message-ID: <20180713205609.19701-2-keith.busch@intel.com>

This patch fixes races that occur with simultaneous controller
resets by synchronizing request queues prior to initializing the
controller. Withouth this, a thread may attempt disabling a controller
at the same time as we're trying to enable it.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 46df030b2c3f..eeb97dbef7ff 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -101,6 +101,12 @@ static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 
+static void nvme_start_queue(struct nvme_ns *ns)
+{
+	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_kick_requeue_list(ns->queue);
+}
+
 static void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
@@ -3553,7 +3559,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		blk_set_queue_dying(ns->queue);
 
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_queue(ns);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
@@ -3623,11 +3629,22 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
 	down_read(&ctrl->namespaces_rwsem);
 	list_for_each_entry(ns, &ctrl->namespaces, list)
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_queue(ns);
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
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
 int __init nvme_core_init(void)
 {
 	int result = -ENOMEM;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 0c4a33df3b2f..51cf44ad86fd 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -409,6 +409,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		volatile union nvme_result *res);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ba943f211687..b9b83a7a5a52 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2318,6 +2318,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
-- 
2.14.3
