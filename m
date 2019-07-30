From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:38 -0600
Subject: [PATCH v2 07/14] PCI/P2PDMA: Add whitelist support for Intel Host
 Bridges
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-8-logang@deltatee.com>

Intel devices do not have good support for P2P requests that span
different host bridges as the transactions will cross the QPI/UPI bus
and this does not perform well.

Therefore, enable support for these devices only if the host bridges
match.

Adds the Intel device's that have been tested to work. There are
likely many others out there that will need to be tested and added.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 38 ++++++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index ca36ea533ed7..1504f7ea006a 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -262,9 +262,30 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
 	seq_buf_printf(buf, "%s;", pci_name(pdev));
 }
 
-static bool __host_bridge_whitelist(struct pci_host_bridge *host)
+static const struct pci_p2pdma_whitelist_entry {
+	unsigned short vendor;
+	unsigned short device;
+	enum {
+		REQ_SAME_HOST_BRIDGE	= 1 << 0,
+	} flags;
+} pci_p2pdma_whitelist[] = {
+	/* AMD ZEN */
+	{PCI_VENDOR_ID_AMD,	0x1450,	0},
+
+	/* Intel Xeon E5/Core i7 */
+	{PCI_VENDOR_ID_INTEL,	0x3c00, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x3c01, REQ_SAME_HOST_BRIDGE},
+	/* Intel Xeon E7 v3/Xeon E5 v3/Core i7 */
+	{PCI_VENDOR_ID_INTEL,	0x2f00, REQ_SAME_HOST_BRIDGE},
+	{PCI_VENDOR_ID_INTEL,	0x2f01, REQ_SAME_HOST_BRIDGE},
+	{}
+};
+
+static bool __host_bridge_whitelist(struct pci_host_bridge *host,
+				    bool same_host_bridge)
 {
 	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
+	const struct pci_p2pdma_whitelist_entry *entry;
 	unsigned short vendor, device;
 
 	if (!root)
@@ -274,9 +295,14 @@ static bool __host_bridge_whitelist(struct pci_host_bridge *host)
 	device = root->device;
 	pci_dev_put(root);
 
-	/* AMD ZEN host bridges can do peer to peer */
-	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
+	for (entry = pci_p2pdma_whitelist; entry->vendor; entry++) {
+		if (vendor != entry->vendor || device != entry->device)
+			continue;
+		if (entry->flags & REQ_SAME_HOST_BRIDGE && !same_host_bridge)
+			return false;
+
 		return true;
+	}
 
 	return false;
 }
@@ -293,7 +319,11 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
 		return false;
 
-	if (__host_bridge_whitelist(host_a) && __host_bridge_whitelist(host_b))
+	if (host_a == host_b)
+		return __host_bridge_whitelist(host_a, true);
+
+	if (__host_bridge_whitelist(host_a, false) &&
+	    __host_bridge_whitelist(host_b, false))
 		return true;
 
 	return false;
-- 
2.20.1
