From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 12 Dec 2018 23:01:54 -0800
Subject: [PATCH] nvmet: remove unused varialbe
Message-ID: <20181213070154.15518-1-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index c1cb2ed5531c..e0831230ca27 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -61,7 +61,6 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 	struct bio *bio;
 	struct scatterlist *sg;
 	sector_t sector;
-	blk_qc_t cookie;
 	int op, op_flags = 0, i;
 
 	if (!req->sg_cnt) {
@@ -114,7 +113,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 		sg_cnt--;
 	}
 
-	cookie = submit_bio(bio);
+	submit_bio(bio);
 }
 
 static void nvmet_bdev_execute_flush(struct nvmet_req *req)
-- 
2.17.1
