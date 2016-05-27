From: sunad.s@samsung.com (Sunad Bhandary S)
Date: Fri, 27 May 2016 15:59:43 +0530
Subject: [PATCHv2] NVMe: Fix removal in case of active namespace list scanning
 method
Message-ID: <1464344983-19521-1-git-send-email-sunad.s@samsung.com>

From: Sunad Bhandary <sunad.s@samsung.com>

In case of the active namespace list scanning method, a namespace that
is detached is not removed from the host if it was the last entry in
the list. Fix this by adding a scan to validate namespaces greater than
the value of prev.

This also handles the case of removing namespaces whose value exceed
the device's reported number of namespaces.

Signed-off-by: Sunad Bhandary S <sunad.s at samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
v1 -> v2:
 Removed unnecessary braces around if condition
 
 drivers/nvme/host/core.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2de248b..3da998f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1483,6 +1483,17 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		nvme_alloc_ns(ctrl, nsid);
 }
 
+static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
+					unsigned nsid)
+{
+	struct nvme_ns *ns, *next;
+
+	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+		if (ns->ns_id > nsid)
+			nvme_ns_remove(ns);
+	}
+}
+
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 {
 	struct nvme_ns *ns;
@@ -1497,7 +1508,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 	for (i = 0; i < num_lists; i++) {
 		ret = nvme_identify_ns_list(ctrl, prev, ns_list);
 		if (ret)
-			goto out;
+			goto free;
 
 		for (j = 0; j < min(nn, 1024U); j++) {
 			nsid = le32_to_cpu(ns_list[j]);
@@ -1515,13 +1526,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 		nn -= j;
 	}
  out:
+	nvme_remove_invalid_namespaces(ctrl, prev);
+ free:
 	kfree(ns_list);
 	return ret;
 }
 
 static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 {
-	struct nvme_ns *ns, *next;
 	unsigned i;
 
 	lockdep_assert_held(&ctrl->namespaces_mutex);
@@ -1529,10 +1541,7 @@ static void nvme_scan_ns_sequential(struct nvme_ctrl *ctrl, unsigned nn)
 	for (i = 1; i <= nn; i++)
 		nvme_validate_ns(ctrl, i);
 
-	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->ns_id > nn)
-			nvme_ns_remove(ns);
-	}
+	nvme_remove_invalid_namespaces(ctrl, nn);
 }
 
 static void nvme_scan_work(struct work_struct *work)
-- 
1.9.3
