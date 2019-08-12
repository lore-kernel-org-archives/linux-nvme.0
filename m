From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:36 -0600
Subject: [PATCH v3 02/14] PCI/P2PDMA: Add provider's pci_dev to
 pci_p2pdma_pagemap struct
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-3-logang@deltatee.com>

The provider will be needed to figure out how to map a device.

Link: https://lore.kernel.org/r/20190730163545.4915-3-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
---
 drivers/pci/p2pdma.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 03e9c887bdfb..93fbda14f4a9 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -27,6 +27,7 @@ struct pci_p2pdma {
 
 struct pci_p2pdma_pagemap {
 	struct dev_pagemap pgmap;
+	struct pci_dev *provider;
 	u64 bus_offset;
 };
 
@@ -178,6 +179,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
 
+	p2p_pgmap->provider = pdev;
 	p2p_pgmap->bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
 
-- 
2.20.1
