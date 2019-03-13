From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:55:00 +0100
Subject: [PATCH 07/17] nvme-fc: use nr_phys_segments to determine existence of
 sgl
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-8-hch@lst.de>

From: James Smart <jsmart2021@gmail.com>

For some nvme command, when issued by the nvme core layer, there
is an internal buffer which can cause blk_rq_payload_bytes() to
return a non-zero value yet there is no actual/real command payload
and sg list.  An example is the WRITE ZEROES command.

To address this, when making choices on whether to dma map an sgl,
use blk_rq_nr_phys_segments() instead of blk_rq_payload_bytes().
When there is a sgl, blk_rq_payload_bytes() will return the amount
of data to be transferred by the sgl.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/fc.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b29b12498a1a..ba8f2a9cbdaf 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2107,7 +2107,7 @@ nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 
 	freq->sg_cnt = 0;
 
-	if (!blk_rq_payload_bytes(rq))
+	if (!blk_rq_nr_phys_segments(rq))
 		return 0;
 
 	freq->sg_table.sgl = freq->first_sgl;
@@ -2304,12 +2304,23 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (ret)
 		return ret;
 
-	data_len = blk_rq_payload_bytes(rq);
-	if (data_len)
+	/*
+	 * nvme core doesn't quite treat the rq opaquely. Commands such
+	 * as WRITE ZEROES will return a non-zero rq payload_bytes yet
+	 * there is no actual payload to be transferred.
+	 * To get it right, key data transmission on there being 1 or
+	 * more physical segments in the sg list. If there is no
+	 * physical segments, there is no payload.
+	 */
+	if (blk_rq_nr_phys_segments(rq)) {
+		data_len = blk_rq_payload_bytes(rq);
 		io_dir = ((rq_data_dir(rq) == WRITE) ?
 					NVMEFC_FCP_WRITE : NVMEFC_FCP_READ);
-	else
+	} else {
+		data_len = 0;
 		io_dir = NVMEFC_FCP_NODATA;
+	}
+
 
 	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
 }
-- 
2.20.1
