From: m@bjorling.me (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Fri,  5 Jun 2015 14:54:25 +0200
Subject: [PATCH v4 3/8] null_blk: wrong capacity when bs is not 512 bytes
In-Reply-To: <1433508870-28251-1-git-send-email-m@bjorling.me>
References: <1433508870-28251-1-git-send-email-m@bjorling.me>
Message-ID: <1433508870-28251-4-git-send-email-m@bjorling.me>

set_capacity() sets device capacity by the number of 512 bytes
sectors. null_blk calculates the number of sectors by size / bs
and calls set_capacity. This leads to the wrong number
of sectors when bs is not 512 bytes.

Signed-off-by: Matias Bj?rling <m at bjorling.me>
---
 drivers/block/null_blk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 65cd61a..79972ab 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -576,8 +576,7 @@ static int null_add_dev(void)
 	blk_queue_physical_block_size(nullb->q, bs);
 
 	size = gb * 1024 * 1024 * 1024ULL;
-	sector_div(size, bs);
-	set_capacity(disk, size);
+	set_capacity(disk, size >> 9);
 
 	disk->flags |= GENHD_FL_EXT_DEVT | GENHD_FL_SUPPRESS_PARTITION_INFO;
 	disk->major		= null_major;
-- 
2.1.4
