From: keith.busch@intel.com (Keith Busch)
Date: Fri,  8 Mar 2019 10:43:13 -0700
Subject: [PATCH 8/8] nvme/pci: Remove unused nvme_iod member
In-Reply-To: <20190308174313.5134-1-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
Message-ID: <20190308174313.5134-8-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9108a2ceb2c5..2d50630e0ba9 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -218,7 +218,6 @@ struct nvme_iod {
 	int aborted;
 	int npages;		/* In the PRP list. 0 means small pool in use */
 	int nents;		/* Used in scatterlist */
-	int length;		/* Of data, in bytes */
 	dma_addr_t first_dma;
 	struct scatterlist meta_sg; /* metadata requires single contiguous buffer */
 	struct scatterlist *sg;
@@ -591,7 +590,6 @@ static blk_status_t nvme_init_iod(struct request *rq, struct nvme_dev *dev)
 	iod->aborted = 0;
 	iod->npages = -1;
 	iod->nents = 0;
-	iod->length = size;
 
 	return BLK_STS_OK;
 }
-- 
2.14.4
