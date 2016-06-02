From: neilb@suse.com (NeilBrown)
Date: Thu, 02 Jun 2016 16:43:18 +1000
Subject: [PATCH 2/2] NVMe: don't allocate unused nvme_major
In-Reply-To: <20160602064306.4403.72816.stgit@noble>
References: <20160602064306.4403.72816.stgit@noble>
Message-ID: <20160602064318.4403.93301.stgit@noble>

When alloc_disk(0) is used, the ->major number is ignored.  All device
numbers are allocated with a major of BLOCK_EXT_MAJOR.

So remove all references to nvme_major.

Reviewed-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: NeilBrown <neilb at suse.com>
---
 drivers/nvme/host/core.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1a51584a382b..238b8863f9ab 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -47,9 +47,6 @@ unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
 MODULE_PARM_DESC(shutdown_timeout, "timeout in seconds for controller shutdown");
 
-static int nvme_major;
-module_param(nvme_major, int, 0);
-
 static int nvme_char_major;
 module_param(nvme_char_major, int, 0);
 
@@ -1445,8 +1442,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	blk_queue_logical_block_size(ns->queue, 1 << ns->lba_shift);
 	nvme_set_queue_limits(ctrl, ns->queue);
 
-	disk->major = nvme_major;
-	disk->first_minor = 0;
 	disk->fops = &nvme_fops;
 	disk->private_data = ns;
 	disk->queue = ns->queue;
@@ -1848,16 +1843,10 @@ int __init nvme_core_init(void)
 {
 	int result;
 
-	result = register_blkdev(nvme_major, "nvme");
-	if (result < 0)
-		return result;
-	else if (result > 0)
-		nvme_major = result;
-
 	result = __register_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme",
 							&nvme_dev_fops);
 	if (result < 0)
-		goto unregister_blkdev;
+		return result;
 	else if (result > 0)
 		nvme_char_major = result;
 
@@ -1871,8 +1860,6 @@ int __init nvme_core_init(void)
 
  unregister_chrdev:
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
- unregister_blkdev:
-	unregister_blkdev(nvme_major, "nvme");
 	return result;
 }
 
