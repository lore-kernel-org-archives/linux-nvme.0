From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue,  6 Jun 2017 16:36:11 +0200
Subject: [PATCH v5 3/9] nvme: introduce NVMe Namespace Identification
 Descriptor structures
In-Reply-To: <20170606143617.32143-1-jthumshirn@suse.de>
References: <20170606143617.32143-1-jthumshirn@suse.de>
Message-ID: <20170606143617.32143-4-jthumshirn@suse.de>

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
 include/linux/nvme.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c004af5faa48..22da030a28c6 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -289,6 +289,7 @@ enum {
 	NVME_ID_CNS_NS			= 0x00,
 	NVME_ID_CNS_CTRL		= 0x01,
 	NVME_ID_CNS_NS_ACTIVE_LIST	= 0x02,
+	NVME_ID_CNS_NS_DESC_LIST	= 0x03,
 	NVME_ID_CNS_NS_PRESENT_LIST	= 0x10,
 	NVME_ID_CNS_NS_PRESENT		= 0x11,
 	NVME_ID_CNS_CTRL_NS_LIST	= 0x12,
@@ -315,6 +316,22 @@ enum {
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
-- 
2.12.3
