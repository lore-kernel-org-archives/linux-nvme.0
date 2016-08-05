From: andrzej.jakowski@intel.com (Andrzej Jakowski)
Date: Fri,  5 Aug 2016 15:03:30 -0700
Subject: [PATCH] nvme: discard_alignment should be set to 0
Message-ID: <1470434610-4712-1-git-send-email-andrzej.jakowski@intel.com>

According to the documentation discard_alignment is acctually an offset
indicating how many bytes the beginning of the device is offset from
internal discard allocation unit. It should be either discovered from
underlying hardware or set to 0. Setting it to logical block size may
affect the mechanism of splitting discard request especially for
partitioned device and ultimately negatively impact performance.

Signed-off-by: Andrzej Jakowski <andrzej.jakowski at intel.com>
Signed-off-by: Michal Wysoczanski <michal.wysoczanski at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 74b1d38..8a3d371 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -879,7 +879,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
 	else
 		ns->queue->limits.discard_zeroes_data = 0;
 
-	ns->queue->limits.discard_alignment = logical_block_size;
+	ns->queue->limits.discard_alignment = 0;
 	ns->queue->limits.discard_granularity = logical_block_size;
 	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
-- 
2.5.5
