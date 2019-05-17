From: ming.lei@redhat.com (Ming Lei)
Date: Sat, 18 May 2019 06:50:35 +0800
Subject: [PATCH] nvme-pci: fix single segment optimization
Message-ID: <20190517225035.25008-1-ming.lei@redhat.com>

Commit dff824b2aadb ("nvme-pci: optimize mapping of small single segment
requests") supposes that single request request only includes single
bvec.

However, this assumption is wrong, since the single segment may cross
multiple bios, then there may be multiple bvecs involved in the segment.

Fixes this issue by checking if it is single bio request, if yes, the
request includes only one bvec, given we don't merge bvecs to one
segment if they belong to same bio.

Cc: Sagi Grimberg <sagi at grimberg.me>
Fixes: dff824b2aadb ("nvme-pci: optimize mapping of small single segment requests")
Signed-off-by: Ming Lei <ming.lei at redhat.com>
---

Hi Christoph,

This patch is candidate on your patch of 'block: don't decrement
nr_phys_segments for physically contigous segments', and I suggest to
take this one because this patch is simpler, and more suitable to serve
as v5.2 fix. 

And your patchset can aim at 5.3 as cleanup after careful
test/evaluation on performance effect.

 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2a8708c9ac18..6a38a760a295 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -824,7 +824,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 	blk_status_t ret = BLK_STS_RESOURCE;
 	int nr_mapped;
 
-	if (blk_rq_nr_phys_segments(req) == 1) {
+	/* Avoid the optimization if the single segment crosses two bios */
+	if (blk_rq_nr_phys_segments(req) == 1 && req->bio == req->biotail) {
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-- 
2.20.1
