From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:30 +0300
Subject: [PATCH 03/12] nvme-rdma: move tagset allocation to a dedicated routine
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-4-git-send-email-sagi@grimberg.me>

We always pair tagset allocation with rdma device reference
and it shares some code, centralize it with an argument if its
an admin or IO tagset.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 131 +++++++++++++++++++++++++++--------------------
 1 file changed, 75 insertions(+), 56 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 564a15af7c34..7ec9adef6015 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -655,14 +655,79 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_rdma_free_tagset(struct nvme_ctrl *nctrl, bool admin)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct blk_mq_tag_set *set = admin ?
+			&ctrl->admin_tag_set : &ctrl->tag_set;
+
+	blk_mq_free_tag_set(set);
+	nvme_rdma_dev_put(ctrl->device);
+}
+
+static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
+		bool admin)
+{
+	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
+	struct blk_mq_tag_set *set;
+	int ret;
+
+	if (admin) {
+		set = &ctrl->admin_tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_rdma_admin_mq_ops;
+		set->queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
+		set->reserved_tags = 2; /* connect + keep-alive */
+		set->numa_node = NUMA_NO_NODE;
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = 1;
+		set->timeout = ADMIN_TIMEOUT;
+	} else {
+		set = &ctrl->tag_set;
+		memset(set, 0, sizeof(*set));
+		set->ops = &nvme_rdma_mq_ops;
+		set->queue_depth = nctrl->opts->queue_size;
+		set->reserved_tags = 1; /* fabric connect */
+		set->numa_node = NUMA_NO_NODE;
+		set->flags = BLK_MQ_F_SHOULD_MERGE;
+		set->cmd_size = sizeof(struct nvme_rdma_request) +
+			SG_CHUNK_SIZE * sizeof(struct scatterlist);
+		set->driver_data = ctrl;
+		set->nr_hw_queues = nctrl->queue_count - 1;
+		set->timeout = NVME_IO_TIMEOUT;
+	}
+
+	ret = blk_mq_alloc_tag_set(set);
+	if (ret)
+		goto out;
+
+	/*
+	 * We need a reference on the device as long as the tag_set is alive,
+	 * as the MRs in the request structures need a valid ib_device.
+	 */
+	ret = nvme_rdma_dev_get(ctrl->device);
+	if (!ret) {
+		ret = -EINVAL;
+		goto out_free_tagset;
+	}
+
+	return set;
+
+out_free_tagset:
+	blk_mq_free_tag_set(set);
+out:
+	return ERR_PTR(ret);
+}
+
 static void nvme_rdma_destroy_admin_queue(struct nvme_rdma_ctrl *ctrl)
 {
 	nvme_rdma_free_qe(ctrl->queues[0].device->dev, &ctrl->async_event_sqe,
 			sizeof(struct nvme_command), DMA_TO_DEVICE);
 	nvme_rdma_stop_and_free_queue(&ctrl->queues[0]);
 	blk_cleanup_queue(ctrl->ctrl.admin_q);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-	nvme_rdma_dev_put(ctrl->device);
+	nvme_rdma_free_tagset(&ctrl->ctrl, true);
 }
 
 static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
@@ -675,32 +740,12 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 
 	ctrl->device = ctrl->queues[0].device;
 
-	/*
-	 * We need a reference on the device as long as the tag_set is alive,
-	 * as the MRs in the request structures need a valid ib_device.
-	 */
-	error = -EINVAL;
-	if (!nvme_rdma_dev_get(ctrl->device))
-		goto out_free_queue;
-
 	ctrl->max_fr_pages = min_t(u32, NVME_RDMA_MAX_SEGMENTS,
 		ctrl->device->dev->attrs.max_fast_reg_page_list_len);
 
-	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
-	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
-	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
-	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
-	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->admin_tag_set.driver_data = ctrl;
-	ctrl->admin_tag_set.nr_hw_queues = 1;
-	ctrl->admin_tag_set.timeout = ADMIN_TIMEOUT;
-
-	error = blk_mq_alloc_tag_set(&ctrl->admin_tag_set);
-	if (error)
-		goto out_put_dev;
-	ctrl->ctrl.admin_tagset = &ctrl->admin_tag_set;
+	ctrl->ctrl.admin_tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
+	if (IS_ERR(ctrl->ctrl.admin_tagset))
+		goto out_free_queue;
 
 	ctrl->ctrl.admin_q = blk_mq_init_queue(&ctrl->admin_tag_set);
 	if (IS_ERR(ctrl->ctrl.admin_q)) {
@@ -749,9 +794,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
 out_free_tagset:
 	/* disconnect and drain the queue before freeing the tagset */
 	nvme_rdma_stop_queue(&ctrl->queues[0]);
-	blk_mq_free_tag_set(&ctrl->admin_tag_set);
-out_put_dev:
-	nvme_rdma_dev_put(ctrl->device);
+	nvme_rdma_free_tagset(&ctrl->ctrl, true);
 out_free_queue:
 	nvme_rdma_free_queue(&ctrl->queues[0]);
 	return error;
@@ -1661,8 +1704,7 @@ static void __nvme_rdma_remove_ctrl(struct nvme_rdma_ctrl *ctrl, bool shutdown)
 	nvme_uninit_ctrl(&ctrl->ctrl);
 	if (ctrl->ctrl.tagset) {
 		blk_cleanup_queue(ctrl->ctrl.connect_q);
-		blk_mq_free_tag_set(&ctrl->tag_set);
-		nvme_rdma_dev_put(ctrl->device);
+		nvme_rdma_free_tagset(&ctrl->ctrl, false);
 	}
 
 	nvme_put_ctrl(&ctrl->ctrl);
@@ -1781,31 +1823,10 @@ static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 	if (ret)
 		return ret;
 
-	/*
-	 * We need a reference on the device as long as the tag_set is alive,
-	 * as the MRs in the request structures need a valid ib_device.
-	 */
-	ret = -EINVAL;
-	if (!nvme_rdma_dev_get(ctrl->device))
+	ctrl->ctrl.tagset = nvme_rdma_alloc_tagset(&ctrl->ctrl, true);
+	if (IS_ERR(ctrl->ctrl.tagset))
 		goto out_free_io_queues;
 
-	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
-	ctrl->tag_set.ops = &nvme_rdma_mq_ops;
-	ctrl->tag_set.queue_depth = ctrl->ctrl.opts->queue_size;
-	ctrl->tag_set.reserved_tags = 1; /* fabric connect */
-	ctrl->tag_set.numa_node = NUMA_NO_NODE;
-	ctrl->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ctrl->tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
-		SG_CHUNK_SIZE * sizeof(struct scatterlist);
-	ctrl->tag_set.driver_data = ctrl;
-	ctrl->tag_set.nr_hw_queues = ctrl->ctrl.queue_count - 1;
-	ctrl->tag_set.timeout = NVME_IO_TIMEOUT;
-
-	ret = blk_mq_alloc_tag_set(&ctrl->tag_set);
-	if (ret)
-		goto out_put_dev;
-	ctrl->ctrl.tagset = &ctrl->tag_set;
-
 	ctrl->ctrl.connect_q = blk_mq_init_queue(&ctrl->tag_set);
 	if (IS_ERR(ctrl->ctrl.connect_q)) {
 		ret = PTR_ERR(ctrl->ctrl.connect_q);
@@ -1821,9 +1842,7 @@ static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 out_cleanup_connect_q:
 	blk_cleanup_queue(ctrl->ctrl.connect_q);
 out_free_tag_set:
-	blk_mq_free_tag_set(&ctrl->tag_set);
-out_put_dev:
-	nvme_rdma_dev_put(ctrl->device);
+	nvme_rdma_free_tagset(&ctrl->ctrl, false);
 out_free_io_queues:
 	nvme_rdma_free_io_queues(ctrl);
 	return ret;
-- 
2.7.4
