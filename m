From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 26 Jul 2018 19:56:54 -0700
Subject: [PATCH V2 1/3] nvme: add support for ns write protect definitions
In-Reply-To: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
References: <20180727025656.9334-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180727025656.9334-2-chaitanya.kulkarni@wdc.com>

Add various definitions from NVMe 1.3 TP 4005.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 include/linux/nvme.h | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 80dfedcf0bf7..8514d4e0b597 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -254,7 +254,7 @@ struct nvme_id_ctrl {
 	__le16			awun;
 	__le16			awupf;
 	__u8			nvscc;
-	__u8			rsvd531;
+	__u8			nwpc;
 	__le16			acwu;
 	__u8			rsvd534[2];
 	__le32			sgls;
@@ -312,7 +312,9 @@ struct nvme_id_ns {
 	__le16			nabspf;
 	__le16			noiob;
 	__u8			nvmcap[16];
-	__u8			rsvd64[40];
+	__u8			rsvd64[32];
+	__u8			nsattr;
+	__u8			rsvd100[4];
 	__u8			nguid[16];
 	__u8			eui64[8];
 	struct nvme_lbaf	lbaf[16];
@@ -758,6 +760,7 @@ enum {
 	NVME_FEAT_HOST_ID	= 0x81,
 	NVME_FEAT_RESV_MASK	= 0x82,
 	NVME_FEAT_RESV_PERSIST	= 0x83,
+	NVME_FEAT_WRITE_PROTECT = 0x84,
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
@@ -770,6 +773,14 @@ enum {
 	NVME_FWACT_ACTV		= (2 << 3),
 };
 
+/* NVMe Namespace Write Protect State */
+enum {
+	NVME_NS_NO_WRITE_PROTECT = 0,
+	NVME_NS_WRITE_PROTECT,
+	NVME_NS_WRITE_PROTECT_POWER_CYCLE,
+	NVME_NS_WRITE_PROTECT_PERMANENT,
+};
+
 #define NVME_MAX_CHANGED_NAMESPACES	1024
 
 struct nvme_identify {
@@ -1116,6 +1127,8 @@ enum {
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_NS_WRITE_PROTECTED      = 0x20,
+
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
-- 
2.17.0
