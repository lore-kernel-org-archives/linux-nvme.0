From: joshi.k@samsung.com (Kanchan Joshi)
Date: Wed, 09 Jan 2019 21:00:59 +0530
Subject: [PATCH 2/4] fs: introduce four macros for in-kernel hints
In-Reply-To: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
References: <1547047861-7271-1-git-send-email-joshi.k@samsung.com>
 <CGME20190109153336epcas2p29b3275b6c545e483a3f43b92268f08bf@epcas2p2.samsung.com>
Message-ID: <1547047861-7271-3-git-send-email-joshi.k@samsung.com>

Exiting write-hints are exposed to user-mode. There is a possiblity
of conflict if kernel happens to use those. This patch introduces four
write-hints for exclusive kernel-mode use.

Signed-off-by: Kanchan Joshi <joshi.k at samsung.com>
---
 include/linux/fs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 811c777..e8548eb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -291,6 +291,11 @@ enum rw_hint {
 	WRITE_LIFE_MEDIUM	= RWH_WRITE_LIFE_MEDIUM,
 	WRITE_LIFE_LONG		= RWH_WRITE_LIFE_LONG,
 	WRITE_LIFE_EXTREME	= RWH_WRITE_LIFE_EXTREME,
+/* below ones are meant for in-kernel use */
+	KERN_WRITE_LIFE_SHORT,
+	KERN_WRITE_LIFE_MEDIUM,
+	KERN_WRITE_LIFE_LONG,
+	KERN_WRITE_LIFE_EXTREME
 };
 
 #define IOCB_EVENTFD		(1 << 0)
-- 
2.7.4
