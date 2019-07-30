From: logang@deltatee.com (Logan Gunthorpe)
Date: Tue, 30 Jul 2019 10:35:35 -0600
Subject: [PATCH v2 04/14] PCI/P2PDMA: Factor out __upstream_bridge_distance()
In-Reply-To: <20190730163545.4915-1-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
Message-ID: <20190730163545.4915-5-logang@deltatee.com>

This is a prep patch to create a second level helper. There are no
functional changes.

The root complex whitelist code will be moved into this function in
a subsequent patch.

Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
Reviewed-by: Christian K?nig <christian.koenig at amd.com>
---
 drivers/pci/p2pdma.c | 89 ++++++++++++++++++++++++--------------------
 1 file changed, 48 insertions(+), 41 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 64f5a0e30244..b4ef6e8da784 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -303,47 +303,9 @@ enum {
 	P2PDMA_NOT_SUPPORTED		= 0x08000000,
 };
 
-/*
- * Find the distance through the nearest common upstream bridge between
- * two PCI devices.
- *
- * If the two devices are the same device then 0 will be returned.
- *
- * If there are two virtual functions of the same device behind the same
- * bridge port then 2 will be returned (one step down to the PCIe switch,
- * then one step back to the same device).
- *
- * In the case where two devices are connected to the same PCIe switch, the
- * value 4 will be returned. This corresponds to the following PCI tree:
- *
- *     -+  Root Port
- *      \+ Switch Upstream Port
- *       +-+ Switch Downstream Port
- *       + \- Device A
- *       \-+ Switch Downstream Port
- *         \- Device B
- *
- * The distance is 4 because we traverse from Device A through the downstream
- * port of the switch, to the common upstream port, back up to the second
- * downstream port and then to Device B.
- *
- * Any two devices that cannot communicate using p2pdma will return the distance
- * with the flag P2PDMA_NOT_SUPPORTED.
- *
- * Any two devices that have a data path that goes through the host bridge
- * will consult a whitelist. If the host bridges are on the whitelist,
- * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
- * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
- * be set.
- *
- * If a bridge which has any ACS redirection bits set is in the path
- * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
- * In this case, a list of all infringing bridge addresses will be
- * populated in acs_list (assuming it's non-null) for printk purposes.
- */
-static int upstream_bridge_distance(struct pci_dev *provider,
-				    struct pci_dev *client,
-				    struct seq_buf *acs_list)
+static int __upstream_bridge_distance(struct pci_dev *provider,
+				      struct pci_dev *client,
+				      struct seq_buf *acs_list)
 {
 	struct pci_dev *a = provider, *b = client, *bb;
 	int dist_a = 0;
@@ -409,6 +371,51 @@ static int upstream_bridge_distance(struct pci_dev *provider,
 	return dist_a + dist_b;
 }
 
+/*
+ * Find the distance through the nearest common upstream bridge between
+ * two PCI devices.
+ *
+ * If the two devices are the same device then 0 will be returned.
+ *
+ * If there are two virtual functions of the same device behind the same
+ * bridge port then 2 will be returned (one step down to the PCIe switch,
+ * then one step back to the same device).
+ *
+ * In the case where two devices are connected to the same PCIe switch, the
+ * value 4 will be returned. This corresponds to the following PCI tree:
+ *
+ *     -+  Root Port
+ *      \+ Switch Upstream Port
+ *       +-+ Switch Downstream Port
+ *       + \- Device A
+ *       \-+ Switch Downstream Port
+ *         \- Device B
+ *
+ * The distance is 4 because we traverse from Device A through the downstream
+ * port of the switch, to the common upstream port, back up to the second
+ * downstream port and then to Device B.
+ *
+ * Any two devices that cannot communicate using p2pdma will return the distance
+ * with the flag P2PDMA_NOT_SUPPORTED.
+ *
+ * Any two devices that have a data path that goes through the host bridge
+ * will consult a whitelist. If the host bridges are on the whitelist,
+ * then the distance will be returned with the flag P2PDMA_THRU_HOST_BRIDGE set.
+ * If either bridge is not on the whitelist, the flag P2PDMA_NOT_SUPPORTED will
+ * be set.
+ *
+ * If a bridge which has any ACS redirection bits set is in the path
+ * then this functions will flag the result with P2PDMA_ACS_FORCES_UPSTREAM.
+ * In this case, a list of all infringing bridge addresses will be
+ * populated in acs_list (assuming it's non-null) for printk purposes.
+ */
+static int upstream_bridge_distance(struct pci_dev *provider,
+				    struct pci_dev *client,
+				    struct seq_buf *acs_list)
+{
+	return __upstream_bridge_distance(provider, client, acs_list);
+}
+
 static int upstream_bridge_distance_warn(struct pci_dev *provider,
 					 struct pci_dev *client)
 {
-- 
2.20.1
