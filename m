From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 11 Dec 2018 23:38:57 -0800
Subject: [PATCH v3 4/5] nvme-tcp: support separate queue maps for read and
 write
In-Reply-To: <20181212073858.7102-1-sagi@grimberg.me>
References: <20181212073858.7102-1-sagi@grimberg.me>
Message-ID: <20181212073858.7102-5-sagi@grimberg.me>

Allow NVMF_OPT_NR_WRITE_QUEUES and allocate nvme queues for
write additionally. In addition, implement .map_queues that
will apply 2 queue maps for read and write queue sets.

Note that with the separate queue map, HCTX_TYPE_READ will always
use nr_io_queues and HCTX_TYPE_DEFAULT will use nr_write_queues.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/tcp.c | 47 +++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 15543358e245..51826479a41e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1215,7 +1215,7 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	struct nvme_tcp_ctrl *ctrl = to_tcp_ctrl(nctrl);
 	struct nvme_tcp_queue *queue = &ctrl->queues[qid];
 	struct linger sol = { .l_onoff = 1, .l_linger = 0 };
-	int ret, opt, rcv_pdu_size;
+	int ret, opt, rcv_pdu_size, n;
 
 	queue->ctrl = ctrl;
 	INIT_LIST_HEAD(&queue->send_list);
@@ -1271,7 +1271,11 @@ static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl,
 	}
 
 	queue->sock->sk->sk_allocation = GFP_ATOMIC;
-	queue->io_cpu = (qid == 0) ? 0 : qid - 1;
+	if (!qid)
+		n = 0;
+	else
+		n = (qid - 1) % num_online_cpus();
+	queue->io_cpu = cpumask_next_wrap(n - 1, cpu_online_mask, -1, false);
 	queue->request = NULL;
 	queue->data_remaining = 0;
 	queue->ddgst_remaining = 0;
@@ -1433,6 +1437,7 @@ static struct blk_mq_tag_set *nvme_tcp_alloc_tagset(struct nvme_ctrl *nctrl,
 		set->driver_data = ctrl;
 		set->nr_hw_queues = nctrl->queue_count - 1;
 		set->timeout = NVME_IO_TIMEOUT;
+		set->nr_maps = 2 /* default + read */;
 	}
 
 	ret = blk_mq_alloc_tag_set(set);
@@ -1527,7 +1532,12 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 
 static unsigned int nvme_tcp_nr_io_queues(struct nvme_ctrl *ctrl)
 {
-	return min(ctrl->queue_count - 1, num_online_cpus());
+	unsigned int nr_io_queues;
+
+	nr_io_queues = min(ctrl->opts->nr_io_queues, num_online_cpus());
+	nr_io_queues += min(ctrl->opts->nr_write_queues, num_online_cpus());
+
+	return nr_io_queues;
 }
 
 static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
@@ -2052,6 +2062,29 @@ static blk_status_t nvme_tcp_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return BLK_STS_OK;
 }
 
+static int nvme_tcp_map_queues(struct blk_mq_tag_set *set)
+{
+	struct nvme_tcp_ctrl *ctrl = set->driver_data;
+
+	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+	set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
+	if (ctrl->ctrl.opts->nr_write_queues) {
+		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_write_queues;
+		set->map[HCTX_TYPE_READ].queue_offset =
+				ctrl->ctrl.opts->nr_write_queues;
+	} else {
+		/* mixed read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+				ctrl->ctrl.opts->nr_io_queues;
+		set->map[HCTX_TYPE_READ].queue_offset = 0;
+	}
+	blk_mq_map_queues(&set->map[HCTX_TYPE_DEFAULT]);
+	blk_mq_map_queues(&set->map[HCTX_TYPE_READ]);
+	return 0;
+}
+
 static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.complete	= nvme_complete_rq,
@@ -2059,6 +2092,7 @@ static struct blk_mq_ops nvme_tcp_mq_ops = {
 	.exit_request	= nvme_tcp_exit_request,
 	.init_hctx	= nvme_tcp_init_hctx,
 	.timeout	= nvme_tcp_timeout,
+	.map_queues	= nvme_tcp_map_queues,
 };
 
 static struct blk_mq_ops nvme_tcp_admin_mq_ops = {
@@ -2113,7 +2147,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_LIST_HEAD(&ctrl->list);
 	ctrl->ctrl.opts = opts;
-	ctrl->ctrl.queue_count = opts->nr_io_queues + 1; /* +1 for admin queue */
+	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues + 1;
 	ctrl->ctrl.sqsize = opts->queue_size - 1;
 	ctrl->ctrl.kato = opts->kato;
 
@@ -2155,7 +2189,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 		goto out_free_ctrl;
 	}
 
-	ctrl->queues = kcalloc(opts->nr_io_queues + 1, sizeof(*ctrl->queues),
+	ctrl->queues = kcalloc(ctrl->ctrl.queue_count, sizeof(*ctrl->queues),
 				GFP_KERNEL);
 	if (!ctrl->queues) {
 		ret = -ENOMEM;
@@ -2206,7 +2240,8 @@ static struct nvmf_transport_ops nvme_tcp_transport = {
 	.required_opts	= NVMF_OPT_TRADDR,
 	.allowed_opts	= NVMF_OPT_TRSVCID | NVMF_OPT_RECONNECT_DELAY |
 			  NVMF_OPT_HOST_TRADDR | NVMF_OPT_CTRL_LOSS_TMO |
-			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST,
+			  NVMF_OPT_HDR_DIGEST | NVMF_OPT_DATA_DIGEST |
+			  NVMF_OPT_NR_WRITE_QUEUES,
 	.create_ctrl	= nvme_tcp_create_ctrl,
 };
 
-- 
2.17.1
