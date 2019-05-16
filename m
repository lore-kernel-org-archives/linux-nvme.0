From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 May 2019 20:21:08 -0700
Subject: [RFC PATCH 3/4] nvmet: set iopriority for each bio
In-Reply-To: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190516032109.13048-5-chaitanya.kulkarni@wdc.com>

This patch sets up the bio iopriority value before we submit this bio.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/io-cmd-bdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 3efc52f9c309..099dba477df8 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -152,6 +152,7 @@ static void nvmet_bdev_execute_rw(struct nvmet_req *req)
 			bio_set_dev(bio, req->ns->bdev);
 			bio->bi_iter.bi_sector = sector;
 			bio_set_op_attrs(bio, op, op_flags);
+			bio_set_prio(bio, req->port->ioprio);
 
 			bio_chain(bio, prev);
 			submit_bio(prev);
-- 
2.17.0
