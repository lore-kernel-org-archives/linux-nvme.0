From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 18 Jan 2019 16:54:06 -0800
Subject: [PATCH] nvme-rdma: rework queue maps handling
Message-ID: <20190119005406.12855-1-sagi@grimberg.me>

If the device supports less queues than provided (if the device has less
completion vectors), we might hit a bug due to the fact that we ignore
that in nvme_rdma_map_queues (we override the maps nr_queues with user
opts).

Instead, keep track of how many default/read/poll queues we actually
allocated (rather than asked by the user) and use that to assign our
queue mappings.

Fixes: b65bb777ef22 (" nvme-rdma: support separate queue maps for read and write")
Reported-by: Saleem, Shiraz <shiraz.saleem at intel.com>
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 37 ++++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 079d59c04a0e..24a5b6783f29 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -119,6 +119,7 @@ struct nvme_rdma_ctrl {
 
 	struct nvme_ctrl	ctrl;
 	bool			use_inline_data;
+	u32			io_queues[HCTX_MAX_TYPES];
 };
 
 static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
@@ -165,8 +166,8 @@ static inline int nvme_rdma_queue_idx(struct nvme_rdma_queue *queue)
 static bool nvme_rdma_poll_queue(struct nvme_rdma_queue *queue)
 {
 	return nvme_rdma_queue_idx(queue) >
-		queue->ctrl->ctrl.opts->nr_io_queues +
-		queue->ctrl->ctrl.opts->nr_write_queues;
+		queue->ctrl->io_queues[HCTX_TYPE_DEFAULT] +
+		queue->ctrl->io_queues[HCTX_TYPE_READ];
 }
 
 static inline size_t nvme_rdma_inline_data_size(struct nvme_rdma_queue *queue)
@@ -661,8 +662,20 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	nr_io_queues = min_t(unsigned int, nr_io_queues,
 				ibdev->num_comp_vectors);
 
-	nr_io_queues += min(opts->nr_write_queues, num_online_cpus());
-	nr_io_queues += min(opts->nr_poll_queues, num_online_cpus());
+	ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
+	if (opts->nr_write_queues) {
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
+				min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues += ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
+	}
+
+	if (opts->nr_poll_queues) {
+		ctrl->io_queues[HCTX_TYPE_POLL] =
+			min(opts->nr_poll_queues, num_online_cpus());
+		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
+	}
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
@@ -1781,17 +1794,15 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
 
 	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
-	set->map[HCTX_TYPE_READ].nr_queues = ctrl->ctrl.opts->nr_io_queues;
+	set->map[HCTX_TYPE_DEFAULT].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	set->map[HCTX_TYPE_READ].nr_queues = ctrl->io_queues[HCTX_TYPE_READ];
 	if (ctrl->ctrl.opts->nr_write_queues) {
 		/* separate read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-				ctrl->ctrl.opts->nr_write_queues;
 		set->map[HCTX_TYPE_READ].queue_offset =
-				ctrl->ctrl.opts->nr_write_queues;
+				ctrl->io_queues[HCTX_TYPE_DEFAULT];
 	} else {
 		/* mixed read/write queues */
-		set->map[HCTX_TYPE_DEFAULT].nr_queues =
-				ctrl->ctrl.opts->nr_io_queues;
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
@@ -1801,12 +1812,12 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 
 	if (ctrl->ctrl.opts->nr_poll_queues) {
 		set->map[HCTX_TYPE_POLL].nr_queues =
-				ctrl->ctrl.opts->nr_poll_queues;
+				ctrl->io_queues[HCTX_TYPE_POLL];
 		set->map[HCTX_TYPE_POLL].queue_offset =
-				ctrl->ctrl.opts->nr_io_queues;
+				ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		if (ctrl->ctrl.opts->nr_write_queues)
 			set->map[HCTX_TYPE_POLL].queue_offset +=
-				ctrl->ctrl.opts->nr_write_queues;
+				ctrl->io_queues[HCTX_TYPE_READ];
 		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	}
 	return 0;
-- 
2.17.1
