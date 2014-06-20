From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 20 Jun 2014 16:32:00 -0400
Subject: New status code additions
Message-ID: <20140620203200.GP12025@linux.intel.com>


I'm just reviewing the draft NVMe 1.1b spec and I noticed we're missing
a few new status codes.  Any objections to the following?

diff --git a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
index 29a7d86..134518b 100644
--- a/include/uapi/linux/nvme.h
+++ b/include/uapi/linux/nvme.h
@@ -440,9 +440,15 @@ enum {
 	NVME_SC_FUSED_MISSING		= 0xa,
 	NVME_SC_INVALID_NS		= 0xb,
 	NVME_SC_CMD_SEQ_ERROR		= 0xc,
+	NVME_SC_SGL_INVALID_LAST	= 0xd,
+	NVME_SC_SGL_INVALID_COUNT	= 0xe,
+	NVME_SC_SGL_INVALID_DATA	= 0xf,
+	NVME_SC_SGL_INVALID_METADATA	= 0x10,
+	NVME_SC_SGL_INVALID_TYPE	= 0x11,
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
+	NVME_SC_RESERVATION_CONFLICT	= 0x83,
 	NVME_SC_CQ_INVALID		= 0x100,
 	NVME_SC_QID_INVALID		= 0x101,
 	NVME_SC_QUEUE_SIZE		= 0x102,
@@ -454,7 +460,15 @@ enum {
 	NVME_SC_INVALID_VECTOR		= 0x108,
 	NVME_SC_INVALID_LOG_PAGE	= 0x109,
 	NVME_SC_INVALID_FORMAT		= 0x10a,
+	NVME_SC_FIRMWARE_NEEDS_RESET	= 0x10b,
+	NVME_SC_INVALID_QUEUE		= 0x10c,
+	NVME_SC_FEATURE_NOT_SAVEABLE	= 0x10d,
+	NVME_SC_FEATURE_NOT_CHANGEABLE	= 0x10e,
+	NVME_SC_FEATURE_NOT_PER_NS	= 0x10f,
+	NVME_SC_FW_NEEDS_RESET_SUBSYS	= 0x110,
 	NVME_SC_BAD_ATTRIBUTES		= 0x180,
+	NVME_SC_INVALID_PI		= 0x181,
+	NVME_SC_READ_ONLY		= 0x182,
 	NVME_SC_WRITE_FAULT		= 0x280,
 	NVME_SC_READ_ERROR		= 0x281,
 	NVME_SC_GUARD_CHECK		= 0x282,
