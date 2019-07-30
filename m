From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:36 -0600
Subject: [PATCH v2 05/14] PCI/P2PDMA: Apply host bridge white list for ACS
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-6-logang@deltatee.com>

When a P2PDMA transfer is rejected due to ACS being set, we
can also check the white list and allow the transactions.

Do this by pushing the whitelist check into the
upstream_bridge_distance() function.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Reviewed-by: Christian K?nig <christian.koenig at amd.com>
---
 drivers/pci/p2pdma.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index b4ef6e8da784..10765ab90e64 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -340,15 +340,7 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 		dist_a++;
 	}
 
-	/*
-	 * Allow the connection if both devices are on a whitelisted root
-	 * complex, but add an arbitrary large value to the distance.
-	 */
-	if (root_complex_whitelist(provider) &&
-	    root_complex_whitelist(client))
-		return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
-
-	return (dist_a + dist_b) | P2PDMA_NOT_SUPPORTED;
+	return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
 
 check_b_path_acs:
 	bb = b;
@@ -366,7 +358,8 @@ static int __upstream_bridge_distance(struct pci_dev *provider,
 	}
 
 	if (acs_cnt)
-		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
+		return (dist_a + dist_b) | P2PDMA_ACS_FORCES_UPSTREAM |
+			P2PDMA_THRU_HOST_BRIDGE;
 
 	return dist_a + dist_b;
 }
@@ -413,7 +406,17 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 				    struct pci_dev *client,
 				    struct seq_buf *acs_list)
 {
-	return __upstream_bridge_distance(provider, client, acs_list);
+	int dist;
+
+	dist = __upstream_bridge_distance(provider, client, acs_list);
+
+	if (!(dist & P2PDMA_THRU_HOST_BRIDGE))
+		return dist;
+
+	if (root_complex_whitelist(provider) && root_complex_whitelist(client))
+		return dist;
+
+	return dist | P2PDMA_NOT_SUPPORTED;
 }
 
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
-- 
2.20.1
