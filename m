From: keith.busch@intel.com (Keith Busch)
Date: Wed, 18 Apr 2018 10:09:42 -0600
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418153445.GA8513@lst.de>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
 <20180418132657.GJ11513@localhost.localdomain>
 <20180418150429.GA7862@lst.de>
 <20180418153410.GM11513@localhost.localdomain>
 <20180418153445.GA8513@lst.de>
Message-ID: <20180418160942.GN11513@localhost.localdomain>

On Wed, Apr 18, 2018@05:34:45PM +0200, Christoph Hellwig wrote:
> True.  We should do that anyway.  I'll turn this into a real series
> with a few more final touches tomorrow.

I started this before I saw your message:

---
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 127a9cbf3314..a3771c5729f5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2998,31 +2998,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (nvme_init_ns_head(ns, nsid, id))
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
-	
-#ifdef CONFIG_NVME_MULTIPATH
-	/*
-	 * If multipathing is enabled we need to always use the subsystem
-	 * instance number for numbering our devices to avoid conflicts
-	 * between subsystems that have multiple controllers and thus use
-	 * the multipath-aware subsystem node and those that have a single
-	 * controller and use the controller node directly.
-	 */
-	if (ns->head->disk) {
-		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
-				ctrl->cntlid, ns->head->instance);
-		flags = GENHD_FL_HIDDEN;
-	} else {
-		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
-				ns->head->instance);
-	}
-#else
-	/*
-	 * But without the multipath code enabled, multiple controller per
-	 * subsystems are visible as devices and thus we cannot use the
-	 * subsystem instance.
-	 */
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
-#endif
+	nvme_set_disk_name(disk_name, ns, ctrl, &flags);
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 956e0b8e9c4d..977539d0bb53 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -15,10 +15,32 @@
 #include "nvme.h"
 
 static bool multipath = true;
-module_param(multipath, bool, 0644);
+module_param(multipath, bool, 0444);
 MODULE_PARM_DESC(multipath,
 	"turn on native support for multiple controllers per subsystem");
 
+/*
+ * If multipathing is enabled we need to always use the subsystem instance
+ * number for numbering our devices to avoid conflicts between subsystems that
+ * have multiple controllers and thus use the multipath-aware subsystem node
+ * and those that have a single controller and use the controller node
+ * directly.
+ */
+void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+			struct nvme_ctrl *ctrl, int *flags)
+{
+	if (!multipath) {
+		nvme_simple_disk_name(disk_name, ns, ctrl);
+	} else if (ns->head->disk) {
+		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
+				ctrl->cntlid, ns->head->instance);
+		*flags = GENHD_FL_HIDDEN;
+	} else {
+		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
+				ns->head->instance);
+	}
+}
+
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 061fecfd44f5..2d4a139b00f1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -435,7 +435,19 @@ int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 extern const struct attribute_group nvme_ns_id_attr_group;
 extern const struct block_device_operations nvme_ns_head_ops;
 
+/*
+ * Without the multipath code enabled, multiple controller per subsystems are
+ * visible as devices and thus we cannot use the subsystem instance.
+ */
+static inline void nvme_simple_disk_name(char *disk_name, struct nvme_ns *ns,
+				         struct nvme_ctrl *ctrl)
+{
+	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
+void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+			struct nvme_ctrl *ctrl, int *flags);
 void nvme_failover_req(struct request *req);
 bool nvme_req_needs_failover(struct request *req, blk_status_t error);
 void nvme_kick_requeue_lists(struct nvme_ctrl *ctrl);
@@ -461,6 +473,12 @@ static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
 }
 
 #else
+static inline void nvme_set_disk_name(char *disk_name, struct nvme_ns *ns,
+				      struct nvme_ctrl *ctrl, int *flags)
+{
+	nvme_simple_disk_name(disk_name, ns, ctrl);
+}
+
 static inline void nvme_failover_req(struct request *req)
 {
 }
--
