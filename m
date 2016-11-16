From: scott.bauer@intel.com (Scott Bauer)
Date: Wed, 16 Nov 2016 16:17:29 -0700
Subject: [PATCH v1 4/7] include: Add sec_ops to block device operations
In-Reply-To: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
References: <1479338252-8777-1-git-send-email-scott.bauer@intel.com>
Message-ID: <1479338252-8777-5-git-send-email-scott.bauer@intel.com>

Signed-off-by: Scott Bauer <scott.bauer at intel.com>
Signed-off-by: Rafael Antognolli <Rafael.Antognolli at intel.com>
---
 include/linux/blkdev.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index c47c358..6fceff1 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1690,6 +1690,7 @@ struct block_device_operations {
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	struct module *owner;
 	const struct pr_ops *pr_ops;
+	struct sec_ops *sec_ops;
 };
 
 extern int __blkdev_driver_ioctl(struct block_device *, fmode_t, unsigned int,
-- 
2.7.4
