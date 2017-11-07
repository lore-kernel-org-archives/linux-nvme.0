From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  7 Nov 2017 15:23:09 +0200
Subject: [PATCH 1/1] nvme-rdma: Introduce
 nvme_rdma_configure_blk/nvme_rdma_destroy_blk
Message-ID: <1510060989-10391-1-git-send-email-maxg@mellanox.com>

Create new helpers to avoid code and logic duplication between admin/IO
block layer resources creation and destruction.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/rdma.c | 115 ++++++++++++++++++++++++++++-------------------
 1 file changed, 68 insertions(+), 47 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 957d626..5cbb073 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -676,11 +676,10 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl, bool admin)
+static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl,
+		struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
-	struct blk_mq_tag_set *set = admin ?
-			&ctrl->admin_tag_set : &ctrl->tag_set;
 
 	blk_mq_free_tag_set(set);
 	nvme_rdma_dev_put(ctrl->device);
@@ -742,14 +741,60 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 	return ERR_PTR(ret);
 }
 
+static void nvme_rdma_destroy_blk(struct nvme_ctrl *nctrl, bool admin)
+{
+	struct blk_mq_tag_set *tagset;
+	struct request_queue *queue;
+
+	if (admin) {
+		tagset = nctrl->admin_tagset;
+		queue = nctrl->admin_q;
+	} else {
+		tagset = nctrl->tagset;
+		queue = nctrl->connect_q;
+	}
+
+	blk_cleanup_queue(queue);
+	nvme_rdma_free_tagset(nctrl, tagset);
+}
+
+static int nvme_rdma_configure_blk(struct nvme_ctrl *nctrl, bool admin)
+{
+	struct blk_mq_tag_set *tagset;
+	struct request_queue *queue;
+	int error;
+
+	tagset = nvme_rdma_alloc_tagset(nctrl, admin);
+	if (IS_ERR(tagset))
+		return PTR_ERR(tagset);
+
+	queue = blk_mq_init_queue(tagset);
+	if (IS_ERR(queue)) {
+		error = PTR_ERR(queue);
+		goto out_free_tagset;
+	}
+
+	if (admin) {
+		nctrl->admin_tagset = tagset;
+		nctrl->admin_q = queue;
+	} else {
+		nctrl->tagset = tagset;
+		nctrl->connect_q = queue;
+	}
+
+	return 0;
+
+out_free_tagset:
+	nvme_rdma_free_tagset(nctrl, tagset);
+	return error;
+}
+
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
-	}
+	if (remove)
+		nvme_rdma_destroy_blk(&ctrl->ctrl, true);
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 }
 
@@ -768,17 +813,9 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
 
 	if (new) {
-		ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
-		if (IS_ERR(ctrl->ctrl.admin_tagset)) {
-			error = PTR_ERR(ctrl->ctrl.admin_tagset);
+		error = nvme_rdma_configure_blk(&ctrl->ctrl, true);
+		if (error)
 			goto out_free_queue;
-		}
-
-		ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
-		if (IS_ERR(ctrl->ctrl.admin_q)) {
-			error = PTR_ERR(ctrl->ctrl.admin_q);
-			goto out_free_tagset;
-		}
 	} else {
 		error = blk_mq_reinit_tagset(&ctrl->admin_tag_set,
 					     nvme_rdma_reinit_request);
@@ -788,14 +825,14 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_rdma_start_queue(ctrl, 0);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_destroy_blk;
 
 	error = ctrl->ctrl.ops->reg_read64(&ctrl->ctrl, NVME_REG_CAP,
 			&ctrl->ctrl.cap);
 	if (error) {
 		dev_err(ctrl->ctrl.device,
 			"prop_get NVME_REG_CAP failed\n");
-		goto out_cleanup_queue;
+		goto out_destroy_blk;
 	}
 
 	ctrl->ctrl.sqsize =
@@ -803,29 +840,26 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 
 	error = nvme_enable_ctrl(&ctrl->ctrl, ctrl->ctrl.cap);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_destroy_blk;
 
 	ctrl->ctrl.max_hw_sectors =
 		(ctrl->max_fr_pages - 1) << (ilog2(SZ_4K) - 9);
 
 	error = nvme_init_identify(&ctrl->ctrl);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_destroy_blk;
 
 	error = nvme_rdma_alloc_qe(ctrl->queues[0].device->dev,
 			&ctrl->async_event_sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (error)
-		goto out_cleanup_queue;
+		goto out_destroy_blk;
 
 	return 0;
 
-out_cleanup_queue:
-	if (new)
-		blk_cleanup_queue(ctrl->ctrl.admin_q);
-out_free_tagset:
+out_destroy_blk:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, true);
+		nvme_rdma_destroy_blk(&ctrl->ctrl, true);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
@@ -835,10 +869,8 @@ static void nvme_rdma_destroy_io_queues(struct nvme_rdma_ctrl *ctrl,
 		bool remove)
 {
 	nvme_rdma_stop_io_queues(ctrl);
-	if (remove) {
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
-	}
+	if (remove)
+		nvme_rdma_destroy_blk(&ctrl->ctrl, false);
 	nvme_rdma_free_io_queues(ctrl);
 }
 
@@ -851,17 +883,9 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 		return ret;
 
 	if (new) {
-		ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, false);
-		if (IS_ERR(ctrl->ctrl.tagset)) {
-			ret = PTR_ERR(ctrl->ctrl.tagset);
+		ret = nvme_rdma_configure_blk(&ctrl->ctrl, false);
+		if (ret)
 			goto out_free_io_queues;
-		}
-
-		ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
-		if (IS_ERR(ctrl->ctrl.connect_q)) {
-			ret = PTR_ERR(ctrl->ctrl.connect_q);
-			goto out_free_tag_set;
-		}
 	} else {
 		ret = blk_mq_reinit_tagset(&ctrl->tag_set,
 					   nvme_rdma_reinit_request);
@@ -874,16 +898,13 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 
 	ret = nvme_rdma_start_io_queues(ctrl);
 	if (ret)
-		goto out_cleanup_connect_q;
+		goto out_destroy_blk;
 
 	return 0;
 
-out_cleanup_connect_q:
-	if (new)
-		blk_cleanup_queue(ctrl->ctrl.connect_q);
-out_free_tag_set:
+out_destroy_blk:
 	if (new)
-		nvme_rdma_free_tagset(&ctrl->ctrl, false);
+		nvme_rdma_destroy_blk(&ctrl->ctrl, false);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
-- 
1.8.3.1
