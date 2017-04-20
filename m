From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Apr 2017 16:03:14 +0200
Subject: [PATCH 21/23] swim3: remove (commented out) printing of req->errors
In-Reply-To: <20170420140316.6546-1-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
Message-ID: <20170420140316.6546-22-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/swim3.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
index 61b3ffa4f458..ba4809c9bdba 100644
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -343,8 +343,8 @@ static void start_request(struct floppy_state *fs)
 			  req->rq_disk->disk_name, req->cmd,
 			  (long)blk_rq_pos(req), blk_rq_sectors(req),
 			  bio_data(req->bio));
-		swim3_dbg("           errors=%d current_nr_sectors=%u\n",
-			  req->errors, blk_rq_cur_sectors(req));
+		swim3_dbg("           current_nr_sectors=%u\n",
+			  blk_rq_cur_sectors(req));
 #endif
 
 		if (blk_rq_pos(req) >= fs->total_secs) {
-- 
2.11.0
