From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 02:49:35 -0800
Subject: [PATCH 5/5] nvme-rdma: support read/write queue separation
In-Reply-To: <20181211104936.25333-1-sagi@grimberg.me>
References: <20181211104936.25333-1-sagi@grimberg.me>
Message-ID: <20181211104936.25333-6-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 39 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 36 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 5057d5ab5aaa..cfe823a491f2 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -645,6 +645,8 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	nr_io_queues = min_t(unsigned int, nr_io_queues,
 				ibdev->num_comp_vectors);
 
+	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
+
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
 		return ret;
@@ -714,6 +716,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
+		set->nr_maps = 2 /* default + read */;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1750,8 +1753,37 @@ static void nvme_rdma_complete_rq(struct request *rq)
 static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+	struct blk_mq_queue_map *map;
+	int offset = 0;
+
+	if (ctrl->ctrl.opts->nr_write_queues) {
+		/* separate read/write queues */
+		map = &set->map[HCTX_TYPE_DEFAULT];
+		map->queue_offset = offset;
+		map->nr_queues = ctrl->ctrl.opts->nr_write_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+		offset += map->nr_queues;
+
+		map = &set->map[HCTX_TYPE_READ];
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		map->queue_offset = offset;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, offset);
+		offset += map->nr_queues;
 
-	return blk_mq_rdma_map_queues(&set->map[0], ctrl->device->dev, 0);
+	} else {
+		/* mixed read/write queues */
+		map = &set->map[HCTX_TYPE_DEFAULT];
+		map->queue_offset = 0;
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+
+		map = &set->map[HCTX_TYPE_READ];
+		map->queue_offset = 0;
+		map->nr_queues = ctrl->ctrl.opts->nr_io_queues;
+		blk_mq_rdma_map_queues(map, ctrl->device->dev, 0);
+	}
+
+	return 0;
 }
 
 static const struct blk_mq_ops nvme_rdma_mq_ops = {
@@ -1906,7 +1938,7 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -1957,7 +1989,8 @@ static struct nvmf_transport_ops nvme_rdma_transport = {
 	.module		= THIS_MODULE,
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
-			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO,
+			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
+			  NVMF_OPT_NR_IO_QUEUES,
 	.create_ctrl	= nvme_rdma_create_ctrl,
 };
 
-- 
2.17.1
