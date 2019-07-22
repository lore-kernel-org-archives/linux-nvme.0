From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:52 -0600
Subject: [PATCH 07/14] PCI/P2PDMA: Add the provider's pci_dev to the dev_pgmap
 struct
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-8-logang@deltatee.com>

The provider will be needed to figure out how to properly map a device.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c     | 1 +
 include/linux/memremap.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 143e11d2a5c3..70c262b7c731 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -168,6 +168,7 @@ int pci_p2pdma_add_resource(struct pci_dev *pdev, int bar, size_t size,
 	pgmap->res.end = pgmap->res.start + size - 1;
 	pgmap->res.flags = pci_resource_flags(pdev, bar);
 	pgmap->type = MEMORY_DEVICE_PCI_P2PDMA;
+	pgmap->pci_p2pdma_provider = pdev;
 	pgmap->pci_p2pdma_bus_offset = pci_bus_address(pdev, bar) -
 		pci_resource_start(pdev, bar);
 
diff --git a/include/linux/memremap.h b/include/linux/memremap.h
index f8a5b2a19945..91aee61796bc 100644
--- a/include/linux/memremap.h
+++ b/include/linux/memremap.h
@@ -112,6 +112,7 @@ struct dev_pagemap {
 	struct device *dev;
 	enum memory_type type;
 	unsigned int flags;
+	struct pci_dev *pci_p2pdma_provider;
 	u64 pci_p2pdma_bus_offset;
 	const struct dev_pagemap_ops *ops;
 };
-- 
2.20.1
