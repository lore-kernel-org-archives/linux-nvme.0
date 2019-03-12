From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Mar 2019 18:06:35 +0100
Subject: [PATCH 2/2] nvmet: avoid double errno conversions
In-Reply-To: <20190312170635.25470-1-hch@lst.de>
References: <20190312170635.25470-1-hch@lst.de>
Message-ID: <20190312170635.25470-2-hch@lst.de>

Use errno_to_nvme_status to convert from a negative errno to a
nvme status field instead of going through a blk_status_t.

Also remove the pointless status variable in
nvmet_bdev_execute_write_zeroes.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/io-cmd-bdev.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index df7e00de0dcd..f27d7bc5233f 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -196,7 +196,7 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 			GFP_KERNEL, 0, bio);
 	if (ret && ret != -EOPNOTSUPP) {
 		req->error_slba = le64_to_cpu(range->slba);
-		return blk_to_nvme_status(req, errno_to_blk_status(ret));
+		return errno_to_nvme_status(req, ret);
 	}
 
 	return 0;
@@ -253,7 +253,6 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 {
 	struct nvme_write_zeroes_cmd *write_zeroes = &req->cmd->write_zeroes;
 	struct bio *bio = NULL;
-	u16 status = NVME_SC_SUCCESS;
 	sector_t sector;
 	sector_t nr_sector;
 	int ret;
@@ -265,13 +264,12 @@ static void nvmet_bdev_execute_write_zeroes(struct nvmet_req *req)
 
 	ret = __blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 			GFP_KERNEL, &bio, 0);
-	status = blk_to_nvme_status(req, errno_to_blk_status(ret));
 	if (bio) {
 		bio->bi_private = req;
 		bio->bi_end_io = nvmet_bio_done;
 		submit_bio(bio);
 	} else {
-		nvmet_req_complete(req, status);
+		nvmet_req_complete(req, errno_to_nvme_status(req, ret));
 	}
 }
 
-- 
2.20.1
