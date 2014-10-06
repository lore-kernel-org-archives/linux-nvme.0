From: keith.busch@intel.com (Keith Busch)
Date: Mon,  6 Oct 2014 15:23:06 -0600
Subject: [PATCH] NVMe: Do not over allocate for discard requests
Message-ID: <1412630586-24047-1-git-send-email-keith.busch@intel.com>

Discard requests are often for very large ranges. The discard size is not
representative of the data transfer size so we don't need to allocate
for such a large prp list. This patch requests allocating only enough
for the memory needed for the data transfer and saves a little over 8k
of memory per max discard request.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reported-by: Paul Grabinar <paul.grabinar at ranbarg.com>
---
 drivers/block/nvme-core.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a5ea19d..bf4e8a1 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -746,11 +746,13 @@ static int nvme_submit_bio_queue(struct nvme_queue *nvmeq, struct nvme_ns *ns,
 	struct nvme_iod *iod;
 	int psegs = bio_phys_segments(ns->queue, bio);
 	int result;
+	unsigned size = !(bio->bi_rw & REQ_DISCARD) ? bio->bi_iter.bi_size :
+						sizeof(struct nvme_dsm_range);
 
 	if ((bio->bi_rw & REQ_FLUSH) && psegs)
 		return nvme_split_flush_data(nvmeq, bio);
 
-	iod = nvme_alloc_iod(psegs, bio->bi_iter.bi_size, ns->dev, GFP_ATOMIC);
+	iod = nvme_alloc_iod(psegs, size, ns->dev, GFP_ATOMIC);
 	if (!iod)
 		return -ENOMEM;
 
-- 
1.7.10.4
