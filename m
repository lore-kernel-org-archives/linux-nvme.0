From: hch@lst.de (Christoph Hellwig)
Date: Thu, 20 Apr 2017 16:03:12 +0200
Subject: [PATCH 19/23] floppy: switch from req->errors to req->error_count
In-Reply-To: <20170420140316.6546-1-hch@lst.de>
References: <20170420140316.6546-1-hch@lst.de>
Message-ID: <20170420140316.6546-20-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/block/floppy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index ce102ec47ef2..60d4c7653178 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -2805,8 +2805,10 @@ static int set_next_request(void)
 			fdc_queue = 0;
 		if (q) {
 			current_req = blk_fetch_request(q);
-			if (current_req)
+			if (current_req) {
+				current_req->error_count = 0;
 				break;
+			}
 		}
 	} while (fdc_queue != old_pos);
 
@@ -2866,7 +2868,7 @@ static void redo_fd_request(void)
 		_floppy = floppy_type + DP->autodetect[DRS->probed_format];
 	} else
 		probing = 0;
-	errors = &(current_req->errors);
+	errors = &(current_req->error_count);
 	tmp = make_raw_rw_request();
 	if (tmp < 2) {
 		request_done(tmp);
-- 
2.11.0
