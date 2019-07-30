From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:37 -0600
Subject: [PATCH v2 06/14] PCI/P2PDMA: Factor out host_bridge_whitelist()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-7-logang@deltatee.com>

Push both PCI devices into the whitelist checking function seeing
some hardware will require us ensuring they are on the same host
bridge.

At the same time we rename root_complex_whitelist() to
host_bridge_whitelist() to match the terminology used in the code.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 10765ab90e64..ca36ea533ed7 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -262,19 +262,11 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
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
 
@@ -289,6 +281,24 @@ static bool root_complex_whitelist(struct pci_dev *dev)
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
 enum {
 	/*
 	 * These arbitrary offset are or'd onto the upstream distance
@@ -413,7 +423,7 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
 		return dist;
 
-	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
+	if (host_bridge_whitelist(provider, client))
 		return dist;
 
 	return dist | P2PDMA_NOT_SUPPORTED;
-- 
2.20.1
