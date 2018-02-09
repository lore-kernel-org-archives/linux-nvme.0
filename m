From: keith.busch@intel.com (Keith Busch)
Date: Fri,  9 Feb 2018 10:41:26 -0700
Subject: [PATCH 2/3] nvme: Sync queues on controller resets
In-Reply-To: <20180209174127.7224-1-keith.busch@intel.com>
References: <20180209174127.7224-1-keith.busch@intel.com>
Message-ID: <20180209174127.7224-2-keith.busch@intel.com>

This patch has the nvme pci driver synchronize request queues to ensure
starting the controller is not racing with a previously running timeout
handler.

Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  1 +
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fd8688cfa47..a9bce23a991f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3542,12 +3542,25 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		blk_mq_unquiesce_queue(ns->queue);
+		blk_mq_kick_requeue_list(ns->queue);
+	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_sync_queue(ns->queue);
+	mutex_unlock(&ctrl->namespaces_mutex);
+}
+EXPORT_SYMBOL_GPL(nvme_sync_queues);
+
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
 	if (!ctrl->ops->reinit_request)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 27e31c00b306..466081e5f680 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -374,6 +374,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 90e276c05f79..7a2e4383c468 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2290,6 +2290,7 @@ static void nvme_reset_work(struct work_struct *work)
 	 */
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
+	nvme_sync_queues(&dev->ctrl);
 
 	/*
 	 * Introduce CONNECTING state from nvme-fc/rdma transports to mark the
-- 
2.14.3
