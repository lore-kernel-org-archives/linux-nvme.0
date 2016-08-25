From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 25 Aug 2016 13:58:57 -0700
Subject: [PATCH WIP/RFC 6/6] nvme-rdma: keep the cm_id around during reconnect
 to get events
In-Reply-To: <cover.1472218808.git.swise@opengridcomputing.com>
References: <cover.1472218808.git.swise@opengridcomputing.com>
Message-ID: <71045789b8b07058b6b6a59379bbdc2def71ea6a.1472218808.git.swise@opengridcomputing.com>

---
 drivers/nvme/host/rdma.c | 134 +++++++++++++++++++++++++++++++++++++----------
 1 file changed, 107 insertions(+), 27 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index b99d7fd..f05fa0c 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -140,6 +140,11 @@ struct nvme_rdma_ctrl {
 	};
 
 	struct nvme_ctrl	ctrl;
+
+	/* the cm_id and vars for device unplug events */
+	struct rdma_cm_id	*unplug_cm_id;
+	int			unplug_cm_error;
+	struct completion	unplug_cm_done;
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -168,6 +173,7 @@ MODULE_PARM_DESC(register_always,
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		struct rdma_cm_event *event);
 static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc);
+static int nvme_rdma_device_unplug(struct nvme_rdma_ctrl *ctrl);
 
 /* XXX: really should move to a generic header sooner or later.. */
 static inline void put_unaligned_le24(u32 val, u8 *p)
@@ -553,6 +559,79 @@ out:
 	return ret;
 }
 
+static int nvme_rdma_unplug_cm_handler(struct rdma_cm_id *cm_id,
+		struct rdma_cm_event *ev)
+{
+	struct nvme_rdma_ctrl *ctrl = cm_id->context;
+	int ret = 0;
+
+	dev_warn(ctrl->ctrl.device, "%s (%d): status %d id %p\n",
+		rdma_event_msg(ev->event), ev->event,
+		ev->status, cm_id);
+
+	switch (ev->event) {
+	case RDMA_CM_EVENT_ADDR_RESOLVED:
+		ctrl->unplug_cm_error = 0;
+		complete(&ctrl->unplug_cm_done);
+		break;
+	case RDMA_CM_EVENT_DEVICE_REMOVAL:
+		/* return 1 means implicit CM ID destroy */
+		ret = nvme_rdma_device_unplug(ctrl);
+		break;
+	default:
+		dev_err(ctrl->ctrl.device,
+			"Unexpected RDMA CM event (%d) status %d\n",
+			ev->event, ev->status);
+		ctrl->unplug_cm_error = ev->status;
+		complete(&ctrl->unplug_cm_done);
+		break;
+	}
+	return ret;
+}
+
+static int nvme_rdma_init_unplug_cm_id(struct nvme_rdma_ctrl *ctrl)
+{
+	int ret;
+
+	dev_info(ctrl->ctrl.device, "%s enter\n", __func__);
+	init_completion(&ctrl->unplug_cm_done);
+
+	ctrl->unplug_cm_id = rdma_create_id(&init_net,
+			nvme_rdma_unplug_cm_handler, ctrl,
+			RDMA_PS_TCP, IB_QPT_RC);
+	if (IS_ERR(ctrl->unplug_cm_id)) {
+		dev_info(ctrl->ctrl.device, "failed to create CM ID: %ld\n",
+			PTR_ERR(ctrl->unplug_cm_id));
+		return PTR_ERR(ctrl->unplug_cm_id);
+	}
+
+	ctrl->unplug_cm_error = -ETIMEDOUT;
+	ret = rdma_resolve_addr(ctrl->unplug_cm_id, NULL, &ctrl->addr,
+			NVME_RDMA_CONNECT_TIMEOUT_MS);
+	if (ret) {
+		dev_info(ctrl->ctrl.device,
+			"rdma_resolve_addr failed (%d).\n", ret);
+		goto out_destroy_unplug_cm_id;
+	}
+	wait_for_completion_interruptible_timeout(&ctrl->unplug_cm_done,
+			msecs_to_jiffies(NVME_RDMA_CONNECT_TIMEOUT_MS) + 1);
+	ret = ctrl->unplug_cm_error;
+	if (ret) {
+		dev_info(ctrl->ctrl.device,
+			"nvme_rdma_init_unplug_unplug_cm_id failed (%d).\n",
+			ret);
+		goto out_destroy_unplug_cm_id;
+	}
+
+	dev_info(ctrl->ctrl.device, "%s exit\n", __func__);
+	return 0;
+
+out_destroy_unplug_cm_id:
+	rdma_destroy_id(ctrl->unplug_cm_id);
+	dev_info(ctrl->ctrl.device, "%s exit err %d\n", __func__, ret);
+	return ret;
+}
+
 static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 		int idx, size_t queue_size)
 {
@@ -594,6 +673,15 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 		goto out_destroy_cm_id;
 	}
 
+	if (idx == 0 && !ctrl->unplug_cm_id) {
+		ret = nvme_rdma_init_unplug_cm_id(ctrl);
+		if (ret) {
+			dev_info(ctrl->ctrl.device,
+				"init_unplug_cm_id failed (%d).\n", ret);
+			goto out_destroy_cm_id;
+		}
+	}
+
 	set_bit(NVME_RDMA_Q_CONNECTED, &queue->flags);
 
 	return 0;
@@ -1323,30 +1411,24 @@ out_destroy_queue_ib:
 
 /**
  * nvme_rdma_device_unplug() - Handle RDMA device unplug
- * @queue:      Queue that owns the cm_id that caught the event
+ * @ctrl:      Controller that owns the unplug_cm_id that caught the event
  *
  * DEVICE_REMOVAL event notifies us that the RDMA device is about
  * to unplug so we should take care of destroying our RDMA resources.
- * This event will be generated for each allocated cm_id.
+ * This event will be generated for each allocated cm_id, but only handled
+ * by each controller's unplug_cm_id.
  *
- * In our case, the RDMA resources are managed per controller and not
- * only per queue. So the way we handle this is we trigger an implicit
- * controller deletion upon the first DEVICE_REMOVAL event we see, and
- * hold the event inflight until the controller deletion is completed.
+ * Trigger an implicit controller deletion and hold the event inflight
+ * until the controller deletion is completed.
  *
- * One exception that we need to handle is the destruction of the cm_id
+ * One exception that we need to handle is the destruction of the unplug_cm_id
  * that caught the event. Since we hold the callout until the controller
  * deletion is completed, we'll deadlock if the controller deletion will
- * call rdma_destroy_id on this queue's cm_id. Thus, we claim ownership
- * of destroying this queue before-hand, destroy the queue resources,
- * then queue the controller deletion which won't destroy this queue and
- * we destroy the cm_id implicitely by returning a non-zero rc to the callout.
+ * call rdma_destroy_id on this queue's cm_id.  We destroy the unplug_cm_id
+ * implicitely by returning a non-zero rc to the callout.
  */
-static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
+static int nvme_rdma_device_unplug(struct nvme_rdma_ctrl *ctrl)
 {
-	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
-	int ret = 0;
-
 	/* Own the controller deletion */
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING))
 		return 0;
@@ -1357,15 +1439,11 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 	/* Get rid of reconnect work if its running */
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 
-	/* Disable the queue so ctrl delete won't free it */
-	if (test_and_clear_bit(NVME_RDMA_Q_CONNECTED, &queue->flags)) {
-		/* Free this queue ourselves */
-		nvme_rdma_stop_queue(queue);
-		nvme_rdma_destroy_queue_ib(queue);
-
-		/* Return non-zero so the cm_id will destroy implicitly */
-		ret = 1;
-	}
+	/*
+	 * NULL out the unplug_cm_id pointer so the controller deletion
+	 * does not free it.
+	 */
+	ctrl->unplug_cm_id = NULL;
 
 	/*
 	 * Queue controller deletion. Keep a reference until all
@@ -1376,7 +1454,7 @@ static int nvme_rdma_device_unplug(struct nvme_rdma_queue *queue)
 	flush_work(&ctrl->delete_work);
 	nvme_put_ctrl(&ctrl->ctrl);
 
-	return ret;
+	return 1;
 }
 
 static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
@@ -1420,8 +1498,8 @@ static int nvme_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		nvme_rdma_error_recovery(queue->ctrl);
 		break;
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
-		/* return 1 means impliciy CM ID destroy */
-		return nvme_rdma_device_unplug(queue);
+		/* handled on ctrl->unplug_cm_id */
+		break;
 	default:
 		dev_err(queue->ctrl->ctrl.device,
 			"Unexpected RDMA CM event (%d)\n", ev->event);
@@ -1697,6 +1775,8 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_dev_put(ctrl->device);
 	}
 
+	if (ctrl->unplug_cm_id)
+		rdma_destroy_id(ctrl->unplug_cm_id);
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
-- 
2.7.0
