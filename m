From: sunad.s@samsung.com (Sunad Bhandary S)
Date: Tue, 19 Apr 2016 12:01:48 +0000 (GMT)
Subject: Namespace non removal in case of active namespaces list scanning
Message-ID: <1206539106.713731461067307629.JavaMail.weblogic@ep2mlwas08c>

The following is a case where namespaces are not removed from host on receipt of namespace detach command.

In case of scanning of the active namespace list supported by 1.1 controllers and above,
In scan_ns_list, we break out when we a find nsid with 0. 
If that nsid was the particular one which was deleted, then we are wrongly skipping the removal of the namespace from the host. 

Also namespaces that exceed the device's reported number of namespaces (ex: after firmware reset) need to be removed from the host

The following diff is a fix by ensuring the deletion by introducing an extra validation scan to remove inactive name spaces following of the approach of the case without the active namespace list scanning.
I would send out a patch if the current approach is acceptable. 

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4eb5759..615b229 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1433,6 +1433,18 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
                nvme_alloc_ns(ctrl, nsid);
 }

+static void nvme_remove_invalid_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+{
+       struct nvme_ns *ns, *next;
+
+       lockdep_assert_held(&ctrl->namespaces_mutex);
+
+       list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
+               if (ns->ns_id > nsid)
+                       nvme_ns_remove(ns);
+       }
+}
+
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 {
        struct nvme_ns *ns;
@@ -1440,6 +1452,8 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
        unsigned i, j, nsid, prev = 0, num_lists = DIV_ROUND_UP(nn, 1024);
        int ret = 0;

+       lockdep_assert_held(&ctrl->namespaces_mutex);
+
        ns_list = kzalloc(0x1000, GFP_KERNEL);
        if (!ns_list)
                return -ENOMEM;
@@ -1447,7 +1461,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
        for (i = 0; i < num_lists; i++) {
                ret = nvme_identify_ns_list(ctrl, prev, ns_list);
                if (ret)
-                       goto out;
+                       goto free;

                for (j = 0; j < min(nn, 1024U); j++) {
                        nsid = le32_to_cpu(ns_list[j]);
@@ -1465,13 +1479,14 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
                nn -= j;
        }
  out:
+       nvme_remove_invalid_ns(ctrl, prev);
+ free:
        kfree(ns_list);
        return ret;
 }

 static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 {
-       struct nvme_ns *ns, *next;
        unsigned i;

        lockdep_assert_held(&ctrl->namespaces_mutex);
@@ -1479,10 +1494,8 @@ static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
        for (i = 1; i <= nn; i++)
                nvme_validate_ns(ctrl, i);

-       list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-               if (ns->ns_id > nn)
-                       nvme_ns_remove(ns);
-       }
+       nvme_remove_invalid_ns(ctrl, nn);
+
 }

 void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
