From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Wed, 29 Mar 2017 18:08:23 +0800
Subject: [PATCH] nvme: make nvme error status codes converted to errno detailed
Message-ID: <1490782103-14668-1-git-send-email-guanjunxiong@huawei.com>

From: Junxiong Guan <guanjunxiong@huawei.com>

For more detailed information about nvme error status when ending
blk_mq request,some of nvme error status codes can be categorized into
different errnos explicitly. For example, NVME_SC_ACCESS_DENIED and
NVME_SC_CONNECT_CTRL_BUSY can be converted to EACCESS and EBUSY repec-
tively.This patch makes conversion from those nvme error status to errno
detailed.
---
 drivers/nvme/host/nvme.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a3da1e90b99d..be699ca38cc8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -255,7 +255,37 @@ static inline int nvme_error_status(u16 status)
 	case NVME_SC_SUCCESS:
 		return 0;
 	case NVME_SC_CAP_EXCEEDED:
+	case NVME_SC_NS_INSUFFICENT_CAP:
 		return -ENOSPC;
+	case NVME_SC_READ_ONLY:
+	case NVME_SC_ACCESS_DENIED:
+		return -EACCES;
+	case NVME_SC_LBA_RANGE:
+		return -EFAULT;
+	case NVME_SC_CONNECT_CTRL_BUSY:
+		return -EBUSY;
+	case NVME_SC_INVALID_OPCODE:
+	case NVME_SC_INVALID_FIELD:
+	case NVME_SC_INVALID_NS:
+	case NVME_SC_SGL_INVALID_LAST:
+	case NVME_SC_SGL_INVALID_COUNT:
+	case NVME_SC_SGL_INVALID_DATA:
+	case NVME_SC_SGL_INVALID_METADATA:
+	case NVME_SC_SGL_INVALID_TYPE:
+	case NVME_SC_SGL_INVALID_OFFSET:
+	case NVME_SC_SGL_INVALID_SUBTYPE:
+	case NVME_SC_CQ_INVALID:
+	case NVME_SC_QID_INVALID:
+	case NVME_SC_QUEUE_SIZE:
+	case NVME_SC_FIRMWARE_SLOT:
+	case NVME_SC_FIRMWARE_IMAGE:
+	case NVME_SC_INVALID_VECTOR:
+	case NVME_SC_INVALID_LOG_PAGE:
+	case NVME_SC_INVALID_FORMAT:
+	case NVME_SC_CTRL_LIST_INVALID:
+		return -EINVAL;
+	case NVME_SC_CMD_SEQ_ERROR:
+		return -EPROTO;
 	default:
 		return -EIO;
 	}
-- 
2.11.1
