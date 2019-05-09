From: hch@lst.de (Christoph Hellwig)
Date: Thu,  9 May 2019 13:04:09 +0200
Subject: [PATCH] nvme-pci: fix single segment detection
Message-ID: <20190509110409.19647-1-hch@lst.de>

blk_rq_nr_phys_segments isn't exactly accurate at the request/bio
level, so work around that fact with a few crude sanity checks.  To
be fixed for real in the block layer soon.

Fixes: 297910571f08 ("nvme-pci: optimize mapping single segment requests using SGLs")
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..9a4253be2723 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -824,7 +824,15 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int nr_mapped;
 
-	if (blk_rq_nr_phys_segments(req) == 1) {
+	/*
+	 * Crude hack to work around the block layer accounting for the fact
+	 * that the SG mapping can merge multiple physically contigous segments
+	 * in blk_rq_nr_phys_segments() despite the fact that not everyone is
+	 * mapping the request to a scatterlist.  To be fixed for real in the
+	 * block layer eventually..
+	 */
+	if (blk_rq_nr_phys_segments(req) == 1 &&
+	    !req->bio->bi_next && req->bio->bi_vcnt == 1) {
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-- 
2.20.1
