From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:34 -0600
Subject: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported result
 upstream_bridge_distance()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-4-logang@deltatee.com>

Add constant flags to indicate two devices are not supported or whether
the data path goes through the host bridge instead of using the negative
values -1 and -2.

This helps annotate the code better, but the main reason is so we
can use the information to store the required mapping method in an
xarray.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Reviewed-by: Christian K?nig <christian.koenig at amd.com>
---
 drivers/pci/p2pdma.c | 52 ++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 93fbda14f4a9..64f5a0e30244 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -289,6 +289,20 @@ static bool root_complex_whitelist(struct pci_dev *dev)
 	return false;
 }
 
+enum {
+	/*
+	 * These arbitrary offset are or'd onto the upstream distance
+	 * calculation for the following conditions:
+	 */
+
+	/* The data path includes the host-bridge */
+	P2PDMA_THRU_HOST_BRIDGE		= 0x02000000,
+	/* The data path is forced through the host-bridge due to ACS */
+	P2PDMA_ACS_FORCES_UPSTREAM	= 0x04000000,
+	/* The data path is not supported by P2PDMA */
+	P2PDMA_NOT_SUPPORTED		= 0x08000000,
+};
+
 /*
  * Find the distance through the nearest common upstream bridge between
  * two PCI devices.
@@ -313,22 +327,17 @@ static bool root_complex_whitelist(struct pci_dev *dev)
  * port of the switch, to the common upstream port, back up to the second
  * downstream port and then to Device B.
  *
- * Any two devices that don't have a common upstream bridge will return -1.
- * In this way devices on separate PCIe root ports will be rejected, which
- * is what we want for peer-to-peer seeing each PCIe root port defines a
- * separate hierarchy domain and there's no way to determine whether the root
- * complex supports forwarding between them.
+ * Any two devices that cannot communicate using p2pdma will return the distance
+ * with the flag P2PDMA_NOT_SUPPORTED.
  *
- * In the case where two devices are connected to different PCIe switches,
- * this function will still return a positive distance as long as both
- * switches eventually have a common upstream bridge. Note this covers
- * the case of using multiple PCIe switches to achieve a desired level of
- * fan-out from a root port. The exact distance will be a function of the
- * number of switches between Device A and Device B.
+ * Any two devices that have a data path that goes through the host bridge
+ * will consult a whitelist. If the host bridges are on the whitelist,
+ * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
+ * be set.
  *
  * If a bridge which has any ACS redirection bits set is in the path
- * then this functions will return -2. This is so we reject any
- * cases where the TLPs are forwarded up into the root complex.
+ * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
  * In this case, a list of all infringing bridge addresses will be
  * populated in acs_list (assuming it's non-null) for printk purposes.
  */
@@ -375,9 +384,9 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	 */
 	if (root_complex_whitelist(provider) &&
 	    root_complex_whitelist(client))
-		return 0x1000 + dist_a + dist_b;
+		return (dist_a + dist_b) | P2PDMA_THRU_HOST_BRIDGE;
 
-	return -1;
+	return (dist_a + dist_b) | P2PDMA_NOT_SUPPORTED;
 
 check_b_path_acs:
 	bb = b;
@@ -395,7 +404,7 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	}
 
 	if (acs_cnt)
-		return -2;
+		return P2PDMA_NOT_SUPPORTED | P2PDMA_ACS_FORCES_UPSTREAM;
 
 	return dist_a + dist_b;
 }
@@ -411,16 +420,17 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
 		return -ENOMEM;
 
 	ret = upstream_bridge_distance(provider, client, &acs_list);
-	if (ret == -2) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as ACS redirect is set between the client and provider (%s)\n",
+	if (ret & P2PDMA_ACS_FORCES_UPSTREAM) {
+		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
 			 pci_name(provider));
 		/* Drop final semicolon */
 		acs_list.buffer[acs_list.len-1] = 0;
 		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
 			 acs_list.buffer);
+	}
 
-	} else if (ret < 0) {
-		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge\n",
+	if (ret & P2PDMA_NOT_SUPPORTED) {
+		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
 			 pci_name(provider));
 	}
 
@@ -484,7 +494,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
 
 		pci_dev_put(pci_client);
 
-		if (ret < 0)
+		if (ret & P2PDMA_NOT_SUPPORTED)
 			not_supported = true;
 
 		if (not_supported && !verbose)
-- 
2.20.1
