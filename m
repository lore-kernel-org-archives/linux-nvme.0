From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 22 Jan 2018 15:53:05 +0800
Subject: [PATCH] nvme-pci: ensure nvme_timeout complete before initializing
 procedure
Message-ID: <1516607585-1525-1-git-send-email-jianchao.w.wang@oracle.com>

There could be a nvme_timeout running with nvme_dev_disable in
parallel. The requests held by timeout path cannot be canceled
by nvme_dev_disable. Consequently, the nvme_timeout maybe still
running after nvme_dev_disable completes. Then there could be a
race between nvme_dev_disable in nvme_timeout and initializing
procedure in nvme_reset_work.
nvme_timeout           nvme_reset_work
if (RESETTING)         nvme_dev_disable
    nvme_dev_disable   initializing

To fix it, ensure all the q->timeout_work complete before the
initializing procedure in nvme_reset_work. At the moment, all the
outstanding requests should have been handled by nvme_dev_disable
or nvme_timeout.
So introduce nvme_sync_queues which invokes blk_sync_queue. In
addition to this, add blk_mq_kick_requeue_list into nvme_start_queues
and nvme_kill_queues to avoid IO hang in requeue_list, because
blk_sync_queue will cancel the requeue_work.

Link: https://lkml.org/lkml/2018/1/19/68
Suggested-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++--
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  9 ++++++++-
 3 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23b3e53..c2ea8adb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3443,7 +3443,11 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
 
-		/* Forcibly unquiesce queues to avoid blocking dispatch */
+		/*
+		 * Forcibly kick requeue and unquiesce queues to avoid blocking
+		 * dispatch
+		 */
+		blk_mq_kick_requeue_list(ns->queue);
 		blk_mq_unquiesce_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
@@ -3513,12 +3517,24 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		blk_mq_kick_requeue_list(ns->queue);
 		blk_mq_unquiesce_queue(ns->queue);
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
 int nvme_reinit_tagset(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set)
 {
 	if (!ctrl->ops->reinit_request)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a44eeca..01faea6 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -370,6 +370,7 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f5207bc..9ba7e55 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2318,8 +2318,15 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
 		nvme_dev_disable(dev, false);
+		/* nvme_timeout could run in parallel, consequently,
+		 * nvme_dev_disable invoked by nvme_timeout could race with
+		 * following initializing procedure. So add nvme_sync_queues
+		 * here to ensure nvme_timeout to be completed.
+		 */
+		nvme_sync_queues(&dev->ctrl);
+	}
 
 	/*
 	 * Introduce RECONNECTING state from nvme-fc/rdma transports to mark the
-- 
2.7.4
