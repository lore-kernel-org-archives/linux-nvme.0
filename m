From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 13 Mar 2017 16:02:18 +0200
Subject: [PATCH 1/3] nvme-rdma: handle cpu unplug when re-establishing the
 controller
Message-ID: <1489413740-29085-1-git-send-email-sagi@grimberg.me>

If a cpu unplug event has occured, we need to take the minimum
of the provided nr_io_queues and the number of online cpus,
otherwise we won't be able to connect them as blk-mq mapping
won't dispatch to those queues.

Reported-by: Yi Zhang <yizhan at redhat.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 779f516e7a4e..47a479f26e5d 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -343,8 +343,6 @@ static int __nvme_rdma_init_request(struct nvme_rdma_ctrl *ctrl,
 	struct ib_device *ibdev = dev->dev;
 	int ret;
 
-	BUG_ON(queue_idx >= ctrl->queue_count);
-
 	ret = nvme_rdma_alloc_qe(ibdev, &req->sqe, sizeof(struct nvme_command),
 			DMA_TO_DEVICE);
 	if (ret)
@@ -652,8 +650,22 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 
 static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
+	unsigned int nr_io_queues;
 	int i, ret;
 
+	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
+	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
+	if (ret)
+		return ret;
+
+	ctrl->queue_count = nr_io_queues + 1;
+	if (ctrl->queue_count < 2)
+		return 0;
+
+	dev_info(ctrl->ctrl.device,
+		"creating %d I/O queues.\n", nr_io_queues);
+
 	for (i = 1; i < ctrl->queue_count; i++) {
 		ret = nvme_rdma_init_queue(ctrl, i,
 					   ctrl->ctrl.opts->queue_size);
@@ -1791,20 +1803,8 @@ static const struct nvme_ctrl_ops nvme_rdma_ctrl_ops = {
 
 static int nvme_rdma_create_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
-	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	int ret;
 
-	ret = nvme_set_queue_count(&ctrl->ctrl, &opts->nr_io_queues);
-	if (ret)
-		return ret;
-
-	ctrl->queue_count = opts->nr_io_queues + 1;
-	if (ctrl->queue_count < 2)
-		return 0;
-
-	dev_info(ctrl->ctrl.device,
-		"creating %d I/O queues.\n", opts->nr_io_queues);
-
 	ret = nvme_rdma_init_io_queues(ctrl);
 	if (ret)
 		return ret;
-- 
2.7.4
