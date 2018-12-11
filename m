From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 15:36:50 -0800
Subject: [PATCH RFC 3/4] nvme-rdma: implement polling queue map
In-Reply-To: <20181211233652.9705-1-sagi@grimberg.me>
References: <20181211233652.9705-1-sagi@grimberg.me>
Message-ID: <20181211233652.9705-4-sagi@grimberg.me>

Every nvmf queue starts with a connect message that is the slow path
at setup time, and there is no need for polling (it is actually
hurtful). Instead, allocate the polling queue cq with IB_POLL_SOFTIRQ
and switch it to IB_POLL_DIRECT where it makes sense.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 35 +++++++++++++++++++++++++++++++++--
 1 file changed, 33 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 6a7c546b4e74..590d006d0187 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -607,6 +607,11 @@ static int nvme_rdma_start_queue(struct nvme_rdma_ctrl *ctrl, int idx)
 	else
 		dev_info(ctrl->ctrl.device,
 			"failed to connect queue: %d ret=%d\n", idx, ret);
+
+	if (idx > ctrl->ctrl.opts->nr_io_queues +
+	    ctrl->ctrl.opts->nr_write_queues)
+		ib_change_cq_ctx(ctrl->queues[idx].ib_cq, IB_POLL_DIRECT);
+
 	return ret;
 }
 
@@ -646,6 +651,7 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 				ibdev->num_comp_vectors);
 
 	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
+	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
@@ -716,7 +722,7 @@ static struct blk_mq_tag_set *nvme_rdma_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
-		set->nr_maps = 2 /* default + read */;
+		set->nr_maps = HCTX_MAX_TYPES;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1742,6 +1748,14 @@ static blk_status_t nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_IOERR;
 }
 
+static int nvme_rdma_poll(struct blk_mq_hw_ctx *hctx)
+{
+	struct nvme_rdma_queue *queue = hctx->driver_data;
+	struct ib_cq *cq = queue->ib_cq;
+
+	return ib_process_cq_direct(cq, 16);
+}
+
 static void nvme_rdma_complete_rq(struct request *rq)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
@@ -1772,6 +1786,21 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 			ctrl->device->dev, 0);
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
 			ctrl->device->dev, 0);
+
+	if (ctrl->ctrl.opts->nr_poll_queues) {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_poll_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset =
+				ctrl->ctrl.opts->nr_io_queues;
+		if (ctrl->ctrl.opts->nr_write_queues)
+			set->map[HCTX_TYPE_POLL].queue_offset +=
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		set->map[HCTX_TYPE_POLL].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_POLL].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	return 0;
 }
 
@@ -1783,6 +1812,7 @@ static const struct blk_mq_ops nvme_rdma_mq_ops = {
 	.init_hctx	= nvme_rdma_init_hctx,
 	.timeout	= nvme_rdma_timeout,
 	.map_queues	= nvme_rdma_map_queues,
+	.poll		= nvme_rdma_poll,
 };
 
 static const struct blk_mq_ops nvme_rdma_admin_mq_ops = {
@@ -1927,7 +1957,8 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
+				opts->nr_poll_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
-- 
2.17.1
