From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:56:27 -0700
Subject: [PATCH 2/5] nvme: Ending failed unstarted requests
In-Reply-To: <20180122215630.13697-1-keith.busch@intel.com>
References: <20180122215630.13697-1-keith.busch@intel.com>
Message-ID: <20180122215630.13697-2-keith.busch@intel.com>

This patch provides new nvme driver APIs for directly ending unstarted
requests when they need to be failed. Previously, drivers needed to
temporarily quiesce request queues while setting up the IO path to take on
the responsibilty of error handling, then restart those queues. Handling
these errors should be done directly in the error handling path, freeing
up the IO path to not concern itself with such failure cases.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 44 +++++++++++++++++++++++++++++++++++---------
 drivers/nvme/host/nvme.h |  4 ++++
 drivers/nvme/host/pci.c  |  4 ++--
 drivers/nvme/host/rdma.c |  8 +++-----
 4 files changed, 44 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b9cf2bce2132..ae4349a4f3a8 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -246,6 +246,17 @@ static void nvme_cancel_request(struct request *req, void *data, bool reserved)
 
 }
 
+static void nvme_end_unstarted_request(struct request *req, void *data,
+				       bool reserved)
+{
+	if (blk_mq_request_started(req))
+		return;
+
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
+				"Ending I/O %d", req->tag);
+	blk_mq_end_request(req, BLK_STS_IOERR);
+}
+
 void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 		   busy_tag_iter_fn *fn)
 {
@@ -255,6 +266,25 @@ void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
 }
 EXPORT_SYMBOL_GPL(nvme_set_iter);
 
+void nvme_end_io_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_set_iter(ctrl, ctrl->tagset, nvme_end_unstarted_request);
+}
+EXPORT_SYMBOL_GPL(nvme_end_io_requests);
+
+void nvme_end_admin_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_set_iter(ctrl, ctrl->admin_tagset, nvme_end_unstarted_request);
+}
+EXPORT_SYMBOL_GPL(nvme_end_admin_requests);
+
+void nvme_end_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_end_io_requests(ctrl);
+	nvme_end_admin_requests(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_end_requests);
+
 void nvme_cancel_io_requests(struct nvme_ctrl *ctrl)
 {
 	nvme_set_iter(ctrl, ctrl->tagset, nvme_cancel_request);
@@ -3215,8 +3245,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	 * removing the namespaces' disks; fail all the queues now to avoid
 	 * potentially having to clean up the failed sync later.
 	 */
-	if (ctrl->state == NVME_CTRL_DEAD)
+	if (ctrl->state == NVME_CTRL_DEAD) {
 		nvme_kill_queues(ctrl);
+		nvme_end_admin_requests(ctrl);
+	}
 
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
@@ -3467,11 +3499,6 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	mutex_lock(&ctrl->namespaces_mutex);
-
-	/* Forcibly unquiesce queues to avoid blocking dispatch */
-	if (ctrl->admin_q)
-		blk_mq_unquiesce_queue(ctrl->admin_q);
-
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		/*
 		 * Revalidating a dead namespace sets capacity to 0. This will
@@ -3481,11 +3508,10 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 			continue;
 		revalidate_disk(ns->disk);
 		blk_set_queue_dying(ns->queue);
-
-		/* Forcibly unquiesce queues to avoid blocking dispatch */
-		blk_mq_unquiesce_queue(ns->queue);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
+
+	nvme_end_io_requests(ctrl);
 }
 EXPORT_SYMBOL_GPL(nvme_kill_queues);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 5fb9d600f9c0..96fbc233cbb2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -371,6 +371,10 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_end_requests(struct nvme_ctrl *ctrl);
+void nvme_end_io_requests(struct nvme_ctrl *ctrl);
+void nvme_end_admin_requests(struct nvme_ctrl *ctrl);
+
 void nvme_cancel_requests(struct nvme_ctrl *ctrl);
 void nvme_cancel_io_requests(struct nvme_ctrl *ctrl);
 void nvme_cancel_admin_requests(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4d2477c3c86c..63b477bfef37 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2216,11 +2216,11 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_cancel_requests(&dev->ctrl);
 	/*
 	 * The driver will not be starting up queues again if shutting down so
-	 * must flush all entered requests to their failed completion to avoid
+	 * must end all entered requests to their failed completion to avoid
 	 * deadlocking blk-mq hot-cpu notifier.
 	 */
 	if (shutdown)
-		nvme_start_queues(&dev->ctrl);
+		nvme_end_requests(&dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 71070eedb773..e51a84d1d732 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -966,11 +966,9 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 
 	/*
-	 * queues are not a live anymore, so restart the queues to fail fast
-	 * new IO
+	 * queues are not a live anymore, so end all unstarted requests.
 	 */
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	nvme_start_queues(&ctrl->ctrl);
+	nvme_end_requests(&ctrl->ctrl);
 
 	nvme_rdma_reconnect_or_remove(ctrl);
 }
@@ -1730,7 +1728,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	nvme_cancel_admin_requests(&ctrl->ctrl);
-	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
+	nvme_end_admin_requests(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
-- 
2.14.3
