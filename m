From: thomas.tai@oracle.com (Thomas Tai)
Date: Wed, 24 Jan 2018 15:23:10 -0500
Subject: [PATCH v2 1/1] nvme: Add fault injection feature
In-Reply-To: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
References: <1516825390-3324-1-git-send-email-thomas.tai@oracle.com>
Message-ID: <1516825390-3324-2-git-send-email-thomas.tai@oracle.com>

Linux's fault injection framework provides a systematic way to support
error injection via debugfs in the /sys/kernel/debug directory. This
patch uses the framework to add error injection to NVMe driver. The
fault injection source code is stored in a separate file and only linked
if CONFIG_FAULT_INJECTION_DEBUG_FS kernel config is selected.

Once the error injection is enabled, NVME_SC_INVALID_OPCODE with no
retry will be injected into the nvme_end_request. Following example shows
how to inject an error.

First, enable CONFIG_FAULT_INJECTION_DEBUG_FS kernel config,
recompile the kernel. After booting up the kernel, do the
following.

Example:

mount /dev/nvme0n1 /mnt
echo 1 > /sys/kernel/debug/nvme0n1/fault_inject/times
echo 100 > /sys/kernel/debug/nvme0n1/fault_inject/probability
cp a.file /mnt

Expected Result:

cp: cannot stat ?/mnt/a.file?: Input/output error

Message from dmesg:

FAULT_INJECTION: forcing a failure.
name fault_inject, interval 1, probability 100, space 0, times 1
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.15.0-rc8+ #2
Hardware name: innotek GmbH VirtualBox/VirtualBox,
BIOS VirtualBox 12/01/2006
Call Trace:
  <IRQ>
  dump_stack+0x5c/0x7d
  should_fail+0x148/0x170
  nvme_should_fail+0x2f/0x50 [nvme_core]
  nvme_process_cq+0xe7/0x1d0 [nvme]
  nvme_irq+0x1e/0x40 [nvme]
  __handle_irq_event_percpu+0x3a/0x190
  handle_irq_event_percpu+0x30/0x70
  handle_irq_event+0x36/0x60
  handle_fasteoi_irq+0x78/0x120
  handle_irq+0xa7/0x130
  ? tick_irq_enter+0xa8/0xc0
  do_IRQ+0x43/0xc0
  common_interrupt+0xa2/0xa2
  </IRQ>
RIP: 0010:native_safe_halt+0x2/0x10
RSP: 0018:ffffffff82003e90 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
RAX: ffffffff817a10c0 RBX: ffffffff82012480 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 000000008e38ce64 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffffffff82012480
R13: ffffffff82012480 R14: 0000000000000000 R15: 0000000000000000
  ? __sched_text_end+0x4/0x4
  default_idle+0x18/0xf0
  do_idle+0x150/0x1d0
  cpu_startup_entry+0x6f/0x80
  start_kernel+0x4c4/0x4e4
  ? set_init_arg+0x55/0x55
  secondary_startup_64+0xa5/0xb0
  print_req_error: I/O error, dev nvme0n1, sector 9240
EXT4-fs error (device nvme0n1): ext4_find_entry:1436:
inode #2: comm cp: reading directory lblock 0

Signed-off-by: Thomas Tai <thomas.tai at oracle.com>
Reviewed-by: Eric Saint-Etienne <eric.saint.etienne at oracle.com>
Signed-off-by: Karl Volz <karl.volz at oracle.com>
---
 Documentation/fault-injection/fault-injection.txt |  5 ++
 drivers/nvme/host/Makefile                        |  1 +
 drivers/nvme/host/core.c                          |  2 +
 drivers/nvme/host/fault_inject.c                  | 67 +++++++++++++++++++++++
 drivers/nvme/host/nvme.h                          | 25 +++++++++
 5 files changed, 100 insertions(+)
 create mode 100644 drivers/nvme/host/fault_inject.c

diff --git a/Documentation/fault-injection/fault-injection.txt b/Documentation/fault-injection/fault-injection.txt
index 918972b..db547c2 100644
--- a/Documentation/fault-injection/fault-injection.txt
+++ b/Documentation/fault-injection/fault-injection.txt
@@ -30,6 +30,11 @@ o fail_mmc_request
   injects MMC data errors on devices permitted by setting
   debugfs entries under /sys/kernel/debug/mmc0/fail_mmc_request
 
+o NVMe fault injection
+
+  inject NVMe NVME_SC_INVALID_OPCODE with no retry on devices permitted
+  by setting debugfs entries under /sys/kernel/debug/nvme*/fault_inject
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
index 839650e..49fa6da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2951,6 +2951,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	if (new)
 		nvme_mpath_add_disk(ns->head);
 	nvme_mpath_add_disk_links(ns);
+	nvme_fault_inject_init(ns);
 	return;
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
@@ -2969,6 +2970,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
+	nvme_fault_inject_fini(ns);
 	if (ns->disk && ns->disk->flags & GENHD_FL_UP) {
 		nvme_mpath_remove_disk_links(ns);
 		sysfs_remove_group(&disk_to_dev(ns->disk)->kobj,
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
new file mode 100644
index 0000000..c62e794
--- /dev/null
+++ b/drivers/nvme/host/fault_inject.c
@@ -0,0 +1,67 @@
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
+void nvme_should_fail(struct request *req)
+{
+	struct gendisk *disk = req->rq_disk;
+	struct nvme_ns *ns = NULL;
+
+	/*
+	 * make sure this request is coming from a valid namespace
+	 */
+	if (!disk)
+		return;
+
+	ns = disk->private_data;
+	if (ns && should_fail(&ns->fault_inject.attr, 1))
+		/* inject the error status, do not retry */
+		nvme_req(req)->status =	NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+}
+EXPORT_SYMBOL_GPL(nvme_should_fail);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a00eabd..a3c47d8 100644
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
+void nvme_should_fail(struct request *req);
+#else
+static inline void nvme_fault_inject_init(struct nvme_ns *ns) {}
+static inline void nvme_fault_inject_fini(struct nvme_ns *ns) {}
+static inline void nvme_should_fail(struct request *req) {}
+#endif
+
 static inline bool nvme_ctrl_ready(struct nvme_ctrl *ctrl)
 {
 	u32 val = 0;
@@ -332,6 +355,8 @@ static inline void nvme_end_request(struct request *req, __le16 status,
 
 	rq->status = le16_to_cpu(status) >> 1;
 	rq->result = result;
+	/* inject error when permitted by fault injection framework */
+	nvme_should_fail(req);
 	blk_mq_complete_request(req);
 }
 
-- 
1.8.3.1
