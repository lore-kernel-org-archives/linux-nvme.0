From: axboe@kernel.dk (Jens Axboe)
Date: Wed, 2 May 2018 10:41:03 -0600
Subject: [PATCH] nvme: configure discard at init time
In-Reply-To: <20180502163258.GI5938@localhost.localdomain>
References: <b3e2875b-f58a-f49c-1ded-a8c362b026ca@kernel.dk>
 <20180502163258.GI5938@localhost.localdomain>
Message-ID: <42987d9b-7e55-940c-79a3-c0454358d342@kernel.dk>

On 5/2/18 10:32 AM, Keith Busch wrote:
> On Wed, May 02, 2018@09:52:07AM -0600, Jens Axboe wrote:
>> Currently nvme reconfigures discard for every disk revalidation.  This
>> is problematic because any O_WRONLY or O_RDWR open will trigger a
>> partition scan through udev/systemd, and we will reconfigure discard.
>> This blows away any user settings, like discard_max_bytes.
>>
>> Configure discard at init time instead.
>>
>> Signed-off-by: Jens Axboe <axboe at kernel.dk>
>>
>> ---
>>
>> I'm open to other suggestions as well, currently it sucks that you'd
>> have to continually re-configure the discard settings when someone opens
>> the device for writing.
> 
> Your suggestion is probably fine. The only problem I can think of is a
> _very_ unlikely scenario where a firmware update adds discard support,
> then a user would have to reload the module in order to expose the
> capability.
> 
> How about this?

If we add discard through a firmware upgrade, we should also handle
the case where we lose discard through a firmware upgrade/downgrade.
Not that any of them are likely to ever happen, but...

How about this? Also handles the case where streams values are updated.


diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9df4f71e58ca..b0c1f1ce8226 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1347,13 +1347,19 @@ static void nvme_set_chunk_size(struct nvme_ns *ns)
 	blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(chunk_size));
 }
 
-static void nvme_config_discard(struct nvme_ctrl *ctrl,
-		unsigned stream_alignment, struct request_queue *queue)
+static void nvme_config_discard(struct nvme_ns *ns)
 {
+	struct nvme_ctrl *ctrl = ns->ctrl;
+	struct request_queue *queue = ns->queue;
 	u32 size = queue_logical_block_size(queue);
 
-	if (stream_alignment)
-		size *= stream_alignment;
+	if (!(ctrl->oncs & NVME_CTRL_ONCS_DSM)) {
+		blk_queue_flag_clear(QUEUE_FLAG_DISCARD, queue);
+		return;
+	}
+
+	if (ctrl->nr_streams && ns->sws && ns->sgs)
+		size *= ns->sws * ns->sgs;
 
 	BUILD_BUG_ON(PAGE_SIZE / sizeof(struct nvme_dsm_range) <
 			NVME_DSM_MAX_RANGES);
@@ -1361,6 +1367,10 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
 	queue->limits.discard_alignment = 0;
 	queue->limits.discard_granularity = size;
 
+	/* If discard is already enabled, don't reset queue limits */
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
+		return;
+
 	blk_queue_max_discard_sectors(queue, UINT_MAX);
 	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
 	blk_queue_flag_set(QUEUE_FLAG_DISCARD, queue);
@@ -1407,10 +1417,6 @@ static void nvme_update_disk_info(struct gendisk *disk,
 {
 	sector_t capacity = le64_to_cpup(&id->nsze) << (ns->lba_shift - 9);
 	unsigned short bs = 1 << ns->lba_shift;
-	unsigned stream_alignment = 0;
-
-	if (ns->ctrl->nr_streams && ns->sws && ns->sgs)
-		stream_alignment = ns->sws * ns->sgs;
 
 	blk_mq_freeze_queue(disk->queue);
 	blk_integrity_unregister(disk);
@@ -1427,7 +1433,7 @@ static void nvme_update_disk_info(struct gendisk *disk,
 	set_capacity(disk, capacity);
 
 	if (ns->ctrl->oncs & NVME_CTRL_ONCS_DSM)
-		nvme_config_discard(ns->ctrl, stream_alignment, disk->queue);
+		nvme_config_discard(ns);
 	blk_mq_unfreeze_queue(disk->queue);
 }
 

-- 
Jens Axboe
