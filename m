From: mnghuan@gmail.com (Minfei Huang)
Date: Tue, 17 May 2016 15:58:41 +0800
Subject: [PATCH V2] Use MACRO UINT_MAX instead of actual value
Message-ID: <1463471921-20261-1-git-send-email-mnghuan@gmail.com>

It's more elegant to use MACRO UINT_MAX to represent the max value of
type unsigned int. So replace the actual value by using this MACRO.

Signed-off-by: Minfei Huang <mnghuan at gmail.com>
---
v1:
- fix typo
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..2c0bb13 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -597,7 +597,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
 
 	ns->queue->limits.discard_alignment = logical_block_size;
 	ns->queue->limits.discard_granularity = logical_block_size;
-	blk_queue_max_discard_sectors(ns->queue, 0xffffffff);
+	blk_queue_max_discard_sectors(ns->queue, UINT_MAX);
 	queue_flag_set_unlocked(QUEUE_FLAG_DISCARD, ns->queue);
 }
 
-- 
2.6.3
