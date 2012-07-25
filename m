From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jul 2012 16:05:18 -0600
Subject: [PATCH] NVMe: Fix nvme module init when nvme_major is set
Message-ID: <1343253918-32481-1-git-send-email-keith.busch@intel.com>

register_blkdev returns 0 when given a valid major number.

Reported-by:Ross Zwisler <ross.zwisler at intel.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 38b9c73..46e33ee 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1716,9 +1716,11 @@ static int __init nvme_init(void)
 	if (IS_ERR(nvme_thread))
 		return PTR_ERR(nvme_thread);
 
-	nvme_major = register_blkdev(nvme_major, "nvme");
-	if (nvme_major <= 0)
+	result = register_blkdev(nvme_major, "nvme");
+	if (result < 0)
 		goto kill_kthread;
+	else if (result > 0)
+	    nvme_major = result;
 
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-- 
1.7.0.4
