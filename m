From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Thu,  1 Jun 2017 13:17:43 +0200
Subject: [PATCH v2 1/8] nvme: introduce NVMe Namespace Identification
 Descriptor structures
In-Reply-To: <20170601111750.20880-1-jthumshirn@suse.de>
References: <20170601111750.20880-1-jthumshirn@suse.de>
Message-ID: <20170601111750.20880-2-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 include/linux/nvme.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b625bacf37ef..afa6ef484e50 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -288,6 +288,7 @@ enum {
 	NVME_ID_CNS_NS			= 0x00,
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
+	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -314,6 +315,22 @@ enum {
 	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
+struct nvme_ns_identifier_hdr {
+	__u8 nidt;
+	__u8 nidl;
+	__le16 reserved;
+};
+
+#define NVME_NIDT_EUI64_LEN	8
+#define NVME_NIDT_NGUID_LEN	16
+#define NVME_NIDT_UUID_LEN	16
+
+enum {
+	NVME_NIDT_EUI64		= 0x01,
+	NVME_NIDT_NGUID		= 0x02,
+	NVME_NIDT_UUID		= 0x03,
+};
+
 struct nvme_smart_log {
 	__u8			critical_warning;
 	__u8			temperature[2];
@@ -658,6 +675,8 @@ struct nvme_identify {
 	__u32			rsvd11[5];
 };
 
+#define NVME_IDENTIFY_DATA_SIZE 4096
+
 struct nvme_features {
 	__u8			opcode;
 	__u8			flags;
-- 
2.12.0
