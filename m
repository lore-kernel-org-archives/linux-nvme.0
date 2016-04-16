From: hch@lst.de (Christoph Hellwig)
Date: Sat, 16 Apr 2016 14:57:58 -0400
Subject: [PATCH] nvme: fix cntlid type
Message-ID: <1460833078-15646-1-git-send-email-hch@lst.de>

Controller IDs in NVMe are unsigned 16-bit types.  In the Fabrics driver we
actually pass ctrl->id by reference, so we need it to have the correct type.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8e8fae8..9b96e75 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -84,7 +84,7 @@ struct nvme_ctrl {
 	char serial[20];
 	char model[40];
 	char firmware_rev[8];
-	int cntlid;
+	u16 cntlid;
 
 	u32 ctrl_config;
 
-- 
2.1.4
