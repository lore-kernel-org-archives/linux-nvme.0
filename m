From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:09 +0100
Subject: [PATCH 16/17] nvmet: ignore EOPNOTSUPP for discard
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-17-hch@lst.de>

NVMe DSM is a pure hint, so if the underlying device / file system
does not support discard-like operations we should not fail the
operation but rather return success.

Fixes: 3b031d15995f ("nvmet: add error log support for bdev backend")
Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Tested-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/io-cmd-bdev.c | 8 ++++----
 drivers/nvme/target/io-cmd-file.c | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 71dfedbadc26..a065dbfc43b1 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -194,11 +194,11 @@ static u16 nvmet_bdev_discard_range(struct nvmet_req *req,
 			le64_to_cpu(range->slba) << (ns->blksize_shift - 9),
 			le32_to_cpu(range->nlb) << (ns->blksize_shift - 9),
 			GFP_KERNEL, 0, bio);
-
-	if (ret)
+	if (ret && ret != -EOPNOTSUPP) {
 		req->error_slba = le64_to_cpu(range->slba);
-
-	return blk_to_nvme_status(req, errno_to_blk_status(ret));
+		return blk_to_nvme_status(req, errno_to_blk_status(ret));
+	}
+	return NVME_SC_SUCCESS;
 }
 
 static void nvmet_bdev_execute_discard(struct nvmet_req *req)
diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 517522305e5c..3e43212d3c1c 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -297,7 +297,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 		}
 
 		ret = vfs_fallocate(req->ns->file, mode, offset, len);
-		if (ret) {
+		if (ret && ret != -EOPNOTSUPP) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, ret);
 			break;
-- 
2.20.1
