From: rosattig@linux.vnet.ibm.com (Rodrigo R. Galvao)
Date: Fri, 30 Mar 2018 18:18:50 -0300
Subject: [PATCH] nvmet: fix nvmet_execute_write_zeroes function
Message-ID: <1522444730-2060-1-git-send-email-rosattig@linux.vnet.ibm.com>

When trying to issue write_zeroes command against TARGET the nr_sector is
being incremented by 1, which ends up hitting the following condition at
__blkdev_issue_zeroout:

     if ((sector | nr_sects) & bs_mask)
                return -EINVAL;

Causing the command to always fail. Removing the increment makes the
command to work properly.

Signed-off-by: Rodrigo R. Galvao <rosattig at linux.vnet.ibm.com>
---
 drivers/nvme/target/io-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff..8d72686 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -174,7 +174,7 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
 	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
-- 
2.7.4
