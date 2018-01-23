From: thomas.tai@oracle.com (Thomas Tai)
Date: Mon, 22 Jan 2018 19:09:21 -0500
Subject: [PATCH] nvme: Add fault injection feature
Message-ID: <1516666161-3716-1-git-send-email-thomas.tai@oracle.com>

Linux's fault injection framework provides a systematic way to support
error injection via debugfs in the /sys/kernel/debug directory. This
patch uses the framework to add error injection to NVMe driver. The
fault injection source code is stored in a separate file and only linked
if CONFIG_FAULT_INJECTION_DEBUG_FS kernel config is selected.

Once the error injection is enabled, BLK_STS_IOERR will be
injected into the nvme_setup_cmd. Following example shows
how to inject an error.

First, enable CONFIG_FAULT_INJECTION_DEBUG_FS kernel config,
recompile the kernel. After booting up the kernel, do the
following.

mount -t debufs nodev /sys/kernel/debug
cd /sys/kernel/debug/nvme0n1/fault_inject
echo 1 > times
echo 100 > probability
cp /nvme_mount_point/some_files /tmp

Signed-off-by: Thomas Tai <thomas.tai at oracle.com>
Reviewed-by: Eric Saint-Etienne <eric.saint.etienne at oracle.com>
Signed-off-by: Karl Volz <karl.volz at oracle.com>
---
 Documentation/fault-injection/fault-injection.txt |  5 ++
 drivers/nvme/host/Makefile                        |  1 +
 drivers/nvme/host/core.c                          |  5 ++
 drivers/nvme/host/fault_inject.c                  | 57 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h                          | 23 +++++++++
 5 files changed, 91 insertions(+)
 create mode 100644 drivers/nvme/host/fault_inject.c

diff --git a/Documentation/fault-injection/fault-injection.txt b/Documentation/fault-injection/fault-injection.txt
index 918972b..42db9bd 100644
--- a/Documentation/fault-injection/fault-injection.txt
+++ b/Documentation/fault-injection/fault-injection.txt
@@ -30,6 +30,11 @@ o fail_mmc_request
   injects MMC data errors on devices permitted by setting
   debugfs entries under /sys/kernel/debug/mmc0/fail_mmc_request
 
+o NVMe fault injection
+
+  inject NVMe BLK_STS_IOERR on devices permitted by setting
+  debugfs entries under /sys/kernel/debug/nvme*/fault_inject
+
 Configure fault-injection capabilities behavior
 -----------------------------------------------
 
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index a25fd43..d38131e 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -8,6 +8,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 nvme-core-y				:= core.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
 nvme-core-$(CONFIG_NVM)			+= lightnvm.o
+nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 839650e..8669ec9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -562,6 +562,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 {
 	blk_status_t ret = BLK_STS_OK;
 
+	if (nvme_should_fail(ns))
+		return BLK_STS_IOERR;
+
 	if (!(req->rq_flags & RQF_DONTPREP)) {
 		nvme_req(req)->retries = 0;
 		nvme_req(req)->flags = 0;
@@ -2951,6 +2954,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (new)
 		nvme_mpath_add_disk(ns->head);
 	nvme_mpath_add_disk_links(ns);
+	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2969,6 +2973,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
new file mode 100644
index 0000000..fbead0e
--- /dev/null
+++ b/drivers/nvme/host/fault_inject.c
@@ -0,0 +1,57 @@
+/*
+ * fault injection support for nvme.
+ *
+ * Copyright (c) 2018, Oracle and/or its affiliates
+ *
+ */
+
+#include <linux/moduleparam.h>
+#include "nvme.h"
+
+static DECLARE_FAULT_ATTR(fail_default_attr);
+/* optional fault injection attributes boot time option:
+ * nvme_core.fail_request=<interval>,<probability>,<space>,<times>
+ */
+static char *fail_request;
+module_param(fail_request, charp, 0000);
+
+void nvme_fault_inject_init(struct nvme_ns *ns)
+{
+	struct dentry *dir, *parent;
+	char *name = ns->disk->disk_name;
+	struct fault_attr *attr = &ns->fault_inject.attr;
+
+	/* set default fault injection attribute */
+	if (fail_request)
+		setup_fault_attr(&fail_default_attr, fail_request);
+
+	/* create debugfs directory and attribute */
+	parent = debugfs_create_dir(name, NULL);
+	if (!parent) {
+		pr_warn("%s: failed to create debugfs directory\n", name);
+		return;
+	}
+
+	*attr = fail_default_attr;
+	dir = fault_create_debugfs_attr("fault_inject",	parent,	attr);
+	if (IS_ERR(dir)) {
+		pr_warn("%s: failed to create debugfs attr\n", name);
+		debugfs_remove_recursive(parent);
+		return;
+	}
+	ns->fault_inject.parent = parent;
+}
+
+void nvme_fault_inject_fini(struct nvme_ns *ns)
+{
+	/* remove debugfs directories */
+	debugfs_remove_recursive(ns->fault_inject.parent);
+}
+
+bool nvme_should_fail(struct nvme_ns *ns)
+{
+	if (ns && should_fail(&ns->fault_inject.attr, 1))
+		return true;
+
+	return false;
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a00eabd..6eca730 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -21,6 +21,7 @@
 #include <linux/blk-mq.h>
 #include <linux/lightnvm.h>
 #include <linux/sed-opal.h>
+#include <linux/fault-inject.h>
 
 extern unsigned int nvme_io_timeout;
 #define NVME_IO_TIMEOUT	(nvme_io_timeout * HZ)
@@ -257,6 +258,13 @@ struct nvme_ns_head {
 	int			instance;
 };
 
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+struct nvme_fault_inject {
+	struct fault_attr attr;
+	struct dentry *parent;
+};
+#endif
+
 struct nvme_ns {
 	struct list_head list;
 
@@ -278,6 +286,11 @@ struct nvme_ns {
 #define NVME_NS_REMOVING 0
 #define NVME_NS_DEAD     1
 	u16 noiob;
+
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct nvme_fault_inject fault_inject;
+#endif
+
 };
 
 struct nvme_ctrl_ops {
@@ -296,6 +309,16 @@ struct nvme_ctrl_ops {
 	int (*reinit_request)(void *data, struct request *rq);
 };
 
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+void nvme_fault_inject_init(struct nvme_ns *ns);
+void nvme_fault_inject_fini(struct nvme_ns *ns);
+bool nvme_should_fail(struct nvme_ns *ns);
+#else
+static inline void nvme_fault_inject_init(struct nvme_ns *ns) {}
+static inline void nvme_fault_inject_fini(struct nvme_ns *ns) {}
+static inline bool nvme_should_fail(struct nvme_ns *ns) { return false; }
+#endif
+
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 {
 	u32 val = 0;
-- 
1.8.3.1
