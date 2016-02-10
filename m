From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Feb 2016 16:52:47 -0700
Subject: [PATCH] block: Initialize max_dev_sectors to 0
Message-ID: <1455148367-25208-1-git-send-email-keith.busch@intel.com>

The new queue limit is not used by the majority of block drivers, and
should be initialized to 0 for the driver's requested settings to be used.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Christoph Hellwig <hch at infradead.org>
Acked-by: Martin K. Petersen <martin.petersen at oracle.com>
---
 block/blk-settings.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index dd49735..c7bb666 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -91,8 +91,8 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->seg_boundary_mask = BLK_SEG_BOUNDARY_MASK;
 	lim->virt_boundary_mask = 0;
 	lim->max_segment_size = BLK_MAX_SEGMENT_SIZE;
-	lim->max_sectors = lim->max_dev_sectors = lim->max_hw_sectors =
-		BLK_SAFE_MAX_SECTORS;
+	lim->max_sectors = lim->max_hw_sectors = BLK_SAFE_MAX_SECTORS;
+	lim->max_dev_sectors = 0;
 	lim->chunk_sectors = 0;
 	lim->max_write_same_sectors = 0;
 	lim->max_discard_sectors = 0;
-- 
2.6.2.307.g37023ba
