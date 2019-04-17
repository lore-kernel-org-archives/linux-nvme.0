From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 17 Apr 2019 23:20:01 +0530
Subject: [PATCH v4 2/7] block: increase stream count for in-kernel use
In-Reply-To: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175353epcas2p1eaec3fea0bf26bb97416149e11b1317e@epcas2p1.samsung.com>
Message-ID: <1555523406-2380-3-git-send-email-joshi.k@samsung.com>

This bumps up stream count to support in-kernel hints.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/blkdev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5c58a3b..f200aed 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -566,7 +566,9 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
-#define BLK_MAX_WRITE_HINTS	5
+#define BLK_MAX_USER_HINTS     (WRITE_LIFE_KERN_MIN - 2)
+#define BLK_MAX_KERN_HINTS     4
+#define BLK_MAX_WRITE_HINTS    (1 + BLK_MAX_USER_HINTS + BLK_MAX_KERN_HINTS)
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-- 
2.7.4
