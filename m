From: keith.busch@linux.intel.com (Keith Busch)
Date: Wed, 2 May 2018 10:32:58 -0600
Subject: [PATCH] nvme: configure discard at init time
In-Reply-To: <b3e2875b-f58a-f49c-1ded-a8c362b026ca@kernel.dk>
References: <b3e2875b-f58a-f49c-1ded-a8c362b026ca@kernel.dk>
Message-ID: <20180502163258.GI5938@localhost.localdomain>

On Wed, May 02, 2018@09:52:07AM -0600, Jens Axboe wrote:
> Currently nvme reconfigures discard for every disk revalidation.  This
> is problematic because any O_WRONLY or O_RDWR open will trigger a
> partition scan through udev/systemd, and we will reconfigure discard.
> This blows away any user settings, like discard_max_bytes.
> 
> Configure discard at init time instead.
> 
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> 
> ---
> 
> I'm open to other suggestions as well, currently it sucks that you'd
> have to continually re-configure the discard settings when someone opens
> the device for writing.

Your suggestion is probably fine. The only problem I can think of is a
_very_ unlikely scenario where a firmware update adds discard support,
then a user would have to reload the module in order to expose the
capability.

How about this?

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a3771c5729f5..18191547e4bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1353,6 +1353,10 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
 {
 	u32 size = queue_logical_block_size(queue);
 
+	/* don't reset discard queue limits */
+	if (blk_queue_flag_test_and_set(QUEUE_FLAG_DISCARD, queue))
+		return;
+
 	if (stream_alignment)
 		size *= stream_alignment;
 
@@ -1364,7 +1368,6 @@ static void nvme_config_discard(struct nvme_ctrl *ctrl,
 
 	blk_queue_max_discard_sectors(queue, UINT_MAX);
 	blk_queue_max_discard_segments(queue, NVME_DSM_MAX_RANGES);
-	blk_queue_flag_set(QUEUE_FLAG_DISCARD, queue);
 
 	if (ctrl->quirks & NVME_QUIRK_DEALLOCATE_ZEROES)
 		blk_queue_max_write_zeroes_sectors(queue, UINT_MAX);
--
