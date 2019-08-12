From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 12 Aug 2019 11:30:39 -0600
Subject: [PATCH v3 05/14] PCI/P2PDMA: Apply host bridge whitelist for ACS
In-Reply-To: <20190812173048.9186-1-logang@deltatee.com>
References: <20190812173048.9186-1-logang@deltatee.com>
Message-ID: <20190812173048.9186-6-logang@deltatee.com>

When a P2PDMA transfer is rejected due to ACS being set, we can also check
the whitelist and allow the transactions.

Do this by pushing the whitelist check into the upstream_bridge_distance()
function.

Link: https://lore.kernel.org/r/20190730163545.4915-6-logang at deltatee.com
Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Signed-off-by: Bjorn Helgaas <bhelgaas at google.com>
Reviewed-by: Christian K?nig <christian.koenig at amd.com>
---
 drivers/pci/p2pdma.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 600ba6a7aa11..f7f7e5862bab 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -339,15 +339,7 @@ __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 	if (dist)
 		*dist = dist_a + dist_b;
 
-	/*
-	 * Allow the connection if both devices are on a whitelisted root
-	 * complex, but add an arbitrary large value to the distance.
-	 */
-	if (root_complex_whitelist(provider) &&
-	    root_complex_whitelist(client))
-		return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
-
-	return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 
 check_b_path_acs:
 	bb = b;
@@ -371,7 +363,7 @@ __upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 		if (acs_redirects)
 			*acs_redirects = true;
 
-		return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+		return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
 	}
 
 	return PCI_P2PDMA_MAP_BUS_ADDR;
@@ -420,8 +412,18 @@ static enum pci_p2pdma_map_type
 upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
 		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
 {
-	return __upstream_bridge_distance(provider, client, dist,
-					  acs_redirects, acs_list);
+	enum pci_p2pdma_map_type map_type;
+
+	map_type = __upstream_bridge_distance(provider, client, dist,
+					      acs_redirects, acs_list);
+
+	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
+		if (!root_complex_whitelist(provider) ||
+		    !root_complex_whitelist(client))
+			return PCI_P2PDMA_MAP_NOT_SUPPORTED;
+	}
+
+	return map_type;
 }
 
 static enum pci_p2pdma_map_type
-- 
2.20.1
