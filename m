From: hch@bombadil.infradead.org (Christoph Hellwig)
Date: Tue, 18 Apr 2017 08:52:26 -0700
Subject: swim3: remove (commented out) printing of req->errors
In-Reply-To: <20170418155229.5977-1-hch@bombadil.infradead.org>
References: <20170418155229.5977-1-hch@bombadil.infradead.org>
Message-ID: <20170418155229.5977-21-hch@bombadil.infradead.org>

From: Christoph Hellwig <hch@lst.de>

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
