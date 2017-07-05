From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed,  5 Jul 2017 23:34:17 +0300
Subject: [PATCH v3] nvme: split nvme_uninit_ctrl into stop and uninit
Message-ID: <1499286857-7657-1-git-send-email-sagi@grimberg.me>

Usually before we teardown the controller we want to:
1. complete/cancel any ctrl inflight works
2. remove ctrl namespaces (only for removal though, resets
   shouldn't remove any namespaces).

but we do not want to destroy the controller device as
we might use it for logging during the teardown stage.

This patch adds nvme_start_ctrl() which queues inflight
controller works (aen, ns scan, queue start and keep-alive
if kato is set) and nvme_stop_ctrl() which cancels the works
namespace removal is left to the callers to handle.

Move nvme_uninit_ctrl after we are done with the
controller device.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
Changes from v2:
- move nvme_uninit_ctrl out from ->delete_ctrl back to
  its original place but after we are done with ctrl->device

Changes from v1:
- removed __nvme_stop_ctrl and added nvme_remove_namespaces to
  the callers
- added nvme_start_queues to nvme_start_ctrl instead of duplicating
  the code

 drivers/nvme/host/core.c   | 21 +++++++++++++++++++--
 drivers/nvme/host/fc.c     | 16 ++++------------
 drivers/nvme/host/nvme.h   |  2 ++
 drivers/nvme/host/pci.c    | 16 ++++------------
 drivers/nvme/host/rdma.c   | 29 ++++++++---------------------
 drivers/nvme/target/loop.c | 19 ++++++-------------
 6 files changed, 43 insertions(+), 60 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 48cafaa6fbc5..cb96f4a7ae3a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2591,12 +2591,29 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 	spin_unlock(&dev_list_lock);
 }
 
-void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
+void nvme_stop_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_stop_keep_alive(ctrl);
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
-	nvme_remove_namespaces(ctrl);
+}
+EXPORT_SYMBOL_GPL(nvme_stop_ctrl);
+
+void nvme_start_ctrl(struct nvme_ctrl *ctrl)
+{
+	if (ctrl->kato)
+		nvme_start_keep_alive(ctrl);
+
+	if (ctrl->queue_count > 1) {
+		nvme_queue_scan(ctrl);
+		nvme_queue_async_events(ctrl);
+		nvme_start_queues(ctrl);
+	}
+}
+EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
+void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
+{
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8d55e7827932..d666ada39a9b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2232,7 +2232,6 @@ nvme_fc_create_io_queues(struct nvme_fc_ctrl *ctrl)
 out_delete_hw_queues:
 	nvme_fc_delete_hw_io_queues(ctrl);
 out_cleanup_blk_queue:
-	nvme_stop_keep_alive(&ctrl->ctrl);
 	blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
 	blk_mq_free_tag_set(&ctrl->tag_set);
@@ -2366,8 +2365,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		goto out_disconnect_admin_queue;
 	}
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	/* FC-NVME supports normal SGL Data Block Descriptors */
 
 	if (opts->queue_size > ctrl->ctrl.maxcmd) {
@@ -2401,17 +2398,12 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	ctrl->ctrl.nr_reconnects = 0;
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_queues(&ctrl->ctrl);
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return 0;	/* Success */
 
 out_term_aen_ops:
 	nvme_fc_term_aen_ops(ctrl);
-	nvme_stop_keep_alive(&ctrl->ctrl);
 out_disconnect_admin_queue:
 	/* send a Disconnect(association) LS to fc-nvme target */
 	nvme_fc_xmt_disconnect_assoc(ctrl);
@@ -2434,8 +2426,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 {
 	unsigned long flags;
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
-
 	spin_lock_irqsave(&ctrl->lock, flags);
 	ctrl->flags |= FCCTRL_TERMIO;
 	ctrl->iocnt = 0;
@@ -2517,7 +2507,8 @@ nvme_fc_delete_ctrl_work(struct work_struct *work)
 
 	cancel_work_sync(&ctrl->ctrl.reset_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
-
+	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_remove_namespaces(&ctrl->ctrl);
 	/*
 	 * kill the association on the link side.  this will block
 	 * waiting for io to terminate
@@ -2612,6 +2603,7 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 	int ret;
 
+	nvme_stop_ctrl(&ctrl->ctrl);
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e0b83311d5de..8f2a168ddc01 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -280,6 +280,8 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 		const struct nvme_ctrl_ops *ops, unsigned long quirks);
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl);
+void nvme_start_ctrl(struct nvme_ctrl *ctrl);
+void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d9c0010a9bbc..882ed3677117 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2135,15 +2135,6 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 
 	/*
-	 * A controller that can not execute IO typically requires user
-	 * intervention to correct. For such degraded controllers, the driver
-	 * should not submit commands the user did not request, so skip
-	 * registering for asynchronous event notification on this condition.
-	 */
-	if (dev->online_queues > 1)
-		nvme_queue_async_events(&dev->ctrl);
-
-	/*
 	 * Keep the controller around but remove all namespaces if we don't have
 	 * any working I/O queue.
 	 */
@@ -2163,8 +2154,7 @@ static void nvme_reset_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (dev->online_queues > 1)
-		nvme_queue_scan(&dev->ctrl);
+	nvme_start_ctrl(&dev->ctrl);
 	return;
 
  out:
@@ -2341,11 +2331,13 @@ static void nvme_remove(struct pci_dev *pdev)
 	}
 
 	flush_work(&dev->ctrl.reset_work);
-	nvme_uninit_ctrl(&dev->ctrl);
+	nvme_stop_ctrl(&dev->ctrl);
+	nvme_remove_namespaces(&dev->ctrl);
 	nvme_dev_disable(dev, true);
 	nvme_free_host_mem(dev);
 	nvme_dev_remove_admin(dev);
 	nvme_free_queues(dev, 0);
+	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_release_prp_pools(dev);
 	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5f9c180056c1..e3591e06fd6c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -738,8 +738,6 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	if (ret)
 		goto requeue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	if (ctrl->ctrl.queue_count > 1) {
 		ret = nvme_rdma_init_io_queues(ctrl);
 		if (ret)
@@ -757,10 +755,7 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	WARN_ON_ONCE(!changed);
 	ctrl->ctrl.nr_reconnects = 0;
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	dev_info(ctrl->ctrl.device, "Successfully reconnected\n");
 
@@ -778,7 +773,7 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 			struct nvme_rdma_ctrl, err_work);
 	int i;
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
 
 	for (i = 0; i < ctrl->ctrl.queue_count; i++)
 		clear_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
@@ -1618,8 +1613,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	return 0;
 
 out_cleanup_queue:
@@ -1637,7 +1630,6 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
 	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
@@ -1660,10 +1652,12 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl)
 
 static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 {
-	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_remove_namespaces(&ctrl->ctrl);
 	if (shutdown)
 		nvme_rdma_shutdown_ctrl(ctrl);
 
+	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
 		blk_mq_free_tag_set(&ctrl->tag_set);
@@ -1725,6 +1719,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	int ret;
 	bool changed;
 
+	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl);
 
 	ret = nvme_rdma_configure_admin_queue(ctrl);
@@ -1754,11 +1749,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_start_queues(&ctrl->ctrl);
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return;
 
@@ -1946,15 +1937,11 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_rdma_ctrl_list);
 	mutex_unlock(&nvme_rdma_ctrl_mutex);
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
-	nvme_stop_keep_alive(&ctrl->ctrl);
 	nvme_rdma_destroy_admin_queue(ctrl);
 out_kfree_queues:
 	kfree(ctrl->queues);
diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 6a0b70685e77..717ed7ddb2f6 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -407,8 +407,6 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 	if (error)
 		goto out_cleanup_queue;
 
-	nvme_start_keep_alive(&ctrl->ctrl);
-
 	return 0;
 
 out_cleanup_queue:
@@ -422,8 +420,6 @@ static int nvme_loop_configure_admin_queue(struct nvme_loop_ctrl *ctrl)
 
 static void nvme_loop_shutdown_ctrl(struct nvme_loop_ctrl *ctrl)
 {
-	nvme_stop_keep_alive(&ctrl->ctrl);
-
 	if (ctrl->ctrl.queue_count > 1) {
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
@@ -446,8 +442,10 @@ static void nvme_loop_del_ctrl_work(struct work_struct *work)
 	struct nvme_loop_ctrl *ctrl = container_of(work,
 				struct nvme_loop_ctrl, delete_work);
 
-	nvme_uninit_ctrl(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
+	nvme_remove_namespaces(&ctrl->ctrl);
 	nvme_loop_shutdown_ctrl(ctrl);
+	nvme_uninit_ctrl(&ctrl->ctrl);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
@@ -495,6 +493,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	bool changed;
 	int ret;
 
+	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_loop_shutdown_ctrl(ctrl);
 
 	ret = nvme_loop_configure_admin_queue(ctrl);
@@ -515,10 +514,7 @@ static void nvme_loop_reset_ctrl_work(struct work_struct *work)
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 	WARN_ON_ONCE(!changed);
 
-	nvme_queue_scan(&ctrl->ctrl);
-	nvme_queue_async_events(&ctrl->ctrl);
-
-	nvme_start_queues(&ctrl->ctrl);
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return;
 
@@ -653,10 +649,7 @@ static struct nvme_ctrl *nvme_loop_create_ctrl(struct device *dev,
 	list_add_tail(&ctrl->list, &nvme_loop_ctrl_list);
 	mutex_unlock(&nvme_loop_ctrl_mutex);
 
-	if (opts->nr_io_queues) {
-		nvme_queue_scan(&ctrl->ctrl);
-		nvme_queue_async_events(&ctrl->ctrl);
-	}
+	nvme_start_ctrl(&ctrl->ctrl);
 
 	return &ctrl->ctrl;
 
-- 
2.7.4
