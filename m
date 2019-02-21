From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 20 Feb 2019 20:13:35 -0800
Subject: [COMPILE TEST ONLY PATCH 2/2] nvme-fc: use nr_phys_segments when map
 rq to sgl
In-Reply-To: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>
References: <20190221041335.22806-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190221041335.22806-3-chaitanya.kulkarni@wdc.com>

Use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes() to check
if a command contains data to be mapped.  This fixes the case where
a struct request contains LBAs, but it has no payload, such as
Write Zeroes support.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/fc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 89accc76d71c..fdfaf5e914aa 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2119,7 +2119,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 
 	freq->sg_cnt = 0;
 
-	if (!blk_rq_payload_bytes(rq))
+	if (!blk_rq_nr_phys_segments(req))
 		return 0;
 
 	freq->sg_table.sgl = freq->first_sgl;
@@ -2316,7 +2316,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	data_len = blk_rq_payload_bytes(rq);
+	data_len = blk_rq_nr_phys_segments(rq);
 	if (data_len)
 		io_dir = ((rq_data_dir(rq) == WRITE) ?
 					NVMEFC_FCP_WRITE : NVMEFC_FCP_READ);
-- 
2.17.0
