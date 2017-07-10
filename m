From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:32 +0300
Subject: [PATCH 05/12] nvme-rdma: don't free tagset on resets
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-6-git-send-email-sagi@grimberg.me>

We're not supposed to do that.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 48 +++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 496e5b686290..a7cc06173ead 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -721,16 +721,20 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 	return ERR_PTR(ret);
 }
 
-static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
+static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
+		bool remove)
 {
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_free_tagset(&ctrl->ctrl, true);
+	if (remove) {
+		blk_cleanup_queue(ctrl->ctrl.admin_q);
+		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+	}
 }
 
-static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
+		bool new)
 {
 	int error;
 
@@ -743,14 +747,20 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
 		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
 
-	ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-	if (IS_ERR(ctrl->ctrl.admin_tagset))
-		goto out_free_queue;
+	if (new) {
+		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
+		if (IS_ERR(ctrl->ctrl.admin_tagset))
+			goto out_free_queue;
 
-	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-	if (IS_ERR(ctrl->ctrl.admin_q)) {
-		error = PTR_ERR(ctrl->ctrl.admin_q);
-		goto out_free_tagset;
+		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
+		if (IS_ERR(ctrl->ctrl.admin_q)) {
+			error = PTR_ERR(ctrl->ctrl.admin_q);
+			goto out_free_tagset;
+		}
+	} else {
+		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set);
+		if (error)
+			goto out_free_queue;
 	}
 
 	error = nvmf_connect_admin_queue(&ctrl->ctrl);
@@ -790,11 +800,11 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 	return 0;
 
 out_cleanup_queue:
-	blk_cleanup_queue(ctrl->ctrl.admin_q);
+	if (new)
+		blk_cleanup_queue(ctrl->ctrl.admin_q);
 out_free_tagset:
-	/* disconnect and drain the queue before freeing the tagset */
-	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	nvme_rdma_free_tagset(&ctrl->ctrl, true);
+	if (new)
+		nvme_rdma_free_tagset(&ctrl->ctrl, true);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
@@ -1693,7 +1703,7 @@ static void nvme_rdma_shutdown_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_cancel_request, &ctrl->ctrl);
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_destroy_admin_queue(ctrl, shutdown);
 }
 
 static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
@@ -1767,7 +1777,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
-	ret = nvme_rdma_configure_admin_queue(ctrl);
+	ret = nvme_rdma_configure_admin_queue(ctrl, false);
 	if (ret) {
 		/* ctrl is already shutdown, just remove the ctrl */
 		INIT_WORK(&ctrl->delete_work, nvme_rdma_remove_ctrl_work);
@@ -1907,7 +1917,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	if (!ctrl->queues)
 		goto out_uninit_ctrl;
 
-	ret = nvme_rdma_configure_admin_queue(ctrl);
+	ret = nvme_rdma_configure_admin_queue(ctrl, true);
 	if (ret)
 		goto out_kfree_queues;
 
@@ -1964,7 +1974,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	return &ctrl->ctrl;
 
 out_remove_admin_queue:
-	nvme_rdma_destroy_admin_queue(ctrl);
+	nvme_rdma_destroy_admin_queue(ctrl, true);
 out_kfree_queues:
 	kfree(ctrl->queues);
 out_uninit_ctrl:
-- 
2.7.4
