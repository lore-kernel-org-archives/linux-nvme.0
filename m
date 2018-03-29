From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 29 Mar 2018 10:07:20 -0600
Subject: [PATCH 3/4] nvmet-fc: Don't use the count returned by the dma_map_sg
 call
In-Reply-To: <20180329160721.4691-1-logang@deltatee.com>
References: <20180329160721.4691-1-logang@deltatee.com>
Message-ID: <20180329160721.4691-4-logang@deltatee.com>

When allocating an SGL, the fibre channel target uses the number
of entities mapped as the number of entities in a given scatter
gather list. This is incorrect.

The DMA-API-HOWTO document gives this note:

   The 'nents' argument to the dma_unmap_sg call must be
   the _same_ one you passed into the dma_map_sg call,
   it should _NOT_ be the 'count' value _returned_ from the
   dma_map_sg call.

The fc code only stores the count value returned form the dma_map_sg()
call and uses that value in the call to dma_unmap_sg().

The dma_map_sg() call will return a lower count than nents when multiple
SG entries were merged into one. This implies that there will be fewer
DMA address and length entries but the original number of page entries
in the SGL. So if this occurs, when the SGL reaches nvmet_execute_rw(),
a bio would be created with fewer than the total number of entries.

As odd as it sounds, and as far as I can tell, the number of SG entries
mapped does not appear to be used anywhere in the fc driver and therefore
there's no current need to store it.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Cc: James Smart <james.smart at broadcom.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Fixes: c53432030d8642 ("nvme-fabrics: Add target support for FC transport")
---
 drivers/nvme/target/fc.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 9b39a6cb1935..9f2f8ab83158 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1698,6 +1698,7 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 {
 	struct scatterlist *sg;
 	unsigned int nent;
+	int ret;
 
 	sg = sgl_alloc(fod->req.transfer_len, GFP_KERNEL, &nent);
 	if (!sg)
@@ -1705,10 +1706,12 @@ nvmet_fc_alloc_tgt_pgs(struct nvmet_fc_fcp_iod *fod)
 
 	fod->data_sg = sg;
 	fod->data_sg_cnt = nent;
-	fod->data_sg_cnt = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
-				((fod->io_dir == NVMET_FCP_WRITE) ?
-					DMA_FROM_DEVICE : DMA_TO_DEVICE));
-				/* note: write from initiator perspective */
+	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
+			    ((fod->io_dir == NVMET_FCP_WRITE) ?
+				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
+			    /* note: write from initiator perspective */
+	if (!ret)
+		goto out;
 
 	return 0;
 
-- 
2.11.0
