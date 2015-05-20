From: parav.pandit@avagotech.com (Parav Pandit)
Date: Wed, 20 May 2015 16:43:47 -0400
Subject: [PATCHv1] NVMe: nvme_queue made cache friendly.
Message-ID: <1432154627-12336-1-git-send-email-parav.pandit@avagotech.com>

nvme_queue structure made 64B cache friendly so that majority of the
data elements of the structure during IO and completion path can be
found in typical single 64B cache line size which was previously spanning
beyond single 64B cache line size.

By aligning most of the fields are found at start of the structure.
Elements which are not used in frequent IO path are moved at the
end of structure.

Signed-off-by: Parav Pandit <parav.pandit at avagotech.com>
---
 drivers/block/nvme-core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b9ba36f..58041c7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -98,23 +98,23 @@ struct async_cmd_info {
 struct nvme_queue {
 	struct device *q_dmadev;
 	struct nvme_dev *dev;
-	char irqname[24];	/* nvme4294967295-65535\0 */
-	spinlock_t q_lock;
 	struct nvme_command *sq_cmds;
+	struct blk_mq_hw_ctx *hctx;
 	volatile struct nvme_completion *cqes;
-	dma_addr_t sq_dma_addr;
-	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
+	spinlock_t q_lock;
 	u16 q_depth;
-	s16 cq_vector;
 	u16 sq_head;
 	u16 sq_tail;
 	u16 cq_head;
 	u16 qid;
+	s16 cq_vector;
 	u8 cq_phase;
 	u8 cqe_seen;
 	struct async_cmd_info cmdinfo;
-	struct blk_mq_hw_ctx *hctx;
+	char irqname[24];	/* nvme4294967295-65535\0 */
+	dma_addr_t sq_dma_addr;
+	dma_addr_t cq_dma_addr;
 };
 
 /*
-- 
1.8.3.1
