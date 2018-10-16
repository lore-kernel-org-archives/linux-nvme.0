From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:17 -0700
Subject: [PATCH v2 05/11] nvmet: Add defines for discovery change async events
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-6-git-send-email-jay.e.sternberg@intel.com>

Add AEN/AER values as defined by the specification

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
v2 - unchanged

 drivers/nvme/target/nvmet.h | 2 ++
 include/linux/nvme.h        | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e263330..dd7e5223 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -35,6 +35,8 @@
  */
 #define NVMET_AEN_CFG_OPTIONAL \
 	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_ANA_CHANGE)
+#define NVMET_DISC_AEN_CFG_OPTIONAL \
+	(NVME_AEN_CFG_DISC_CHANGE)
 
 /*
  * Plus mandatory SMART AENs (we'll never send them, but allow enabling them):
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 47b69d5..11ab828 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -481,18 +481,21 @@ enum {
 	NVME_AER_NOTICE_NS_CHANGED	= 0x00,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 	NVME_AER_NOTICE_ANA		= 0x03,
+	NVME_AER_NOTICE_DISC_CHANGED	= 0xf0,
 };
 
 enum {
 	NVME_AEN_BIT_NS_ATTR		= 8,
 	NVME_AEN_BIT_FW_ACT		= 9,
 	NVME_AEN_BIT_ANA_CHANGE		= 11,
+	NVME_AEN_BIT_DISC_CHANGE	= 31,
 };
 
 enum {
 	NVME_AEN_CFG_NS_ATTR		= BIT(NVME_AEN_BIT_NS_ATTR),
 	NVME_AEN_CFG_FW_ACT		= BIT(NVME_AEN_BIT_FW_ACT),
 	NVME_AEN_CFG_ANA_CHANGE		= BIT(NVME_AEN_BIT_ANA_CHANGE),
+	NVME_AEN_CFG_DISC_CHANGE	= BIT(NVME_AEN_BIT_DISC_CHANGE),
 };
 
 struct nvme_lba_range_type {
-- 
1.8.3.1
