From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 23 May 2019 21:10:03 -0700
Subject: [PATCH 1/2] nvme-rdma: fix queue mapping when queue count is limited
Message-ID: <20190524041004.23200-1-sagi@grimberg.me>

When the controller supports less queues than requested, we
should make sure that queue mapping does the right thing and
not assume that all queues are available. This fixes a crash
when the controller supports less queues than requested.

The rules are:
1. if no write/poll queues are requested, we assign the available queues
   to the default queue map. The default and read queue maps share the
   existing queues.
2. if write queues are requested:
  - first make sure that read queue map gets the requested
    nr_io_queues count
  - then grant the default queue map the minimum between the requested
    nr_write_queues and the remaining queues. If there are no available
    queues to dedicate to the default queue map, fallback to (1) and
    share all the queues in the existing queue map.
3. if poll queues are requested:
  - map the remaining queues to the poll queue map.

Also, provide a log indication on how we constructed the different
queue maps.

One side-affect change is that we remove the rdma device number of
completion vectors device limitation when setting the queue count.
No rdma device uses managed affinity so there is no real reason as
we cannot guarantee any vector based queue mapping. This change is
squashed here because this patch needs to go to stable kernel and
its simpler having it here than having it live on its own without
a clear indication why it ended up in stable kenrels.

Reported-by: Harris, James R <james.r.harris at intel.com>
Cc: <stable at vger.kernel.org> # v5.0+
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/rdma.c | 94 ++++++++++++++++++++++++----------------
 1 file changed, 56 insertions(+), 38 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index f383146e7d0f..cd7d93727b30 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -640,35 +640,12 @@ static int nvme_rdma_start_io_queues(struct nvme_rdma_ctrl *ctrl)
 static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 {
 	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
-	struct ib_device *ibdev = ctrl->device->dev;
 	unsigned int nr_io_queues;
 	int i, ret;
 
-	nr_io_queues = min(opts->nr_io_queues, num_online_cpus());
-
-	/*
-	 * we map queues according to the device irq vectors for
-	 * optimal locality so we don't need more queues than
-	 * completion vectors.
-	 */
-	nr_io_queues = min_t(unsigned int, nr_io_queues,
-				ibdev->num_comp_vectors);
-
-	if (opts->nr_write_queues) {
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
-				min(opts->nr_write_queues, nr_io_queues);
-		nr_io_queues += ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	} else {
-		ctrl->io_queues[HCTX_TYPE_DEFAULT] = nr_io_queues;
-	}
-
-	ctrl->io_queues[HCTX_TYPE_READ] = nr_io_queues;
-
-	if (opts->nr_poll_queues) {
-		ctrl->io_queues[HCTX_TYPE_POLL] =
-			min(opts->nr_poll_queues, num_online_cpus());
-		nr_io_queues += ctrl->io_queues[HCTX_TYPE_POLL];
-	}
+	nr_io_queues = min(opts->nr_io_queues, num_online_cpus()) +
+		min(opts->nr_write_queues, num_online_cpus()) +
+		min(opts->nr_poll_queues, num_online_cpus());
 
 	ret = nvme_set_queue_count(&ctrl->ctrl, &nr_io_queues);
 	if (ret)
@@ -681,6 +658,34 @@ static int nvme_rdma_alloc_io_queues(struct nvme_rdma_ctrl *ctrl)
 	dev_info(ctrl->ctrl.device,
 		"creating %d I/O queues.\n", nr_io_queues);
 
+	if (opts->nr_write_queues && opts->nr_io_queues < nr_io_queues) {
+		/*
+		 * separate read/write queues
+		 * hand out dedicated default queues only after we have
+		 * sufficient read queues.
+		 */
+		ctrl->io_queues[HCTX_TYPE_READ] = opts->nr_io_queues;
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_READ];
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_write_queues, nr_io_queues);
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	} else {
+		/*
+		 * shared read/write queues
+		 * either no write queues were requested, or we don't have
+		 * sufficient queue count to have dedicated default queues.
+		 */
+		ctrl->io_queues[HCTX_TYPE_DEFAULT] =
+			min(opts->nr_io_queues, nr_io_queues);
+		nr_io_queues -= ctrl->io_queues[HCTX_TYPE_DEFAULT];
+	}
+
+	if (opts->nr_poll_queues && nr_io_queues) {
+		/* map dedicated poll queues only if we have queues left */
+		ctrl->io_queues[HCTX_TYPE_POLL] =
+			min(opts->nr_poll_queues, nr_io_queues);
+	}
+
 	for (i = 1; i < ctrl->ctrl.queue_count; i++) {
 		ret = nvme_rdma_alloc_queue(ctrl, i,
 				ctrl->ctrl.sqsize + 1);
@@ -1763,17 +1768,24 @@ static void nvme_rdma_complete_rq(struct request *rq)
 static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_rdma_ctrl *ctrl = set->driver_data;
+	struct nvmf_ctrl_options *opts = ctrl->ctrl.opts;
 
-	set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
-	set->map[HCTX_TYPE_DEFAULT].nr_queues =
-			ctrl->io_queues[HCTX_TYPE_DEFAULT];
-	set->map[HCTX_TYPE_READ].nr_queues = ctrl->io_queues[HCTX_TYPE_READ];
-	if (ctrl->ctrl.opts->nr_write_queues) {
+	if (opts->nr_write_queues && ctrl->io_queues[HCTX_TYPE_READ]) {
 		/* separate read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_READ];
 		set->map[HCTX_TYPE_READ].queue_offset =
-				ctrl->io_queues[HCTX_TYPE_DEFAULT];
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 	} else {
-		/* mixed read/write queues */
+		/* shared read/write queues */
+		set->map[HCTX_TYPE_DEFAULT].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
+		set->map[HCTX_TYPE_DEFAULT].queue_offset = 0;
+		set->map[HCTX_TYPE_READ].nr_queues =
+			ctrl->io_queues[HCTX_TYPE_DEFAULT];
 		set->map[HCTX_TYPE_READ].queue_offset = 0;
 	}
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_DEFAULT],
@@ -1781,16 +1793,22 @@ static int nvme_rdma_map_queues(struct blk_mq_tag_set *set)
 	blk_mq_rdma_map_queues(&set->map[HCTX_TYPE_READ],
 			ctrl->device->dev, 0);
 
-	if (ctrl->ctrl.opts->nr_poll_queues) {
+	if (opts->nr_poll_queues && ctrl->io_queues[HCTX_TYPE_POLL]) {
+		/* map dedicated poll queues only if we have queues left */
 		set->map[HCTX_TYPE_POLL].nr_queues =
 				ctrl->io_queues[HCTX_TYPE_POLL];
 		set->map[HCTX_TYPE_POLL].queue_offset =
-				ctrl->io_queues[HCTX_TYPE_DEFAULT];
-		if (ctrl->ctrl.opts->nr_write_queues)
-			set->map[HCTX_TYPE_POLL].queue_offset +=
-				ctrl->io_queues[HCTX_TYPE_READ];
+			ctrl->io_queues[HCTX_TYPE_DEFAULT] +
+			ctrl->io_queues[HCTX_TYPE_READ];
 		blk_mq_map_queues(&set->map[HCTX_TYPE_POLL]);
 	}
+
+	dev_info(ctrl->ctrl.device,
+		"mapped %d/%d/%d default/read/poll queues.\n",
+		ctrl->io_queues[HCTX_TYPE_DEFAULT],
+		ctrl->io_queues[HCTX_TYPE_READ],
+		ctrl->io_queues[HCTX_TYPE_POLL]);
+
 	return 0;
 }
 
-- 
2.17.1
