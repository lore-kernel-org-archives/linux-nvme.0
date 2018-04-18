From: hch@lst.de (Christoph Hellwig)
Date: Wed, 18 Apr 2018 17:04:29 +0200
Subject: [PATCH] nvme: Fix disk names when not using nvme multipath
In-Reply-To: <20180418132657.GJ11513@localhost.localdomain>
References: <20180417220344.14698-1-keith.busch@intel.com>
 <20180418064412.GB11757@lst.de>
 <20180418132657.GJ11513@localhost.localdomain>
Message-ID: <20180418150429.GA7862@lst.de>

On Wed, Apr 18, 2018@07:26:58AM -0600, Keith Busch wrote:
> No-can-do. If we did that with nvme-multipath, we could find NMIC
> namespaces using the susbystem instance for the disk name, and non-NMIC
> using the controller instance: we'll have a different set of name
> conflicts to deal with.

True.  ? think I was also trying to solve the wrong problem to start
with, that's what happens if you get up a 4am :)

Another just as completely untested attempt below:

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 197a6ba9700f..ffca28dd2836 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -68,6 +68,11 @@ static bool streams;
 module_param(streams, bool, 0644);
 MODULE_PARM_DESC(streams, "turn on support for Streams write directives");
 
+bool multipath = true;
+module_param(multipath, bool, 0644);
+MODULE_PARM_DESC(multipath,
+	"turn on native support for multiple controllers per subsystem");
+
 /*
  * nvme_wq - hosts nvme related works that are not reset or delete
  * nvme_reset_wq - hosts nvme reset works
@@ -2989,6 +2994,13 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 		goto out_free_id;
 	nvme_setup_streams_ns(ctrl, ns);
 	
+	/*
+	 * Without the multipath code enabled, multiple controller per subsystem
+	 * are visible as devices and thus we cannot use the subsystem instance.
+	 */
+	if (!IS_ENABLED(CONFIG_NVME_MULTIPATH) || !multipath) {
+		sprintf(disk_name, "nvme%dn%d", ctrl->instance,
+				ns->head->instance);
 #ifdef CONFIG_NVME_MULTIPATH
 	/*
 	 * If multipathing is enabled we need to always use the subsystem
@@ -2997,22 +3009,15 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	 * the multipath-aware subsystem node and those that have a single
 	 * controller and use the controller node directly.
 	 */
-	if (ns->head->disk) {
+	} else if (ns->head->disk) {
 		sprintf(disk_name, "nvme%dc%dn%d", ctrl->subsys->instance,
 				ctrl->cntlid, ns->head->instance);
 		flags = GENHD_FL_HIDDEN;
 	} else {
 		sprintf(disk_name, "nvme%dn%d", ctrl->subsys->instance,
 				ns->head->instance);
-	}
-#else
-	/*
-	 * But without the multipath code enabled, multiple controller per
-	 * subsystems are visible as devices and thus we cannot use the
-	 * subsystem instance.
-	 */
-	sprintf(disk_name, "nvme%dn%d", ctrl->instance, ns->head->instance);
 #endif
+	}
 
 	if ((ctrl->quirks & NVME_QUIRK_LIGHTNVM) && id->vs[0] == 0x1) {
 		if (nvme_nvm_register(ns, disk_name, node)) {
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 956e0b8e9c4d..3b0643d6cfc4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -14,11 +14,6 @@
 #include <linux/moduleparam.h>
 #include "nvme.h"
 
-static bool multipath = true;
-module_param(multipath, bool, 0644);
-MODULE_PARM_DESC(multipath,
-	"turn on native support for multiple controllers per subsystem");
-
 void nvme_failover_req(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index cf93690b3ffc..b35b0f9f94c1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -32,6 +32,8 @@ extern unsigned int admin_timeout;
 #define NVME_DEFAULT_KATO	5
 #define NVME_KATO_GRACE		10
 
+extern bool multipath;
+
 extern struct workqueue_struct *nvme_wq;
 extern struct workqueue_struct *nvme_reset_wq;
 extern struct workqueue_struct *nvme_delete_wq;
