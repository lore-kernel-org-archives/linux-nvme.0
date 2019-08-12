From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:45 -0600
Subject: [PATCH v3 11/14] PCI/P2PDMA: Store mapping method in an xarray
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-12-logang@deltatee.com>

When upstream_bridge_distance() is called, store the method required to map
the DMA transfers in an xarray so it can be looked up efficiently on the
hot path in pci_p2pdma_map_sg().

Link: https://lore.kernel.org/r/20190730163545.4915-12-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
---
 drivers/pci/p2pdma.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 771b45605853..db8224ff6e80 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -19,6 +19,7 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
 
 enum pci_p2pdma_map_type {
 	PCI_P2PDMA_MAP_UNKNOWN = 0,
@@ -30,6 +31,7 @@ enum pci_p2pdma_map_type {
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	struct xarray map_types;
 };
 
 struct pci_p2pdma_pagemap {
@@ -105,6 +107,7 @@ static void pci_p2pdma_release(void *data)
 
 	gen_pool_destroy(p2pdma->pool);
 	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+	xa_destroy(&p2pdma->map_types);
 }
 
 static int pci_p2pdma_setup(struct pci_dev *pdev)
@@ -116,6 +119,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	xa_init(&p2p->map_types);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
@@ -409,6 +414,12 @@ __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 	return PCI_P2PDMA_MAP_BUS_ADDR;
 }
 
+static unsigned long map_types_idx(struct pci_dev *client)
+{
+	return (pci_domain_nr(client->bus) << 16) |
+		(client->bus->number << 8) | client->devfn;
+}
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -459,9 +470,13 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
 		if (!host_bridge_whitelist(provider, client))
-			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
+			 xa_mk_value(map_type), GFP_KERNEL);
+
 	return map_type;
 }
 
-- 
2.20.1
