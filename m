From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Fri,  1 Dec 2017 00:49:17 +0900
Subject: [PATCH] nvme-cli: update show_registers_cc() to use nvme.h
Message-ID: <1512056957-17841-1-git-send-email-minwoo.im.dev@gmail.com>

Replace constants for shift in show_register_cc() with macros defined.
Also clean up a small typo (IOSQES to IOCQES).

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 nvme-print.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/nvme-print.c b/nvme-print.c
index db11dd7..e84c73f 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1923,11 +1923,11 @@ static void show_registers_cc_shn (__u8 shn)
 
 static void show_registers_cc(__u32 cc)
 {
-	printf("\tI/O Completion Queue Entry Size (IOSQES): %u bytes\n", 1 <<   ((cc & 0x00f00000) >> 20));
-	printf("\tI/O Submission Queue Entry Size (IOSQES): %u bytes\n", 1 <<   ((cc & 0x000f0000) >> 16));
-	show_registers_cc_shn((cc & 0x0000c000) >> 14);
-	show_registers_cc_ams((cc & 0x00003800) >> 11);
-	printf("\tMemory Page Size                   (MPS): %u bytes\n", 1 <<  (12 + ((cc & 0x00000780) >> 7)));
+	printf("\tI/O Completion Queue Entry Size (IOCQES): %u bytes\n", 1 << ((cc & 0x00f00000) >> NVME_CC_IOCQES_SHIFT));
+	printf("\tI/O Submission Queue Entry Size (IOSQES): %u bytes\n", 1 << ((cc & 0x000f0000) >> NVME_CC_IOSQES_SHIFT));
+	show_registers_cc_shn((cc & 0x0000c000) >> NVME_CC_SHN_SHIFT);
+	show_registers_cc_ams((cc & 0x00003800) >> NVME_CC_AMS_SHIFT);
+	printf("\tMemory Page Size                   (MPS): %u bytes\n", 1 << (12 + ((cc & 0x00000780) >> NVME_CC_MPS_SHIFT)));
 	printf("\tI/O Command Sets Selected          (CSS): %s\n", (cc & 0x00000070) ? "Reserved":"NVM Command Set");
 	printf("\tEnable                              (EN): %s\n\n", (cc & 0x00000001) ? "Yes":"No");
 }
-- 
2.7.4
