From: joshi.k@samsung.com (Kanchan Joshi)
Date: Thu, 25 Apr 2019 16:49:57 +0530
Subject: [PATCH v5 2/7] block: increase stream count for in-kernel use
In-Reply-To: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
References: <1556191202-3245-1-git-send-email-joshi.k@samsung.com>
 <CGME20190425112355epcas2p11e197c8fc33698feb7150d1f4148407e@epcas2p1.samsung.com>
Message-ID: <1556191202-3245-3-git-send-email-joshi.k@samsung.com>

This bumps up stream count to support in-kernel hints.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/blkdev.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 317ab30..2826225 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -565,7 +565,9 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
-#define BLK_MAX_WRITE_HINTS	5
+#define BLK_MAX_USER_HINTS     (WRITE_LIFE_KERN_MIN - 2)
+#define BLK_MAX_KERN_HINTS     4
+#define BLK_MAX_WRITE_HINTS    (1 + BLK_MAX_USER_HINTS + BLK_MAX_KERN_HINTS)
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-- 
2.7.4
