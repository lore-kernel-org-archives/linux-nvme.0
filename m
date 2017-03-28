From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 28 Mar 2017 21:59:37 +0800
Subject: [PATCH] nvme: supplement nvme error status code enum items in
 linux/nvme.h
Message-ID: <1490709577-8204-1-git-send-email-guanjunxiong@huawei.com>

Some of the nvme status codes/values enumerated in the linux/nvme.h 
header file were omitted. Those left-out status codes/values include
0x12, 0x13, 0x14, 0x19,0x1A and 0x84 shown in the section 4.6.1 of 
NVMe Base Spec 1.2.1.  For furture use, those nvme error status code
are supplemented.

Signed-off-by: Junxiong Guan <guanjunxiong at huawei.com>
---
 include/linux/nvme.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c43d435d4225..fa4ea1103fc2 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -931,13 +931,22 @@ enum {
 	NVME_SC_SGL_INVALID_METADATA	= 0x10,
 	NVME_SC_SGL_INVALID_TYPE	= 0x11,
 
+	NMVE_SC_CMB_INVALID_USE		= 0x12,
+	NVME_SC_PRP_INVALID_OFFSET	= 0x13,
+	NVME_SC_ATOM_WRITE_UNIT_EXCEEDED = 0x14,
+
 	NVME_SC_SGL_INVALID_OFFSET	= 0x16,
 	NVME_SC_SGL_INVALID_SUBTYPE	= 0x17,
 
+	NVME_SC_HOST_ID_FMT_CONFLICT = 0x18,
+	NVME_SC_KATO_EXPIRED		 = 0x19,
+	NVME_SC_KATO_INVALID		 = 0x1a,
+
 	NVME_SC_LBA_RANGE		= 0x80,
 	NVME_SC_CAP_EXCEEDED		= 0x81,
 	NVME_SC_NS_NOT_READY		= 0x82,
 	NVME_SC_RESERVATION_CONFLICT	= 0x83,
+	NVME_SC_FORMAT_IN_PROGRESS		= 0x84,
 
 	/*
 	 * Command Specific Status:
-- 
2.11.1
