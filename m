From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:47 -0600
Subject: [PATCH v3 13/14] PCI/P2PDMA: Allow IOMMU for host bridge whitelist
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-14-logang@deltatee.com>

Now that we map the requests correctly we can remove the iommu_present()
restriction.

Link: https://lore.kernel.org/r/20190730163545.4915-14-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
---
 drivers/pci/p2pdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index bca1ffc7075e..d8c824097d26 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -18,7 +18,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
-#include <linux/iommu.h>
 #include <linux/xarray.h>
 
 enum pci_p2pdma_map_type {
@@ -328,9 +327,6 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
 	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
 
-	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
-		return false;
-
 	if (host_a == host_b)
 		return __host_bridge_whitelist(host_a, true);
 
-- 
2.20.1
