From: marek.vasut@gmail.com (marek.vasut@gmail.com)
Date: Thu,  7 Mar 2019 01:04:40 +0100
Subject: [PATCH 2/2] [RFC] nvme-pci: Respect bus DMA constraints
In-Reply-To: <20190307000440.8708-1-marek.vasut@gmail.com>
References: <20190307000440.8708-1-marek.vasut@gmail.com>
Message-ID: <20190307000440.8708-2-marek.vasut@gmail.com>

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
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 92bad1c810ac..8ec873fb86b1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2323,7 +2323,8 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	if (!dev->dev->coherent_dma_mask &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
 		goto disable;
 
-- 
2.20.1
