From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:34 +0300
Subject: [PATCH 07/12] nvme-rdma: introduce configure/destroy io queues
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-8-git-send-email-sagi@grimberg.me>

Make a symmetrical handling with admin queue.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 159 ++++++++++++++++++++++++-----------------------
 1 file changed, 80 insertions(+), 79 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 2d51badc4347..685ad6acd7cd 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -561,30 +561,36 @@ static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
 
 static void nvme_rdma_stop_queue(struct nvme_rdma_queue *queue)
 {
+	if (!test_and_clear_bit(NVME_RDMA_Q_LIVE, &queue->flags))
+		return;
+
 	rdma_disconnect(queue->cm_id);
 	ib_drain_qp(queue->qp);
 }
 
 static void nvme_rdma_free_queue(struct nvme_rdma_queue *queue)
 {
+	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
+		return;
+
 	nvme_rdma_destroy_queue_ib(queue);
 	rdma_destroy_id(queue->cm_id);
 }
 
-static void nvme_rdma_stop_and_free_queue(struct nvme_rdma_queue *queue)
+static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
-	if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
-		return;
-	nvme_rdma_stop_queue(queue);
-	nvme_rdma_free_queue(queue);
+	int i;
+
+	for (i = 1; i < ctrl->ctrl.queue_count; i++)
+		nvme_rdma_free_queue(&ctrl->queues[i]);
 }
 
-static void nvme_rdma_free_io_queues(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_stop_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	int i;
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++)
-		nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
+		nvme_rdma_stop_queue(&ctrl->queues[i]);
 }
 
 static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
@@ -596,15 +602,15 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 		if (ret) {
 			dev_info(ctrl->ctrl.device,
 				"failed to connect i/o queue: %d\n", ret);
-			goto out_free_queues;
+			goto out_stop_queues;
 		}
 		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
 	}
 
 	return 0;
 
-out_free_queues:
-	nvme_rdma_free_io_queues(ctrl);
+out_stop_queues:
+	nvme_rdma_stop_io_queues(ctrl);
 	return ret;
 }
 
@@ -650,7 +656,7 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 out_free_queues:
 	for (i--; i >= 1; i--)
-		nvme_rdma_stop_and_free_queue(&ctrl->queues[i]);
+		nvme_rdma_free_queue(&ctrl->queues[i]);
 
 	return ret;
 }
@@ -726,11 +732,12 @@ static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
-	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
+	nvme_rdma_stop_queue(&ctrl->queues[0]);
 	if (remove) {
 		blk_cleanup_queue(ctrl->ctrl.admin_q);
 		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 	}
+	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
@@ -810,6 +817,61 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 	return error;
 }
 
+static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
+		bool remove)
+{
+	nvme_rdma_stop_io_queues(ctrl);
+	if (remove) {
+		blk_cleanup_queue(ctrl->ctrl.connect_q);
+		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+	}
+	nvme_rdma_free_io_queues(ctrl);
+}
+
+static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
+{
+	int ret;
+
+	ret = nvme_rdma_init_io_queues(ctrl);
+	if (ret)
+		return ret;
+
+	if (new) {
+		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
+		if (IS_ERR(ctrl->ctrl.tagset))
+			goto out_free_io_queues;
+
+		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
+		if (IS_ERR(ctrl->ctrl.connect_q)) {
+			ret = PTR_ERR(ctrl->ctrl.connect_q);
+			goto out_free_tag_set;
+		}
+	} else {
+		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
+		if (ret)
+			goto out_free_io_queues;
+
+		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
+			ctrl->ctrl.queue_count - 1);
+	}
+
+	ret = nvme_rdma_connect_io_queues(ctrl);
+	if (ret)
+		goto out_cleanup_connect_q;
+
+	return 0;
+
+out_cleanup_connect_q:
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.connect_q);
+out_free_tag_set:
+	if (new)
+		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+out_free_io_queues:
+	nvme_rdma_free_io_queues(ctrl);
+	return ret;
+}
+
 static void nvme_rdma_free_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
@@ -856,13 +918,8 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 
 	++ctrl->ctrl.nr_reconnects;
 
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_rdma_free_io_queues(ctrl);
-
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
-		if (ret)
-			goto requeue;
-	}
+	if (ctrl->ctrl.queue_count > 1)
+		nvme_rdma_destroy_io_queues(ctrl, false);
 
 	nvme_rdma_destroy_admin_queue(ctrl, false);
 	ret = nvme_rdma_configure_admin_queue(ctrl, false);
@@ -870,16 +927,9 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 		goto requeue;
 
 	if (ctrl->ctrl.queue_count > 1) {
-		ret = nvme_rdma_init_io_queues(ctrl);
+		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto requeue;
-
-		ret = nvme_rdma_connect_io_queues(ctrl);
-		if (ret)
-			goto requeue;
-
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-				ctrl->ctrl.queue_count - 1);
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1676,7 +1726,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_stop_queues(&ctrl->ctrl);
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 					nvme_cancel_request, &ctrl->ctrl);
-		nvme_rdma_free_io_queues(ctrl);
+		nvme_rdma_destroy_io_queues(ctrl, shutdown);
 	}
 
 	if (shutdown)
@@ -1699,11 +1749,6 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 		nvme_rdma_shutdown_ctrl(ctrl, shutdown);
 
 	nvme_uninit_ctrl(&ctrl->ctrl);
-	if (ctrl->ctrl.tagset) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
-	}
-
 	nvme_put_ctrl(&ctrl->ctrl);
 }
 
@@ -1770,20 +1815,9 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	}
 
 	if (ctrl->ctrl.queue_count > 1) {
-		ret = blk_mq_reinit_tagset(&ctrl->tag_set);
-		if (ret)
-			goto del_dead_ctrl;
-
-		ret = nvme_rdma_init_io_queues(ctrl);
+		ret = nvme_rdma_configure_io_queues(ctrl, false);
 		if (ret)
 			goto del_dead_ctrl;
-
-		ret = nvme_rdma_connect_io_queues(ctrl);
-		if (ret)
-			goto del_dead_ctrl;
-
-		blk_mq_update_nr_hw_queues(&ctrl->tag_set,
-				ctrl->ctrl.queue_count - 1);
 	}
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
@@ -1812,39 +1846,6 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 	.get_address		= nvmf_get_address,
 };
 
-static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
-{
-	int ret;
-
-	ret = nvme_rdma_init_io_queues(ctrl);
-	if (ret)
-		return ret;
-
-	ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-	if (IS_ERR(ctrl->ctrl.tagset))
-		goto out_free_io_queues;
-
-	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-	if (IS_ERR(ctrl->ctrl.connect_q)) {
-		ret = PTR_ERR(ctrl->ctrl.connect_q);
-		goto out_free_tag_set;
-	}
-
-	ret = nvme_rdma_connect_io_queues(ctrl);
-	if (ret)
-		goto out_cleanup_connect_q;
-
-	return 0;
-
-out_cleanup_connect_q:
-	blk_cleanup_queue(ctrl->ctrl.connect_q);
-out_free_tag_set:
-	nvme_rdma_free_tagset(&ctrl->ctrl, false);
-out_free_io_queues:
-	nvme_rdma_free_io_queues(ctrl);
-	return ret;
-}
-
 static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 		struct nvmf_ctrl_options *opts)
 {
@@ -1937,7 +1938,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	}
 
 	if (opts->nr_io_queues) {
-		ret = nvme_rdma_create_io_queues(ctrl);
+		ret = nvme_rdma_configure_io_queues(ctrl, true);
 		if (ret)
 			goto out_remove_admin_queue;
 	}
-- 
2.7.4
