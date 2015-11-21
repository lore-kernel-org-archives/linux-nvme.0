From: hch@lst.de (Christoph Hellwig)
Date: Sat, 21 Nov 2015 08:19:54 +0100
Subject: [PATCH 14/47] nvme: move nvme_error_status to common code
In-Reply-To: <1448090427-18749-1-git-send-email-hch@lst.de>
References: <1448090427-18749-1-git-send-email-hch@lst.de>
Message-ID: <1448090427-18749-15-git-send-email-hch@lst.de>

And mark it inline so that we don't slow down the completion path by
having to turn it into a forced out of line call.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/nvme.h | 12 ++++++++++++
 drivers/nvme/host/pci.c  | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 71e81e5..c06bb9c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -86,6 +86,18 @@ static inline u64 nvme_block_nr(struct nvme_ns *ns, sector_t sector)
 	return (sector >> (ns->lba_shift - 9));
 }
 
+static inline int nvme_error_status(u16 status)
+{
+	switch (status & 0x7ff) {
+	case NVME_SC_SUCCESS:
+		return 0;
+	case NVME_SC_CAP_EXCEEDED:
+		return -ENOSPC;
+	default:
+		return -EIO;
+	}
+}
+
 int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void *buf, unsigned bufflen);
 int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 74a829b..92fb388 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -545,18 +545,6 @@ static void nvme_free_iod(struct nvme_dev *dev, struct nvme_iod *iod)
 		kfree(iod);
 }
 
-static int nvme_error_status(u16 status)
-{
-	switch (status & 0x7ff) {
-	case NVME_SC_SUCCESS:
-		return 0;
-	case NVME_SC_CAP_EXCEEDED:
-		return -ENOSPC;
-	default:
-		return -EIO;
-	}
-}
-
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 static void nvme_dif_prep(u32 p, u32 v, struct t10_pi_tuple *pi)
 {
-- 
1.9.1
