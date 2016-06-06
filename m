From: hch@lst.de (Christoph Hellwig)
Date: Mon,  6 Jun 2016 23:20:45 +0200
Subject: [PATCH 03/10] nvme.h: add NVM command set SQE/CQE size defines
In-Reply-To: <1465248052-17811-1-git-send-email-hch@lst.de>
References: <1465248052-17811-1-git-send-email-hch@lst.de>
Message-ID: <1465248052-17811-4-git-send-email-hch@lst.de>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 include/linux/nvme.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 9925b85..9807d98 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -50,6 +50,13 @@ enum {
 #define NVME_CMB_CQS(cmbsz)	((cmbsz) & 0x2)
 #define NVME_CMB_SQS(cmbsz)	((cmbsz) & 0x1)
 
+/*
+ * Submission and Completion Queue Entry Sizes for the NVM command set.
+ * (In bytes and specified as a power of two (2^n)).
+ */
+#define NVME_NVM_IOSQES		6
+#define NVME_NVM_IOCQES		4
+
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
@@ -61,8 +68,8 @@ enum {
 	NVME_CC_SHN_NORMAL	= 1 << 14,
 	NVME_CC_SHN_ABRUPT	= 2 << 14,
 	NVME_CC_SHN_MASK	= 3 << 14,
-	NVME_CC_IOSQES		= 6 << 16,
-	NVME_CC_IOCQES		= 4 << 20,
+	NVME_CC_IOSQES		= NVME_NVM_IOSQES << 16,
+	NVME_CC_IOCQES		= NVME_NVM_IOCQES << 20,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
-- 
2.1.4
