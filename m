From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:40 -0600
Subject: [PATCH v3 06/14] PCI/P2PDMA: Factor out host_bridge_whitelist()
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-7-logang@deltatee.com>

Push both PCI devices into the whitelist checking function seeing some
hardware will require us ensuring they are on the same host bridge.

At the same time we rename root_complex_whitelist() to
host_bridge_whitelist() to match the terminology used in the code.

Link: https://lore.kernel.org/r/20190730163545.4915-7-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
---
 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index f7f7e5862bab..4b9f0903b340 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -269,19 +269,11 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
-/*
- * If we can't find a common upstream bridge take a look at the root
- * complex and compare it to a whitelist of known good hardware.
- */
-static bool root_complex_whitelist(struct pci_dev *dev)
+static bool __host_bridge_whitelist(struct pci_host_bridge *host)
 {
-	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
 	unsigned short vendor, device;
 
-	if (iommu_present(dev->dev.bus))
-		return false;
-
 	if (!root)
 		return false;
 
@@ -296,6 +288,24 @@ static bool root_complex_whitelist(struct pci_dev *dev)
 	return false;
 }
 
+/*
+ * If we can't find a common upstream bridge take a look at the root
+ * complex and compare it to a whitelist of known good hardware.
+ */
+static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
+{
+	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
+	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
+
+	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
+		return false;
+
+	if (__host_bridge_whitelist(host_a) && __host_bridge_whitelist(host_b))
+		return true;
+
+	return false;
+}
+
 static enum pci_p2pdma_map_type
 __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
@@ -418,8 +428,7 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 					      acs_redirects, acs_list);
 
 	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
-		if (!root_complex_whitelist(provider) ||
-		    !root_complex_whitelist(client))
+		if (!host_bridge_whitelist(provider, client))
 			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
 	}
 
-- 
2.20.1
