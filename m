From: keith.busch@intel.com (Keith Busch)
Date: Fri, 21 Nov 2014 15:16:32 -0700
Subject: [PATCH] NVMe: Update module version major number
Message-ID: <1416608192-15924-1-git-send-email-keith.busch@intel.com>

It's already near impossible to tell what bits someone is running based on
a 'modinfo nvme', and I don't want to try guessing if someone is running
blk-mq or bio-based. Let's make it obvious with the module version that
the blk-mq conversion is a major change. Future bio-based versions can
increment to 0.10 in a fork if revisions occur.

Cc: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Based on linux-block for-next

 drivers/block/nvme-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index dbb4aae..0da7756 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2966,6 +2966,6 @@ static void __exit nvme_exit(void)
 
 MODULE_AUTHOR("Matthew Wilcox <willy at linux.intel.com>");
 MODULE_LICENSE("GPL");
-MODULE_VERSION("0.9");
+MODULE_VERSION("1.0");
 module_init(nvme_init);
 module_exit(nvme_exit);
-- 
1.7.10.4
