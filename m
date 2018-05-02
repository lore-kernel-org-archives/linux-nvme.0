From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 2 May 2018 09:52:07 -0600
Subject: [PATCH] nvme: configure discard at init time
Message-ID: <b3e2875b-f58a-f49c-1ded-a8c362b026ca@kernel.dk>

Currently nvme reconfigures discard for every disk revalidation.  This
is problematic because any O_WRONLY or O_RDWR open will trigger a
partition scan through udev/systemd, and we will reconfigure discard.
This blows away any user settings, like discard_max_bytes.

Configure discard at init time instead.

Signed-off-by: Jens Axboe <axboe at kernel.dk>

---

I'm open to other suggestions as well, currently it sucks that you'd
have to continually re-configure the discard settings when someone opens
the device for writing.

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71e58ca..a35aa8050749 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1347,13 +1347,13 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ctrl *ctrl,
-		unsigned stream_alignment, struct request_queue *queue)
+static void nvme_config_discard(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
+	struct request_queue *queue = ns->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (stream_alignment)
-		size *= stream_alignment;
+	if (ctrl->nr_streams && ns->sws && ns->sgs)
+		size *= ns->sws * ns->sgs;
 
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
@@ -1426,8 +1426,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 		capacity = 0;
 	set_capacity(disk, capacity);
 
-	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns->ctrl, stream_alignment, disk->queue);
 	blk_mq_unfreeze_queue(disk->queue);
 }
 
@@ -3043,6 +3041,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	__nvme_revalidate_disk(disk, id);
 
+	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
+		nvme_config_discard(ctrl, ns);
+
 	down_write(&ctrl->namespaces_rwsem);
 	list_add_tail(&ns->list, &ctrl->namespaces);
 	up_write(&ctrl->namespaces_rwsem);

-- 
Jens Axboe
