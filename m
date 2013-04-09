From: keith.busch@intel.com (Keith Busch)
Date: Tue,  9 Apr 2013 17:13:20 -0600
Subject: [PATCH v2] NVMe: Device specific stripe size handling
Message-ID: <1365549200-14609-1-git-send-email-keith.busch@intel.com>

We have an nvme device that has a concept of a stripe size. IO requests
that do not transfer data crossing a stripe boundary has greater
performance compared to IO that does cross it. This patch sets the
stripe size for the device if the device and vendor ids match one with
this feature and splits IO requests that cross the stripe boundary.

Signed-off-by: Keith Busch <keith.busch at intel.com>

This is dependent on this patch:
http://merlin.infradead.org/pipermail/linux-nvme/2013-April/000203.html

As mentioned before, this performs better with this lost-wake fix
discussed here:
http://merlin.infradead.org/pipermail/linux-nvme/2013-February/000135.html
---
 drivers/block/nvme-core.c |   19 +++++++++++++++----
 include/linux/nvme.h      |    1 +
 2 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f109076..90420d7 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -519,7 +519,11 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 {
 	struct bio_vec *bvec, *bvprv = NULL;
 	struct scatterlist *sg = NULL;
-	int i, length = 0, nsegs = 0;
+	int i, length = 0, nsegs = 0, split_len = bio->bi_size;
+
+	if (nvmeq->dev->stripe_size)
+		split_len = nvmeq->dev->stripe_size -
+			((bio->bi_sector << 9) & (nvmeq->dev->stripe_size - 1));
 
 	sg_init_table(iod->sg, psegs);
 	bio_for_each_segment(bvec, bio, i) {
@@ -535,6 +539,10 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 							bvec->bv_offset);
 			nsegs++;
 		}
+
+		if (split_len - length < bvec->bv_len)
+			return nvme_split_and_submit(bio, nvmeq, i, split_len,
+							split_len - length);
 		length += bvec->bv_len;
 		bvprv = bvec;
 	}
@@ -543,6 +551,7 @@ static int nvme_map_bio(struct nvme_queue *nvmeq, struct nvme_iod *iod,
 	if (dma_map_sg(nvmeq->q_dmadev, iod->sg, iod->nents, dma_dir) == 0)
 		return -ENOMEM;
 
+	BUG_ON(length != bio->bi_size);
 	return length;
 }
 
@@ -1602,6 +1611,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	struct nvme_id_ns *id_ns;
 	void *mem;
 	dma_addr_t dma_addr;
+	int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
 
 	res = nvme_setup_io_queues(dev);
 	if (res)
@@ -1622,10 +1632,11 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
-	if (ctrl->mdts) {
-		int shift = NVME_CAP_MPSMIN(readq(&dev->bar->cap)) + 12;
+	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
-	}
+	if ((dev->pci_dev->vendor == PCI_VENDOR_ID_INTEL) &&
+	    		(dev->pci_dev->device == 0x0953) && ctrl->vs[3])
+		dev->stripe_size = 1 << (ctrl->vs[3] + shift);
 
 	id_ns = mem;
 	for (i = 1; i <= nn; i++) {
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index aa57503..4229d74 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -531,6 +531,7 @@ struct nvme_dev {
 	char model[40];
 	char firmware_rev[8];
 	u32 max_hw_sectors;
+	u32 stripe_size;
 	u16 oncs;
 };
 
-- 
1.7.0.4
