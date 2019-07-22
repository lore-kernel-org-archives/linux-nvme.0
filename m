From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:57 -0600
Subject: [PATCH 12/14] PCI/P2PDMA: No longer require no-mmu for host bridge
 whitelist
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-13-logang@deltatee.com>

Now that we map the requests correctly we can remove the iommu_present()
restriction.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 76f51678342c..053f9ad59d79 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -18,7 +18,6 @@
 #include <linux/percpu-refcount.h>
 #include <linux/random.h>
 #include <linux/seq_buf.h>
-#include <linux/iommu.h>
 #include <linux/xarray.h>
 
 struct pci_p2pdma {
@@ -303,9 +302,6 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b)
 	struct pci_host_bridge *host_a = pci_find_host_bridge(a->bus);
 	struct pci_host_bridge *host_b = pci_find_host_bridge(b->bus);
 
-	if (iommu_present(a->dev.bus) || iommu_present(b->dev.bus))
-		return false;
-
 	if (host_a == host_b)
 		return __host_bridge_whitelist(host_a, true);
 
-- 
2.20.1
