From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:25 -0600
Subject: [PATCHv2 1/8] nvme: Sync request queues on reset
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-2-keith.busch@intel.com>

This patch fixes races that occur with simultaneous controller
resets by synchronizing request queues prior to initializing the
controller. Withouth this, a thread may attempt disabling a controller
at the same time as we're trying to enable it.

After the queues are synced, the driver's reset work will attempt
disabling the device, as this will reclaim any outstanding tags in the
event any of a request was locked out from completing in the previous
reset attempts.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  | 21 +++++++++++++--------
 3 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e5a7a9..1de68b56b318 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3471,6 +3471,12 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 }
 EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
+static void nvme_start_queue(struct nvme_ns *ns)
+{
+	blk_mq_unquiesce_queue(ns->queue);
+	blk_mq_kick_requeue_list(ns->queue);
+}
+
 /**
  * nvme_kill_queues(): Ends all namespace queues
  * @ctrl: the dead controller that needs to end
@@ -3499,7 +3505,7 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		blk_set_queue_dying(ns->queue);
 
 		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
+		nvme_start_queue(ns);
 	}
 	up_read(&ctrl->namespaces_rwsem);
 }
@@ -3569,11 +3575,22 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 
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
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
 	if (!ctrl->ops->reinit_request)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 17d2f7cf3fed..c15c2ee7f61a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -407,6 +407,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17a0190bd88f..deb44c27cdaf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2217,16 +2217,18 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 
 	nvme_stop_queues(&dev->ctrl);
 
-	if (!dead && dev->ctrl.queue_count > 0) {
+	if (dev->ctrl.queue_count > 0) {
 		/*
 		 * If the controller is still alive tell it to stop using the
 		 * host memory buffer.  In theory the shutdown / reset should
 		 * make sure that it doesn't access the host memoery anymore,
 		 * but I'd rather be safe than sorry..
 		 */
-		if (dev->host_mem_descs)
-			nvme_set_host_mem(dev, 0);
-		nvme_disable_io_queues(dev);
+		if (!dead) {
+			if (dev->host_mem_descs)
+				nvme_set_host_mem(dev, 0);
+			nvme_disable_io_queues(dev);
+		}
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
@@ -2307,11 +2309,14 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	/*
-	 * If we're called to reset a live controller first shut it down before
-	 * moving on.
+	 * Ensure there are no timeout work in progress prior to forcefully
+	 * disabling the queue. There is no harm in disabling the device even
+	 * when it was already disabled, as this will forcefully reclaim any
+	 * IOs that are stuck due to blk-mq's timeout handling that prevents
+	 * timed out requests from completing.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
-		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
+	nvme_dev_disable(dev, false);
 
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
-- 
2.14.3
