From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jul 2017 09:22:36 +0300
Subject: [PATCH 09/12] nvme-rdma: rename nvme_rdma_init_queue to
 nvme_rdma_alloc_queue
In-Reply-To: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
References: <1499667759-15965-1-git-send-email-sagi@grimberg.me>
Message-ID: <1499667759-15965-10-git-send-email-sagi@grimberg.me>

Give it a name symmetric to nvme_rdma_free_queue. Also pass in
the ctrl sqsize+1 and not the opts queue_size. And suppress
failure message that has prior verbosity.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 346c35d5bf6f..6f5f50ed7aa8 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -503,7 +503,7 @@ static int nvme_rdma_create_queue_ib(struct nvme_rdma_queue *queue)
 	return ret;
 }
 
-static int nvme_rdma_init_queue(struct nvme_rdma_ctrl *ctrl,
+static int nvme_rdma_alloc_queue(struct nvme_rdma_ctrl *ctrl,
 		int idx, size_t queue_size)
 {
 	struct nvme_rdma_queue *queue;
@@ -614,7 +614,7 @@ static int nvme_rdma_connect_io_queues(struct nvme_rdma_ctrl *ctrl)
 	return ret;
 }
 
-static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
+static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 	struct ib_device *ibdev = ctrl->device->dev;
@@ -643,13 +643,10 @@ static int nvme_rdma_init_io_queues(struct nvme_rdma_ctrl *ctrl)
 		"creating %d I/O queues.\n", nr_io_queues);
 
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
-		ret = nvme_rdma_init_queue(ctrl, i,
-					   ctrl->ctrl.opts->queue_size);
-		if (ret) {
-			dev_info(ctrl->ctrl.device,
-				"failed to initialize i/o queue: %d\n", ret);
+		ret = nvme_rdma_alloc_queue(ctrl, i,
+				ctrl->ctrl.sqsize + 1);
+		if (ret)
 			goto out_free_queues;
-		}
 	}
 
 	return 0;
@@ -745,7 +742,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
 {
 	int error;
 
-	error = nvme_rdma_init_queue(ctrl, 0, NVME_AQ_DEPTH);
+	error = nvme_rdma_alloc_queue(ctrl, 0, NVME_AQ_DEPTH);
 	if (error)
 		return error;
 
@@ -832,7 +829,7 @@ static int nvme_rdma_configure_io_queues(struct nvme_rdma_ctrl *ctrl, bool new)
 {
 	int ret;
 
-	ret = nvme_rdma_init_io_queues(ctrl);
+	ret = nvme_rdma_alloc_io_queues(ctrl);
 	if (ret)
 		return ret;
 
-- 
2.7.4
