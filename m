From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:11 -0600
Subject: [PATCH 09/13] nvmet: Fix nvmet_execute_write_zeroes sector count
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-10-keith.busch@intel.com>

From: "Rodrigo R. Galvao" <rosattig@linux.vnet.ibm.com>

We have to increment the number of logical blocks to a 1's based value
in the native format prior to converting to 512b units.

Signed-off-by: Rodrigo R. Galvao <rosattig at linux.vnet.ibm.com>
[changelog]
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/target/io-cmd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
index 28bbdff4a88b..cd2344179673 100644
--- a/drivers/nvme/target/io-cmd.c
+++ b/drivers/nvme/target/io-cmd.c
@@ -173,8 +173,8 @@ static void nvmet_execute_write_zeroes(struct nvmet_req *req)
 
 	sector = le64_to_cpu(write_zeroes->slba) <<
 		(req->ns->blksize_shift - 9);
-	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length)) <<
-		(req->ns->blksize_shift - 9)) + 1;
+	nr_sector = (((sector_t)le16_to_cpu(write_zeroes->length) + 1) <<
+		(req->ns->blksize_shift - 9));
 
 	if (__blkdev_issue_zeroout(req->ns->bdev, sector, nr_sector,
 				GFP_KERNEL, &bio, 0))
-- 
2.14.3
