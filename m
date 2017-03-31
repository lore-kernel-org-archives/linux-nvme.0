From: hch@lst.de (Christoph Hellwig)
Date: Fri, 31 Mar 2017 17:00:07 +0200
Subject: [PATCH 3/4] nvmet: fix byte swap in nvmet_execute_write_zeroes
In-Reply-To: <20170331150008.16034-1-hch@lst.de>
References: <20170331150008.16034-1-hch@lst.de>
Message-ID: <20170331150008.16034-4-hch@lst.de>

The length field in the Write Zeroes command is a 16-bit field.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/target/io-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 4195115c7e54..e37acd77b5fe 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -180,7 +180,7 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le32_to_cpu(write_zeroes->length)) <<
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
 		(req->ns->blksize_shift - 9)) + 1;
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
-- 
2.11.0
