From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 Jan 2018 14:56:26 -0700
Subject: [PATCH 1/5] nvme: Request cancelling helpers
Message-ID: <20180122215630.13697-1-keith.busch@intel.com>

This patch provides an API for cancelling IO requests, replacing each
driver's use of blk_mq_busy_tag_iter with a more convenient API for nvme
controllers.

The nvme_cancel_request is used only in the core now, so this patch
makes that function private.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c   | 31 +++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h   |  8 +++++++-
 drivers/nvme/host/pci.c    |  4 +---
 drivers/nvme/host/rdma.c   | 12 ++++--------
 drivers/nvme/target/loop.c |  6 ++----
 5 files changed, 43 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fde6fd2e7eef..b9cf2bce2132 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -233,7 +233,7 @@ void nvme_complete_rq(struct request *req)
 }
 EXPORT_SYMBOL_GPL(nvme_complete_rq);
 
-void nvme_cancel_request(struct request *req, void *data, bool reserved)
+static void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
 	if (!blk_mq_request_started(req))
 		return;
@@ -245,7 +245,34 @@ void nvme_cancel_request(struct request *req, void *data, bool reserved)
 	blk_mq_complete_request(req);
 
 }
-EXPORT_SYMBOL_GPL(nvme_cancel_request);
+
+void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		   busy_tag_iter_fn *fn)
+{
+	if (!set)
+		return;
+	blk_mq_tagset_busy_iter(set, fn, ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_set_iter);
+
+void nvme_cancel_io_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_set_iter(ctrl, ctrl->tagset, nvme_cancel_request);
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_io_requests);
+
+void nvme_cancel_admin_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_set_iter(ctrl, ctrl->admin_tagset, nvme_cancel_request);
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_admin_requests);
+
+void nvme_cancel_requests(struct nvme_ctrl *ctrl)
+{
+	nvme_cancel_io_requests(ctrl);
+	nvme_cancel_admin_requests(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_cancel_requests);
 
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state)
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e7fc1b041b7..5fb9d600f9c0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -349,7 +349,6 @@ static inline void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 }
 
 void nvme_complete_rq(struct request *req);
-void nvme_cancel_request(struct request *req, void *data, bool reserved);
 bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 		enum nvme_ctrl_state new_state);
 int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap);
@@ -372,6 +371,13 @@ int nvme_sec_submit(void *data, u16 spsp, u8 secp, void *buffer, size_t len,
 void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		union nvme_result *res);
 
+void nvme_cancel_requests(struct nvme_ctrl *ctrl);
+void nvme_cancel_io_requests(struct nvme_ctrl *ctrl);
+void nvme_cancel_admin_requests(struct nvme_ctrl *ctrl);
+
+void nvme_set_iter(struct nvme_ctrl *ctrl, struct blk_mq_tag_set *set,
+		   busy_tag_iter_fn *fn);
+
 void nvme_stop_queues(struct nvme_ctrl *ctrl);
 void nvme_start_queues(struct nvme_ctrl *ctrl);
 void nvme_kill_queues(struct nvme_ctrl *ctrl);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a2ffb557b616..4d2477c3c86c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2213,9 +2213,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
-
+	nvme_cancel_requests(&dev->ctrl);
 	/*
 	 * The driver will not be starting up queues again if shutting down so
 	 * must flush all entered requests to their failed completion to avoid
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 38e183461d9d..71070eedb773 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -957,14 +957,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+		nvme_cancel_io_requests(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, false);
 	}
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	nvme_cancel_admin_requests(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 
 	/*
@@ -1721,8 +1719,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+		nvme_cancel_io_requests(&ctrl->ctrl);
 		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
@@ -1732,8 +1729,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_disable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	nvme_cancel_admin_requests(&ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 7991ec3a17db..5dd7834a35da 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -439,8 +439,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-					nvme_cancel_request, &ctrl->ctrl);
+		nvme_cancel_io_requests(&ctrl->ctrl);
 		nvme_loop_destroy_io_queues(ctrl);
 	}
 
@@ -448,8 +447,7 @@ static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 		nvme_shutdown_ctrl(&ctrl->ctrl);
 
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_cancel_request, &ctrl->ctrl);
+	nvme_cancel_admin_requests(&ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 	nvme_loop_destroy_admin_queue(ctrl);
 }
-- 
2.14.3
