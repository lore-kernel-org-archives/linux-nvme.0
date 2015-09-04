From: keith.busch@intel.com (Keith Busch)
Date: Fri,  4 Sep 2015 11:12:13 -0600
Subject: [PATCH] NVMe: Use namespace list for scanning device
Message-ID: <1441386733-5554-1-git-send-email-keith.busch@intel.com>

The NVMe 1.1 specification provides an identify mode to return a list
of active namespaces. This is more efficient to discover which namespace
identifiers are active on a controller.

Consider a controller with only one namespace. The NSID could
theoretically be the highest possible, 0xfffffffe. The specification
requires ID_CTRL.NN be set to this for the NSID to be valid, but the
driver would have to scan 4 billion inactive namespaces before finding
the only active one. Even the fastest hardware will take a very long
time to complete.

This patch short-cuts the process by only reading the list of active
namespaces for controllers that support the capability.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   78 ++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 70 insertions(+), 8 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 30758bd..0128e5a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1170,6 +1170,16 @@ static int adapter_delete_sq(struct nvme_dev *dev, u16 sqid)
 	return adapter_delete_queue(dev, nvme_admin_delete_sq, sqid);
 }
 
+int nvme_identify_ns_list(struct nvme_dev *dev, u32 *ns_list, unsigned nsid)
+{
+	struct nvme_command c = { };
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = cpu_to_le32(2);
+	c.identify.nsid = cpu_to_le32(nsid);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+}
+
 int nvme_identify_ctrl(struct nvme_dev *dev, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
@@ -2415,6 +2425,12 @@ static void nvme_ns_remove(struct nvme_ns *ns)
         }
 }
 
+static void nvme_remove_ns(struct nvme_ns *ns)
+{
+	nvme_ns_remove(ns);
+	nvme_free_namespace(ns);
+}
+
 static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
 {
 	struct nvme_ns *ns, *next;
@@ -2423,20 +2439,57 @@ static void nvme_scan_namespaces(struct nvme_dev *dev, unsigned nn)
 	for (i = 1; i <= nn; i++) {
 		ns = nvme_find_ns(dev, i);
 		if (ns) {
-			if (revalidate_disk(ns->disk)) {
-				nvme_ns_remove(ns);
-				nvme_free_namespace(ns);
-			}
+			if (revalidate_disk(ns->disk))
+				nvme_remove_ns(ns);
 		} else
 			nvme_alloc_ns(dev, i);
 	}
 	list_for_each_entry_safe(ns, next, &dev->namespaces, list) {
-		if (ns->ns_id > nn) {
-			nvme_ns_remove(ns);
-			nvme_free_namespace(ns);
+		if (ns->ns_id > nn)
+			nvme_remove_ns(ns);
+	}
+	list_sort(NULL, &dev->namespaces, ns_cmp);
+}
+
+static int nvme_scan_ns_list(struct nvme_dev *dev, int nn)
+{
+	int i, j, k, ret = 0;
+	struct nvme_ns *ns;
+	u32 *ns_list, nsid, prev = 0;
+	unsigned num_lists = DIV_ROUND_UP(nn, 1024);
+
+	ns_list = kmalloc(0x1000, GFP_KERNEL);
+	if (!*ns_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lists; i++) {
+		ret = nvme_identify_ns_list(dev, ns_list, prev);
+		if (ret)
+			goto out;
+
+		for (j = 0; j < min(nn, 1024); j++) {
+			nsid = le32_to_cpu(ns_list[j]);
+			if (!nsid)
+				goto out;
+			ns = nvme_find_ns(dev, nsid);
+			if (ns) {
+				if (revalidate_disk(ns->disk))
+					nvme_remove_ns(ns);
+			} else
+				nvme_alloc_ns(dev, nsid);
+			for (k = prev + 1; k < nsid; k++) {
+				ns = nvme_find_ns(dev, k);
+				if (ns)
+					nvme_remove_ns(ns);
+			}
+			prev = nsid;
 		}
+		nn -= j;
 	}
+ out:
 	list_sort(NULL, &dev->namespaces, ns_cmp);
+	kfree(ns_list);
+	return ret;
 }
 
 static void nvme_set_irq_hints(struct nvme_dev *dev)
@@ -2459,12 +2512,21 @@ static void nvme_dev_scan(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, scan_work);
 	struct nvme_id_ctrl *ctrl;
+	unsigned nn;
 
 	if (!dev->tagset.tags)
 		return;
+
 	if (nvme_identify_ctrl(dev, &ctrl))
 		return;
-	nvme_scan_namespaces(dev, le32_to_cpup(&ctrl->nn));
+
+	nn = le32_to_cpup(&ctrl->nn);
+	if (readl(&dev->bar->vs) >= NVME_VS(1, 1)) {
+		if (!nvme_scan_ns_list(dev, nn))
+			goto done;
+	}
+	nvme_scan_namespaces(dev, nn);
+ done:
 	kfree(ctrl);
 	nvme_set_irq_hints(dev);
 }
-- 
1.7.10.4
