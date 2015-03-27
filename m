From: chong.yuan@memblaze.com (Chong Yuan)
Date: Fri, 27 Mar 2015 09:21:32 +0800
Subject: [PATCH] embedded iod mask cleanup
Message-ID: <1427419292-27518-1-git-send-email-chong.yuan@memblaze.com>

Remove unused mask in nvme_alloc_iod

Signed-off-by: Chong Yuan <chong.yuan at memblaze.com>
Reviewed-by: Wenbo Wang  <wenbo.wang at memblaze.com>
Acked-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e23be20..cbde95b 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -152,6 +152,7 @@ struct nvme_cmd_info {
  */
 #define NVME_INT_PAGES		2
 #define NVME_INT_BYTES(dev)	(NVME_INT_PAGES * (dev)->page_size)
+#define NVME_INT_MASK		0x01
 
 /*
  * Will slightly overestimate the number of pages needed.  This is OK
@@ -257,7 +258,7 @@ static void *iod_get_private(struct nvme_iod *iod)
  */
 static bool iod_should_kfree(struct nvme_iod *iod)
 {
-	return (iod->private & 0x01) == 0;
+	return (iod->private & NVME_INT_MASK) == 0;
 }
 
 /* Special values must be less than 0x1000 */
@@ -432,7 +433,6 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 {
 	unsigned size = !(rq->cmd_flags & REQ_DISCARD) ? blk_rq_bytes(rq) :
                                                 sizeof(struct nvme_dsm_range);
-	unsigned long mask = 0;
 	struct nvme_iod *iod;
 
 	if (rq->nr_phys_segments <= NVME_INT_PAGES &&
@@ -440,9 +440,8 @@ static struct nvme_iod *nvme_alloc_iod(struct request *rq, struct nvme_dev *dev,
 		struct nvme_cmd_info *cmd = blk_mq_rq_to_pdu(rq);
 
 		iod = cmd->iod;
-		mask = 0x01;
 		iod_init(iod, size, rq->nr_phys_segments,
-				(unsigned long) rq | 0x01);
+				(unsigned long) rq | NVME_INT_MASK);
 		return iod;
 	}
 
-- 
1.8.3.1
