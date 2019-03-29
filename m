From: joshi.k@samsung.com (Kanchan Joshi)
Date: Fri, 29 Mar 2019 13:23:51 +0530
Subject: [PATCH v3 6/7] fs: introduce write-hint start point for in-kernel
 hints
In-Reply-To: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
References: <1553846032-4451-1-git-send-email-joshi.k@samsung.com>
 <CGME20190329075758epcas1p335511dcb10bb5592ea72409a1d01e752@epcas1p3.samsung.com>
Message-ID: <1553846032-4451-7-git-send-email-joshi.k@samsung.com>

kernel-mode components can define own write-hints using
"WRITE_LIFE_KERN_MIN" as base.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 29d8e2c..6a2673e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -291,6 +291,8 @@ enum rw_hint {
 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+/* Kernel should use write-hint starting from this */
+	WRITE_LIFE_KERN_MIN,
 };
 
 #define IOCB_EVENTFD		(1 << 0)
-- 
2.7.4
