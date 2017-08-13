From: maxg@mellanox.com (Max Gurtovoy)
Date: Sun, 13 Aug 2017 19:21:06 +0300
Subject: [PATCH 1/2] nvme: Add symbolic constants for CC identifiers
Message-ID: <1502641267-2984-1-git-send-email-maxg@mellanox.com>

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c |   14 +++++++-------
 include/linux/nvme.h       |   24 +++++++++++++++---------
 2 files changed, 22 insertions(+), 16 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index f4b02bb..9955c2d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -538,37 +538,37 @@ void nvmet_req_uninit(struct nvmet_req *req)
 
 static inline bool nvmet_cc_en(u32 cc)
 {
-	return cc & 0x1;
+	return (cc >> NVME_CC_EN_SHIFT) & 0x1;
 }
 
 static inline u8 nvmet_cc_css(u32 cc)
 {
-	return (cc >> 4) & 0x7;
+	return (cc >> NVME_CC_CSS_SHIFT) & 0x7;
 }
 
 static inline u8 nvmet_cc_mps(u32 cc)
 {
-	return (cc >> 7) & 0xf;
+	return (cc >> NVME_CC_MPS_SHIFT) & 0xf;
 }
 
 static inline u8 nvmet_cc_ams(u32 cc)
 {
-	return (cc >> 11) & 0x7;
+	return (cc >> NVME_CC_AMS_SHIFT) & 0x7;
 }
 
 static inline u8 nvmet_cc_shn(u32 cc)
 {
-	return (cc >> 14) & 0x3;
+	return (cc >> NVME_CC_SHN_SHIFT) & 0x3;
 }
 
 static inline u8 nvmet_cc_iosqes(u32 cc)
 {
-	return (cc >> 16) & 0xf;
+	return (cc >> NVME_CC_IOSQES_SHIFT) & 0xf;
 }
 
 static inline u8 nvmet_cc_iocqes(u32 cc)
 {
-	return (cc >> 20) & 0xf;
+	return (cc >> NVME_CC_IOCQES_SHIFT) & 0xf;
 }
 
 static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 25d8225..ebbe6e8 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -133,16 +133,22 @@ enum {
 enum {
 	NVME_CC_ENABLE		= 1 << 0,
 	NVME_CC_CSS_NVM		= 0 << 4,
+	NVME_CC_EN_SHIFT	= 0,
+	NVME_CC_CSS_SHIFT	= 4,
 	NVME_CC_MPS_SHIFT	= 7,
-	NVME_CC_ARB_RR		= 0 << 11,
-	NVME_CC_ARB_WRRU	= 1 << 11,
-	NVME_CC_ARB_VS		= 7 << 11,
-	NVME_CC_SHN_NONE	= 0 << 14,
-	NVME_CC_SHN_NORMAL	= 1 << 14,
-	NVME_CC_SHN_ABRUPT	= 2 << 14,
-	NVME_CC_SHN_MASK	= 3 << 14,
-	NVME_CC_IOSQES		= NVME_NVM_IOSQES << 16,
-	NVME_CC_IOCQES		= NVME_NVM_IOCQES << 20,
+	NVME_CC_AMS_SHIFT	= 11,
+	NVME_CC_SHN_SHIFT	= 14,
+	NVME_CC_IOSQES_SHIFT	= 16,
+	NVME_CC_IOCQES_SHIFT	= 20,
+	NVME_CC_ARB_RR		= 0 << NVME_CC_AMS_SHIFT,
+	NVME_CC_ARB_WRRU	= 1 << NVME_CC_AMS_SHIFT,
+	NVME_CC_ARB_VS		= 7 << NVME_CC_AMS_SHIFT,
+	NVME_CC_SHN_NONE	= 0 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_NORMAL	= 1 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_ABRUPT	= 2 << NVME_CC_SHN_SHIFT,
+	NVME_CC_SHN_MASK	= 3 << NVME_CC_SHN_SHIFT,
+	NVME_CC_IOSQES		= NVME_NVM_IOSQES << NVME_CC_IOSQES_SHIFT,
+	NVME_CC_IOCQES		= NVME_NVM_IOCQES << NVME_CC_IOCQES_SHIFT,
 	NVME_CSTS_RDY		= 1 << 0,
 	NVME_CSTS_CFS		= 1 << 1,
 	NVME_CSTS_NSSRO		= 1 << 4,
-- 
1.7.1
