From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:50 -0600
Subject: [PATCH 05/14] PCI/P2PDMA: Factor out host_bridge_whitelist()
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-6-logang@deltatee.com>

Push both PCI devices into the whitelist checking function seeing
some hardware will require us ensuring they are on the same host
bridge.

At the same time we rename root_complex_whitelist() to
host_bridge_whitelist() to match the terminology used in the code.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 31 ++++++++++++++++++++-----------
 1 file changed, 20 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 25663c1d8bc9..dfb802afc8ca 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -250,19 +250,11 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
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
 
@@ -277,6 +269,24 @@ static bool root_complex_whitelist(struct pci_dev *dev)
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
 	 * Thes arbitrary offset are or'd onto the upstream distance
@@ -412,8 +422,7 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
 		goto store_and_return;
 
-	if (!root_complex_whitelist(provider) ||
-	    !root_complex_whitelist(client))
+	if (!host_bridge_whitelist(provider, client))
 		dist |= P2PDMA_NOT_SUPPORTED;
 
 store_and_return:
-- 
2.20.1
