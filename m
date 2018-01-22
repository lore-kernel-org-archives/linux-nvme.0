From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:56:30 -0700
Subject: [PATCH 5/5] nvme: Sync queues on controller resets
In-Reply-To: <20180122215630.13697-1-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
Message-ID: <20180122215630.13697-5-keith.busch@intel.com>

This patch has the nvme pci driver synchronize request queues to ensure
that starting up the controller is not racing with a previously running
timeout handler.

Reported-by: Jianchao Wang <jianchao.w.wang at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 15 ++++++++++++++-
 drivers/nvme/host/nvme.h |  1 +
 drivers/nvme/host/pci.c  |  4 +++-
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ae4349a4f3a8..e8826fab54b8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3578,12 +3578,25 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
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
index 96fbc233cbb2..6e80912fe707 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -384,6 +384,7 @@ void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
+void nvme_sync_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
 void nvme_unfreeze(struct nvme_ctrl *ctrl);
 void nvme_wait_freeze(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 99ac0de43206..2de40d1780c1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2293,8 +2293,10 @@ static void nvme_reset_work(struct work_struct *work)
 	 * If we're called to reset a live controller first shut it down before
 	 * moving on.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
 		nvme_dev_disable(dev, false);
+		nvme_sync_queues(&dev->ctrl);
+	}
 
 	result = nvme_pci_enable(dev);
 	if (result)
-- 
2.14.3
