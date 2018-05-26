From: hch@lst.de (Christoph Hellwig)
Date: Sat, 26 May 2018 12:27:22 +0200
Subject: [PATCH 01/14] block: unexport check_disk_size_change
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
Message-ID: <20180526102735.31404-2-hch@lst.de>

Only used in block_dev.c and the partitions code, and it should remain
that way..

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..771ddfa29dc9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1342,7 +1342,6 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
 			flush_disk(bdev, false);
 	}
 }
-EXPORT_SYMBOL(check_disk_size_change);
 
 /**
  * revalidate_disk - wrapper for lower-level driver's revalidate_disk call-back
-- 
2.17.0
