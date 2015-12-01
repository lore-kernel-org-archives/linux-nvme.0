From: hch@lst.de (Christoph Hellwig)
Date: Tue,  1 Dec 2015 19:52:42 +0100
Subject: [PATCH 07/26] nvme: add NVME_SC_CANCELLED
In-Reply-To: <1448995981-11982-1-git-send-email-hch@lst.de>
References: <1448995981-11982-1-git-send-email-hch@lst.de>
Message-ID: <1448995981-11982-8-git-send-email-hch@lst.de>

To properly document how we are using a negative Linux error value to
communicate request cancellations inside the driver.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 10 ++++++++++
 drivers/nvme/host/pci.c  |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b75d41e..88950f36 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -19,6 +19,16 @@
 #include <linux/kref.h>
 #include <linux/blk-mq.h>
 
+enum {
+	/*
+	 * Driver internal status code for commands that were cancelled due
+	 * to timeouts or controller shutdown.  The value is negative so
+	 * that it a) doesn't overlap with the unsigned hardware error codes,
+	 * and b) can easily be tested for.
+	 */
+	NVME_SC_CANCELLED		= -EINTR,
+};
+
 extern unsigned char nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 99c5b63..e683bd1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -621,7 +621,7 @@ static void req_completion(struct nvme_queue *nvmeq, void *ctx,
 
 		if (req->cmd_type == REQ_TYPE_DRV_PRIV) {
 			if (cmd_rq->ctx == CMD_CTX_CANCELLED)
-				error = -EINTR;
+				error = NVME_SC_CANCELLED;
 			else
 				error = status;
 		} else {
-- 
1.9.1
