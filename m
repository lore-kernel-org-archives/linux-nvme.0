From: keith.busch@intel.com (Keith Busch)
Date: Thu, 22 Oct 2015 16:11:32 -0600
Subject: [PATCHv3] NVMe: Implement namespace list scanning
Message-ID: <1445551892-26941-1-git-send-email-keith.busch@intel.com>

The NVMe 1.1 specification provides an identify mode to return a
list of active namespaces. This is more efficient to discover which
namespace identifiers are active on a controller, providing potentially
significant improvement in scan time for controllers with sparsely
populated namespaces.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v2 -> v3:

  Merged up with Christoph's latest series.

  Factored out some common code in both scan methods.

  Fixed a little endian conversion.

 drivers/nvme/host/core.c |   79 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 70 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ebeb797..744647a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -250,6 +250,16 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	return error;
 }
 
+int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
+{
+	struct nvme_command c = { };
+
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.cns = cpu_to_le32(2);
+	c.identify.nsid = cpu_to_le32(nsid);
+	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+}
+
 int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 		struct nvme_id_ns **id)
 {
@@ -852,33 +862,84 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
+static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+{
+	struct nvme_ns *ns;
+
+	ns = nvme_find_ns(ctrl, nsid);
+	if (ns) {
+		if (revalidate_disk(ns->disk))
+			nvme_ns_remove(ns);
+	} else
+		nvme_alloc_ns(ctrl, nsid);
+}
+
+static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
+{
+	struct nvme_ns *ns;
+	__le32 *ns_list;
+	unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
+	int ret = 0;
+
+	ns_list = kzalloc(0x1000, GFP_KERNEL);
+	if (!ns_list)
+		return -ENOMEM;
+
+	for (i = 0; i < num_lists; i++) {
+		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
+		if (ret)
+			goto out;
+
+		for (j = 0; j < min(nn, 1024U); j++) {
+			nsid = le32_to_cpu(ns_list[j]);
+			if (!nsid)
+				goto out;
+
+			nvme_validate_ns(ctrl, nsid);
+
+			while (++prev < nsid) {
+				ns = nvme_find_ns(ctrl, prev);
+				if (ns)
+					nvme_ns_remove(ns);
+			}
+		}
+		nn -= j;
+	}
+ out:
+	kfree(ns_list);
+	return ret;
+}
+
 static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 {
 	struct nvme_ns *ns, *next;
 	unsigned i;
 
-	for (i = 1; i <= nn; i++) {
-		ns = nvme_find_ns(ctrl, i);
-		if (ns) {
-			if (revalidate_disk(ns->disk))
-				nvme_ns_remove(ns);
-		} else
-			nvme_alloc_ns(ctrl, i);
-	}
+	for (i = 1; i <= nn; i++)
+		nvme_validate_ns(ctrl, i);
+
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->ns_id > nn)
 			nvme_ns_remove(ns);
 	}
-	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 }
 
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
+	unsigned nn;
 
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
+
+	nn = le32_to_cpu(id->nn);
+	if (ctrl->vs >= NVME_VS(1, 1)) {
+		if (!nvme_scan_ns_list(ctrl, nn))
+			goto done;
+	}
 	__nvme_scan_namespaces(ctrl, le32_to_cpup(&id->nn));
+ done:
+	list_sort(NULL, &ctrl->namespaces, ns_cmp);
 	kfree(id);
 }
 
-- 
1.7.10.4
