From: marek.vasut@gmail.com (marek.vasut@gmail.com)
Date: Thu,  7 Mar 2019 01:04:39 +0100
Subject: [PATCH 1/2] [RFC] ata: ahci: Respect bus DMA constraints
Message-ID: <20190307000440.8708-1-marek.vasut@gmail.com>

From: Marek Vasut <marek.vasut+renesas@gmail.com>

Since commit 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate"),
the upstream bus can constraint device DMA range. Respect that constraint
and do not change the device DMA masks if they were already set.

This is applicable e.g. on systems where the PCIe controller cannot expose
the full address space range. Such a system may have a 64bit CPU with DRAM
mapped both below and above the 32bit address space, yet the PCIe devices
can not perform DMA directly to/from the DRAM range above the 32bit limit.
Hence, for such setup to work, all the buffers must exist below the 32bit
limit.

Signed-off-by: Marek Vasut <marek.vasut+renesas at gmail.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Geert Uytterhoeven <geert+renesas at glider.be>
Cc: Jens Axboe <axboe at fb.com>
Cc: Jens Axboe <axboe at kernel.dk>
Cc: Keith Busch <keith.busch at intel.com>
Cc: Robin Murphy <robin.murphy at arm.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Wolfram Sang <wsa+renesas at sang-engineering.com>
Cc: linux-renesas-soc at vger.kernel.org
To: linux-ide at vger.kernel.org
To: linux-nvme at lists.infradead.org
---
 drivers/ata/ahci.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index 021ce46e2e57..2acce056dd8c 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -926,6 +926,13 @@ static int ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
 	if (pdev->dma_mask && pdev->dma_mask < DMA_BIT_MASK(32))
 		return 0;
 
+	/*
+	 * The upstream device could have applied DMA constraints already,
+	 * respect those and do not change the DMA masks.
+	 */
+	if (pdev->dev.dma_mask && pdev->dev.coherent_dma_mask)
+		return 0;
+
 	if (using_dac &&
 	    !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
 		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-- 
2.20.1
