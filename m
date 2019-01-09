From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 09 Jan 2019 21:00:58 +0530
Subject: [PATCH 1/4] block: Increase count of supported write-hints
In-Reply-To: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <CGME20190109153332epcas1p187b419176a8d1d0be4982a275c0b9e86@epcas1p1.samsung.com>
Message-ID: <1547047861-7271-2-git-send-email-joshi.k@samsung.com>

This patch bumps up write-hint count to support four new, in-kernel
hints.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/blkdev.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 338604d..df07759 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -568,7 +568,10 @@ struct request_queue {
 
 	struct work_struct	release_work;
 
-#define BLK_MAX_WRITE_HINTS	5
+#define BLK_MAX_USER_WRITE_HINTS	5
+#define BLK_MAX_KERNEL_WRITE_HINTS	4
+#define BLK_MAX_WRITE_HINTS	(BLK_MAX_USER_WRITE_HINTS + \
+				BLK_MAX_KERNEL_WRITE_HINTS)
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
 
-- 
2.7.4
