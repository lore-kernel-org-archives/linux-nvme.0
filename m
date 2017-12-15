From: minwoo.im.dev@gmail.com (Minwoo Im)
Date: Sat, 16 Dec 2017 03:02:51 +0900
Subject: [PATCH 2/2] nvme-cli: add a status code of Firmware Commit command
In-Reply-To: <1513360971-15566-1-git-send-email-minwoo.im.dev@gmail.com>
References: <1513360971-15566-1-git-send-email-minwoo.im.dev@gmail.com>
Message-ID: <1513360971-15566-3-git-send-email-minwoo.im.dev@gmail.com>

NVMe 1.3 spec introduced Boot Partition feature with Boot Partition
Write Prohibited status code for Firmware Commit command.

Add this status code and print statement when parsing error code.

Signed-off-by: Minwoo Im <minwoo.im.dev at gmail.com>
---
 linux/nvme.h | 1 +
 nvme-print.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/linux/nvme.h b/linux/nvme.h
index e21610f..a15e6b8 100644
--- a/linux/nvme.h
+++ b/linux/nvme.h
@@ -1188,6 +1188,7 @@ enum {
 	NVME_SC_NS_NOT_ATTACHED		= 0x11a,
 	NVME_SC_THIN_PROV_NOT_SUPP	= 0x11b,
 	NVME_SC_CTRL_LIST_INVALID	= 0x11c,
+	NVME_SC_BP_WRITE_PROHIBITED	= 0x11e,
 
 	/*
 	 * I/O Command Set Specific - NVM commands:
diff --git a/nvme-print.c b/nvme-print.c
index 87f0766..ef00c41 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -1206,6 +1206,7 @@ char *nvme_status_to_string(__u32 status)
 	case NVME_SC_NS_NOT_ATTACHED:		return "NS_NOT_ATTACHED";
 	case NVME_SC_THIN_PROV_NOT_SUPP:	return "THIN_PROVISIONING_NOT_SUPPORTED";
 	case NVME_SC_CTRL_LIST_INVALID:		return "CONTROLLER_LIST_INVALID";
+	case NVME_SC_BP_WRITE_PROHIBITED:	return "BOOT PARTITION WRITE PROHIBITED";
 	case NVME_SC_BAD_ATTRIBUTES:		return "BAD_ATTRIBUTES";
 	case NVME_SC_WRITE_FAULT:		return "WRITE_FAULT";
 	case NVME_SC_READ_ERROR:		return "READ_ERROR";
-- 
2.7.4
