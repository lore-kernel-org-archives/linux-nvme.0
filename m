From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:42 -0600
Subject: [PATCH v2 11/14] PCI/P2PDMA: Store mapping method in an xarray
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-12-logang@deltatee.com>

When upstream_bridge_distance() is called store the method required
to map the DMA transfers in an xarray so that it can be looked up
efficiently on the hot path in pci_p2pdma_map_sg().

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index fe647bd8f947..010aa8742bec 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -19,10 +19,19 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
+
+enum pci_p2pdma_map_type {
+	PCI_P2PDMA_MAP_UNKNOWN = 0,
+	PCI_P2PDMA_MAP_NOT_SUPPORTED,
+	PCI_P2PDMA_MAP_BUS_ADDR,
+	PCI_P2PDMA_MAP_THRU_IOMMU,
+};
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	struct xarray map_types;
 };
 
 struct pci_p2pdma_pagemap {
@@ -98,6 +107,7 @@ static void pci_p2pdma_release(void *data)
 
 	gen_pool_destroy(p2pdma->pool);
 	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
+	xa_destroy(&p2pdma->map_types);
 }
 
 static int pci_p2pdma_setup(struct pci_dev *pdev)
@@ -109,6 +119,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	xa_init(&p2p->map_types);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
@@ -404,6 +416,12 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 	return dist_a + dist_b;
 }
 
+static int map_types_idx(struct pci_dev *client)
+{
+	return (pci_domain_nr(client->bus) << 16) |
+		(client->bus->number << 8) | client->devfn;
+}
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -446,17 +464,29 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
+	enum pci_p2pdma_map_type map_type;
 	int dist;
 
 	dist = __upstream_bridge_distance(provider, client, acs_list);
 
-	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
-		return dist;
+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE)) {
+		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
+		goto store_map_type_and_return;
+	}
+
+	if (host_bridge_whitelist(provider, client)) {
+		map_type = PCI_P2PDMA_MAP_THRU_IOMMU;
+	} else {
+		dist |= P2PDMA_NOT_SUPPORTED;
+		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
 
-	if (host_bridge_whitelist(provider, client))
-		return dist;
+store_map_type_and_return:
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
+			 xa_mk_value(map_type), GFP_KERNEL);
 
-	return dist | P2PDMA_NOT_SUPPORTED;
+	return dist;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1
