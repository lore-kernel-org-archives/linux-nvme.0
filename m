From: shhuiw@foxmail.com (Wang Sheng-Hui)
Date: Wed, 27 Apr 2016 20:10:16 +0800
Subject: [PATCH] NVMe: correct comment for offset enum of controller registers
 in nvme.h
Message-ID: <1461759016-7829-1-git-send-email-shhuiw@foxmail.com>

Section 3.1 gives the comment for the offset of controller registers
in the specification 1.2a.

Some are mis-copied in the header file nvme.h. Correct them.

Signed-off-by: Wang Sheng-Hui <shhuiw at foxmail.com>
---
 include/linux/nvme.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index a55986f..7d51b29 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -21,13 +21,13 @@ enum {
 	NVME_REG_CAP	= 0x0000,	/* Controller Capabilities */
 	NVME_REG_VS	= 0x0008,	/* Version */
 	NVME_REG_INTMS	= 0x000c,	/* Interrupt Mask Set */
-	NVME_REG_INTMC	= 0x0010,	/* Interrupt Mask Set */
+	NVME_REG_INTMC	= 0x0010,	/* Interrupt Mask Clear */
 	NVME_REG_CC	= 0x0014,	/* Controller Configuration */
 	NVME_REG_CSTS	= 0x001c,	/* Controller Status */
 	NVME_REG_NSSR	= 0x0020,	/* NVM Subsystem Reset */
 	NVME_REG_AQA	= 0x0024,	/* Admin Queue Attributes */
 	NVME_REG_ASQ	= 0x0028,	/* Admin SQ Base Address */
-	NVME_REG_ACQ	= 0x0030,	/* Admin SQ Base Address */
+	NVME_REG_ACQ	= 0x0030,	/* Admin CQ Base Address */
 	NVME_REG_CMBLOC = 0x0038,	/* Controller Memory Buffer Location */
 	NVME_REG_CMBSZ	= 0x003c,	/* Controller Memory Buffer Size */
 };
-- 
2.8.1
