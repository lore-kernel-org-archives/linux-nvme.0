From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:49 -0600
Subject: [PATCH 04/14] PCI/P2PDMA: Cache the result of
 upstream_bridge_distance()
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-5-logang@deltatee.com>

The result of upstream_bridge_distance() will be needed every time
we map the dma address so cache it in an xarray stored in the
provider's p2pdma struct.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d5034e28d1e1..25663c1d8bc9 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -19,10 +19,12 @@
 #include <linux/random.h>
 #include <linux/seq_buf.h>
 #include <linux/iommu.h>
+#include <linux/xarray.h>
 
 struct pci_p2pdma {
 	struct gen_pool *pool;
 	bool p2pmem_published;
+	struct xarray dist_cache;
 };
 
 static ssize_t size_show(struct device *dev, struct device_attribute *attr,
@@ -98,6 +100,8 @@ static int pci_p2pdma_setup(struct pci_dev *pdev)
 	if (!p2p)
 		return -ENOMEM;
 
+	xa_init(&p2p->dist_cache);
+
 	p2p->pool = gen_pool_create(PAGE_SHIFT, dev_to_node(&pdev->dev));
 	if (!p2p->pool)
 		goto out;
@@ -390,17 +394,34 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
+	void *entry;
 	int dist;
+	int idx;
+
+	idx = (pci_domain_nr(client->bus) << 16) |
+		(client->bus->number << 8) | client->devfn;
+
+	if (provider->p2pdma) {
+		entry = xa_load(&provider->p2pdma->dist_cache, idx);
+		if (entry)
+			return xa_to_value(entry);
+	}
 
 	dist = __upstream_bridge_distance(provider, client, acs_list);
 
 	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
-		return dist;
+		goto store_and_return;
+
+	if (!root_complex_whitelist(provider) ||
+	    !root_complex_whitelist(client))
+		dist |= P2PDMA_NOT_SUPPORTED;
 
-	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
-		return dist;
+store_and_return:
+	if (provider->p2pdma)
+		xa_store(&provider->p2pdma->dist_cache, idx,
+			 xa_mk_value(dist), GFP_KERNEL);
 
-	return dist | P2PDMA_NOT_SUPPORTED;
+	return dist;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1
