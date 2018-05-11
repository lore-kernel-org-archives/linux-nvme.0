From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 11 May 2018 02:38:15 -0400
Subject: [PATCH] nvmet-loop: use nr_phys_segments when map rq to sgl
Message-ID: <20180511063815.14911-1-chaitanya.kulkarni@wdc.com>

This patch replaces blk_rq_payload_bytes() with
blk_rq_nr_phys_segments(). For the payloadless requests like
write-zeroes it will trigger BUD_ON() at
sg_alloc_table_chained() since blk_rq_nr_phys_segments()
will evaluate to 0 due to nature of the request.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/loop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 27a8561c0cb9..4284cefe6d32 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -174,7 +174,7 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 			&queue->nvme_sq, &nvme_loop_ops))
 		return BLK_STS_OK;
 
-	if (blk_rq_payload_bytes(req)) {
+	if (blk_rq_nr_phys_segments(req)) {
 		iod->sg_table.sgl = iod->first_sgl;
 		if (sg_alloc_table_chained(&iod->sg_table,
 				blk_rq_nr_phys_segments(req),
-- 
2.14.1
