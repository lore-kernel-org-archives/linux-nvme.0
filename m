From: keith.busch@intel.com (Keith Busch)
Date: Mon, 15 Sep 2014 14:08:38 -0600
Subject: [PATCH] NVMe: Updates for 1.1 spec
Message-ID: <1410811718-14472-1-git-send-email-keith.busch@intel.com>

Updating commands and structures for NVMe 1.1 updates, mostly for nvme
reservations. There are no additional in-kernel uses, but this is for
the uapi.

While doing this, I noticed that the software progress features was
using the wrong value, so updating that value as well.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 include/uapi/linux/nvme.h |   27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 9710655..37a24f3 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -181,6 +181,22 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
+struct nvme_reservation_status {
+	__le32	gen;
+	__u8	rtype;
+	__u8	regctl[2];
+	__u8	resv5[2];
+	__u8	ptpls;
+	__u8	resv10[13];
+	struct {
+		__le16	cntlid;
+		__u8	rcsts;
+		__u8	resv3[5];
+		__le64	hostid;
+		__le64	rkey;
+	} regctl_ds[];
+};
+
 /* I/O commands */
 
 enum nvme_opcode {
@@ -189,7 +205,12 @@ enum nvme_opcode {
 	nvme_cmd_read		= 0x02,
 	nvme_cmd_write_uncor	= 0x04,
 	nvme_cmd_compare	= 0x05,
+	nvme_cmd_write_zeroes	= 0x08,
 	nvme_cmd_dsm		= 0x09,
+	nvme_cmd_resv_register	= 0x0d,
+	nvme_cmd_resv_report	= 0x0e,
+	nvme_cmd_resv_acquire	= 0x11,
+	nvme_cmd_resv_release	= 0x15,
 };
 
 struct nvme_common_command {
@@ -305,7 +326,11 @@ enum {
 	NVME_FEAT_IRQ_CONFIG	= 0x09,
 	NVME_FEAT_WRITE_ATOMIC	= 0x0a,
 	NVME_FEAT_ASYNC_EVENT	= 0x0b,
-	NVME_FEAT_SW_PROGRESS	= 0x0c,
+	NVME_FEAT_AUTO_PST	= 0x0c,
+	NVME_FEAT_SW_PROGRESS	= 0x80,
+	NVME_FEAT_HOST_ID	= 0x81,
+	NVME_FEAT_RESV_MASK	= 0x82,
+	NVME_FEAT_RESV_PERSIST	= 0x83,
 	NVME_LOG_ERROR		= 0x01,
 	NVME_LOG_SMART		= 0x02,
 	NVME_LOG_FW_SLOT	= 0x03,
-- 
1.7.10.4
