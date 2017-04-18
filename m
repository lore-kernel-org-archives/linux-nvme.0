From: guanjunxiong@huawei.com (Guan Junxiong)
Date: Tue, 18 Apr 2017 21:19:52 +0800
Subject: [PATCH] nvme:let dm-mpath distinguish nvme error codes,no retry
Message-ID: <1492521592-20648-1-git-send-email-guanjunxiong@huawei.com>

From: Junxiong Guan <guanjunxiong@huawei.com>

Currently most IOs which return the nvme error codes are retried on
the other path if those IOs returns EIO from NVMe driver. This
patch let Multipath distinguish nvme media error codes and some
generic or cmd-specific nvme error codes so that multipath will
not retry those kinds of IO, to save bandwidth.
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9bf758e3c911..7b4abd7926e6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -71,8 +71,29 @@ static int nvme_error_status(struct request *req)
 	switch (nvme_req(req)->status & 0x7ff) {
 	case NVME_SC_SUCCESS:
 		return 0;
+
+	/*
+	 * Generic Command Status:
+	 */
+	case NVME_SC_CMD_SEQ_ERROR:
+		return -EILSEQ;
 	case NVME_SC_CAP_EXCEEDED:
 		return -ENOSPC;
+
+	/*
+	 * I/O Command Set Specific - NVM commands
+	 */
+	case NVME_SC_ONCS_NOT_SUPPORTED:
+		return -EOPNOTSUPP;
+
+	/*
+	 * Media and Integrity Erros
+	 */
+	case NVME_SC_WRITE_FAULT:
+	case NVME_SC_READ_ERROR:
+	case NVME_SC_UNWRITTEN_BLOCK:
+		return -ENODATA;
+
 	default:
 		return -EIO;
 	}
-- 
2.11.1

This patch is base on the request-errors branch of the git tree:
git://git.infradead.org/users/hch/block.git
