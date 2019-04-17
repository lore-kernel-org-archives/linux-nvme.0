From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 17 Apr 2019 23:20:00 +0530
Subject: [PATCH v4 1/7] fs: introduce write-hint start point for in-kernel
 hints
In-Reply-To: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
References: <1555523406-2380-1-git-send-email-joshi.k@samsung.com>
 <CGME20190417175351epcas1p481ec1bd87188022020a504447e88fde4@epcas1p4.samsung.com>
Message-ID: <1555523406-2380-2-git-send-email-joshi.k@samsung.com>

Introduce "WRITE_LIFE_KERN_MIN". Kernel mode components can define own
write-hints using this as base.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd28e76..ee27eb4 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -299,6 +299,8 @@ enum rw_hint {
 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+/* Kernel should use write-hint starting from this */
+	WRITE_LIFE_KERN_MIN,
 };
 
 #define IOCB_EVENTFD		(1 << 0)
-- 
2.7.4
