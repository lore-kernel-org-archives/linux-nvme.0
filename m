From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 22 Jul 2019 17:08:58 -0600
Subject: [PATCH 13/14] PCI/P2PDMA: Update documentation for
 pci_p2pdma_distance_many()
In-Reply-To: <20190722230859.5436-1-logang@deltatee.com>
References: <20190722230859.5436-1-logang@deltatee.com>
Message-ID: <20190722230859.5436-14-logang@deltatee.com>

The comment describing pci_p2pdma_distance_many() still referred to
the devices being behind the same root port. This no longer applies
so reword the documentation.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
---
 drivers/pci/p2pdma.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 053f9ad59d79..baf476039396 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -496,15 +496,14 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
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
+ * the same PCI root port or the host bridge connected to each of the devices
+ * are is listed in the 'pci_p2pdma_whitelist'.
  */
 int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 			     int num_clients, bool verbose)
-- 
2.20.1
