From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:48 -0600
Subject: [PATCH v3 14/14] PCI/P2PDMA: Update pci_p2pdma_distance_many()
 documentation
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-15-logang@deltatee.com>

The comment describing pci_p2pdma_distance_many() still referred to
the devices being behind the same root port. This no longer applies
so reword the documentation.

Link: https://lore.kernel.org/r/20190730163545.4915-15-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
---
 drivers/pci/p2pdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index d8c824097d26..0608aae72ccc 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -517,15 +517,14 @@ upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
  * @num_clients: number of clients in the array
  * @verbose: if true, print warnings for devices when we return -1
  *
- * Returns -1 if any of the clients are not compatible (behind the same
- * root port as the provider), otherwise returns a positive number where
- * a lower number is the preferable choice. (If there's one client
- * that's the same as the provider it will return 0, which is best choice).
+ * Returns -1 if any of the clients are not compatible, otherwise returns a
+ * positive number where a lower number is the preferable choice. (If there's
+ * one client that's the same as the provider it will return 0, which is best
+ * choice).
  *
- * For now, "compatible" means the provider and the clients are all behind
- * the same PCI root port. This cuts out cases that may work but is safest
- * for the user. Future work can expand this to white-list root complexes that
- * can safely forward between each ports.
+ * "compatible" means the provider and the clients are either all behind
+ * the same PCI root port or the host bridges connected to each of the devices
+ * are listed in the 'pci_p2pdma_whitelist'.
  */
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose)
-- 
2.20.1
