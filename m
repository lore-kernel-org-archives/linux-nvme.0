From: shhuiw@foxmail.com (Wang Sheng-Hui)
Date: Thu, 28 Apr 2016 16:19:31 +0800
Subject: [PATCH] NVMe: nvme_core_exit() should do cleanup in the reverse order
 as nvme_core_init does
Message-ID: <1461831571-5248-1-git-send-email-shhuiw@foxmail.com>

nvme_core_init does:
    1) register_blkdev
    2) __register_chrdev
    3) class_create

nvme_core_exit should do cleanup in the reverse order.

Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..49bc4c0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1607,9 +1607,9 @@ int __init nvme_core_init(void)
 
 void nvme_core_exit(void)
 {
-	unregister_blkdev(nvme_major, "nvme");
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
+	unregister_blkdev(nvme_major, "nvme");
 }
 
 MODULE_LICENSE("GPL");
-- 
2.7.4
