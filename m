From: hch@lst.de (Christoph Hellwig)
Date: Thu,  5 Oct 2017 18:46:46 +0200
Subject: [PATCH] nvme: simplify compat_ioctl handling
Message-ID: <20171005164646.17473-1-hch@lst.de>

We can just use our normal ioctl handler for the compat case and remove
the boilerplate code for it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 26c8913435b2..573cc3b59bfa 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1052,16 +1052,6 @@ static int nvme_ioctl(struct block_device *bdev, fmode_t mode,
 	}
 }
 
-#ifdef CONFIG_COMPAT
-static int nvme_compat_ioctl(struct block_device *bdev, fmode_t mode,
-			unsigned int cmd, unsigned long arg)
-{
-	return nvme_ioctl(bdev, mode, cmd, arg);
-}
-#else
-#define nvme_compat_ioctl	NULL
-#endif
-
 static int nvme_open(struct block_device *bdev, fmode_t mode)
 {
 	return nvme_get_ns_from_disk(bdev->bd_disk) ? 0 : -ENXIO;
@@ -1380,7 +1370,7 @@ EXPORT_SYMBOL_GPL(nvme_sec_submit);
 static const struct block_device_operations nvme_fops = {
 	.owner		= THIS_MODULE,
 	.ioctl		= nvme_ioctl,
-	.compat_ioctl	= nvme_compat_ioctl,
+	.compat_ioctl	= nvme_ioctl,
 	.open		= nvme_open,
 	.release	= nvme_release,
 	.getgeo		= nvme_getgeo,
-- 
2.14.1
