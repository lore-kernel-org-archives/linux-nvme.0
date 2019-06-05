From: hch@lst.de (Christoph Hellwig)
Date: Wed,  5 Jun 2019 21:08:34 +0200
Subject: [PATCH 11/13] mpt3sas: set virt_boundary_mask in the scsi host
In-Reply-To: <20190605190836.32354-1-hch@lst.de>
References: <20190605190836.32354-1-hch@lst.de>
Message-ID: <20190605190836.32354-12-hch@lst.de>

This ensures all proper DMA layer handling is taken care of by the
SCSI midlayer.  Note that the effect is global, as the IOMMU merging
is based off a paramters in struct device.  We could still turn if off
if no PCIe devices are present, but I don't know how to find that out.

Also remove the bogus nomerges flag, merges do take the virt_boundary
into account.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index 1ccfbc7eebe0..03a0df2a3379 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -2361,14 +2361,6 @@ scsih_slave_configure(struct scsi_device *sdev)
 		pcie_device_put(pcie_device);
 		spin_unlock_irqrestore(&ioc->pcie_device_lock, flags);
 		scsih_change_queue_depth(sdev, qdepth);
-		/* Enable QUEUE_FLAG_NOMERGES flag, so that IOs won't be
-		 ** merged and can eliminate holes created during merging
-		 ** operation.
-		 **/
-		blk_queue_flag_set(QUEUE_FLAG_NOMERGES,
-				sdev->request_queue);
-		blk_queue_virt_boundary(sdev->request_queue,
-				ioc->page_size - 1);
 		return 0;
 	}
 
@@ -10472,6 +10464,9 @@ _scsih_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	shost->transportt = mpt3sas_transport_template;
 	shost->unique_id = ioc->id;
 
+	/* XXX: only strictly needed if NVMe devices are attached */
+	shost->virt_boundary_mask = ioc->page_size - 1;
+
 	if (ioc->is_mcpu_endpoint) {
 		/* mCPU MPI support 64K max IO */
 		shost->max_sectors = 128;
-- 
2.20.1
