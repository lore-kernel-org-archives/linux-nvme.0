From: zouming.zouming@huawei.com (Zou Ming)
Date: Tue, 6 Jun 2017 10:20:28 +0000
Subject: [PATCH v1] nvme: Using uevents to notify userspace on AERs.
Message-ID: <1496744428-3240-1-git-send-email-zouming.zouming@huawei.com>

From: Zou <zouming.zouming@huawei.com>

Uevents is a common mechanism for notifying the user state of the kernel. The
current patch implements the notification of asynchronous event information to
the user via the uevents interface when asynchronous events are received in
the kernel.

An example of the uevents generated as captured by udevadm monitor is shown below.
UDEV  [187882.295881] change   /devices/virtual/nvme-fabrics/ctl/nvme0 (nvme)
ACTION=change
DEVNAME=/dev/nvme0
DEVPATH=/devices/virtual/nvme-fabrics/ctl/nvme0
MAJOR=242
MINOR=0
NVME_AEN_INFO=0
NVME_AEN_LOGPAGE=0
NVME_AEN_SEQNUM=1
NVME_AEN_TYPE=AEN_ERROR_STATUS
SEQNUM=3547
SUBSYSTEM=nvme
USEC_INITIALIZED=7882294991

Signed-off-by: Zou Ming <zouming.zouming at huawei.com>
---
 drivers/nvme/host/Kconfig       |   6 ++
 drivers/nvme/host/Makefile      |   3 +-
 drivers/nvme/host/core.c        |  54 ++++++++++-
 drivers/nvme/host/nvme-uevent.c | 202 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme-uevent.h |  58 ++++++++++++
 drivers/nvme/host/nvme.h        |  10 ++
 6 files changed, 330 insertions(+), 3 deletions(-)
 create mode 100644 drivers/nvme/host/nvme-uevent.c
 create mode 100644 drivers/nvme/host/nvme-uevent.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 90745a6..a772db7 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -25,6 +25,12 @@ config BLK_DEV_NVME_SCSI
 	  emulation to provide stable device names for mount by id, like
 	  some OpenSuSE and SLES versions.
 
+config NVME_UEVENT
+	bool "nvme uevents"
+	depends on NVME_CORE
+	---help---
+	Generate udev events for nvme asynchronous events.
+
 config NVME_FABRICS
 	tristate
 
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index f1a7d94..bfab9dc 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -6,7 +6,8 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 
 nvme-core-y				:= core.o
 nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
-nvme-core-$(CONFIG_NVM)			+= lightnvm.o
+nvme-core-$(CONFIG_NVM)					+= lightnvm.o
+nvme-core-$(CONFIG_NVME_UEVENT)			+= nvme-uevent.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a609264..e5b1827 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -32,6 +32,7 @@
 
 #include "nvme.h"
 #include "fabrics.h"
+#include "nvme-uevent.h"
 
 #define NVME_MINORS		(1U << MINORBITS)
 
@@ -70,6 +71,36 @@
 
 static struct class *nvme_class;
 
+uint32_t nvme_next_uevent_seq(struct nvme_ctrl *ctrl)
+{
+	return atomic_add_return(1, &ctrl->uevent_seq);
+}
+
+void nvme_uevent_add(struct nvme_ctrl *ctrl, struct list_head *elist)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&ctrl->uevent_lock, flags);
+	list_add(elist, &ctrl->uevent_list);
+	spin_unlock_irqrestore(&ctrl->uevent_lock, flags);
+}
+
+static DEFINE_MUTEX(_nvme_event_lock);
+static void trigger_event(struct work_struct *work)
+{
+	unsigned long flags;
+	LIST_HEAD(uevents);
+	struct nvme_ctrl *ctrl = container_of(work, struct nvme_ctrl, trigger_event_work);
+
+	mutex_lock(&_nvme_event_lock);
+	spin_lock_irqsave(&ctrl->uevent_lock, flags);
+	list_splice_init(&ctrl->uevent_list, &uevents);
+	spin_unlock_irqrestore(&ctrl->uevent_lock, flags);
+
+	nvme_send_uevents(&uevents, &ctrl->device->kobj);
+	mutex_unlock(&_nvme_event_lock);
+}
+
 static int nvme_error_status(struct request *req)
 {
 	switch (nvme_req(req)->status & 0x7ff) {
@@ -2292,13 +2323,19 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (done)
 		return;
 
-	switch (result & 0xff07) {
+	switch (result & 0xffff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(ctrl->device, "rescanning\n");
 		nvme_queue_scan(ctrl);
 		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
+		nvme_aen_uevent(ctrl,
+				(result & 0x07),
+				(result & 0xff00) >> 8,
+				(result & 0xff0000) >> 16);
+
+		schedule_work(&ctrl->trigger_event_work);
 	}
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
@@ -2343,6 +2380,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
 	flush_work(&ctrl->async_event_work);
 	flush_work(&ctrl->scan_work);
+	flush_work(&ctrl->trigger_event_work);
 	nvme_remove_namespaces(ctrl);
 
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
@@ -2390,6 +2428,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	ctrl->quirks = quirks;
 	INIT_WORK(&ctrl->scan_work, nvme_scan_work);
 	INIT_WORK(&ctrl->async_event_work, nvme_async_event_work);
+	atomic_set(&ctrl->uevent_seq, 0);
+	INIT_LIST_HEAD(&ctrl->uevent_list);
+	spin_lock_init(&ctrl->uevent_lock);
+	INIT_WORK(&ctrl->trigger_event_work, trigger_event);
 
 	ret = nvme_set_instance(ctrl);
 	if (ret)
@@ -2544,14 +2586,21 @@ int __init nvme_core_init(void)
 	else if (result > 0)
 		nvme_char_major = result;
 
+	result = nvme_uevent_init();
+	if (result)
+		goto unregister_chrdev;
+
 	nvme_class = class_create(THIS_MODULE, "nvme");
 	if (IS_ERR(nvme_class)) {
 		result = PTR_ERR(nvme_class);
-		goto unregister_chrdev;
+		goto out_uevent_exit;
 	}
 
 	return 0;
 
+ out_uevent_exit:
+	nvme_uevent_exit();
+
  unregister_chrdev:
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 	return result;
@@ -2560,6 +2609,7 @@ int __init nvme_core_init(void)
 void nvme_core_exit(void)
 {
 	class_destroy(nvme_class);
+	nvme_uevent_exit();
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 }
 
diff --git a/drivers/nvme/host/nvme-uevent.c b/drivers/nvme/host/nvme-uevent.c
new file mode 100644
index 0000000..bfb919c
--- /dev/null
+++ b/drivers/nvme/host/nvme-uevent.c
@@ -0,0 +1,202 @@
+/*
+ * Nvme Uevent Support for Asynchronous Event Notice (nvme-uevent)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * (C) Copyright HUAWEI Technology Corp. 2017   All Rights Reserved.
+ *	Author: Zou Ming <zouming.zouming at huawei.com>
+ */
+#include <linux/list.h>
+#include <linux/slab.h>
+#include <linux/kobject.h>
+#include <linux/export.h>
+
+#include "nvme.h"
+#include "nvme-uevent.h"
+
+static const struct {
+	enum nvme_uevent_aen_type type;
+	enum kobject_action action;
+	char *name;
+} _nvme_uevent_type_names[] = {
+	{NVME_AEN_ERROR_STATUS, KOBJ_CHANGE, "AEN_ERROR_STATUS"},
+	{NVME_AEN_SMART_STATUS, KOBJ_CHANGE, "AEN_SMART_STATUS"},
+	{NVME_AEN_NOTICE, KOBJ_CHANGE, "AEN_NOTICE"},
+	{NVME_AEN_IO_SPECIFIC_STATUS, KOBJ_CHANGE, "AEN_IO_SPECIFIC_STATUS"},
+	{NVME_AEN_VENDOR_SPECIFIC, KOBJ_CHANGE, "AEN_VENDOR_SPECIFIC"},
+};
+
+static struct kmem_cache *_nvme_event_cache;
+
+struct nvme_uevent {
+	enum kobject_action action;
+	struct kobj_uevent_env ku_env;
+	struct list_head elist;
+	struct nvme_ctrl *ctrl;
+};
+
+static void nvme_uevent_free(struct nvme_uevent *event)
+{
+	kmem_cache_free(_nvme_event_cache, event);
+}
+
+static struct nvme_uevent *nvme_uevent_alloc(struct nvme_ctrl *ctrl)
+{
+	struct nvme_uevent *event;
+
+	event = kmem_cache_zalloc(_nvme_event_cache, GFP_ATOMIC);
+	if (!event)
+		return NULL;
+
+	INIT_LIST_HEAD(&event->elist);
+	event->ctrl = ctrl;
+
+	return event;
+}
+
+static bool is_valid_aen_type(enum nvme_uevent_aen_type type, int *output_index)
+{
+	int i = 0;
+
+	for (i = 0; i < ARRAY_SIZE(_nvme_uevent_type_names); i++) {
+		if (_nvme_uevent_type_names[i].type == type) {
+			*output_index = i;
+			return true;
+		}
+	}
+
+	return false;
+}
+
+static struct nvme_uevent *nvme_build_aen_uevent(struct nvme_ctrl *ctrl,
+					      enum kobject_action action,
+					      const char *nvme_action,
+						  u8 event_info,
+						  u8 log_page)
+{
+	struct nvme_uevent *event;
+
+	event = nvme_uevent_alloc(ctrl);
+	if (!event) {
+		dev_warn(ctrl->device, "nvme_uevent_alloc() failed\n");
+		goto err_nomem;
+	}
+
+	event->action = action;
+
+	if (add_uevent_var(&event->ku_env, "NVME_AEN_SEQNUM=%u",
+			   nvme_next_uevent_seq(ctrl))) {
+		dev_warn(ctrl->device, "add_uevent_var() for NVME_AEN_SEQNUM failed\n");
+		goto err_add;
+	}
+
+	if (add_uevent_var(&event->ku_env, "NVME_AEN_TYPE=%s", nvme_action)) {
+		dev_warn(ctrl->device, "add_uevent_var() for NVME_AEN_TYPE failed\n");
+		goto err_add;
+	}
+
+	if (add_uevent_var(&event->ku_env, "NVME_AEN_INFO=%u", event_info)) {
+		dev_warn(ctrl->device, "add_uevent_var() for NVME_AEN_INFO failed\n");
+		goto err_add;
+	}
+
+	if (add_uevent_var(&event->ku_env, "NVME_AEN_LOGPAGE=%u", log_page)) {
+		dev_warn(ctrl->device, "add_uevent_var() for NVME_AEN_LOGPAGE failed\n");
+		goto err_add;
+	}
+
+	return event;
+
+err_add:
+	nvme_uevent_free(event);
+err_nomem:
+	return ERR_PTR(-ENOMEM);
+}
+
+/**
+ * nvme_send_uevents - send uevents for given list
+ *
+ * @events:	list of events to send
+ * @kobj:	kobject generating event
+ *
+ */
+void nvme_send_uevents(struct list_head *events, struct kobject *kobj)
+{
+	int r;
+	struct nvme_uevent *event, *next;
+
+	list_for_each_entry_safe(event, next, events, elist) {
+		list_del_init(&event->elist);
+
+		/*When the ctrl is not alive and we discard these unsent events.*/
+		if (event->ctrl->state != NVME_CTRL_LIVE) {
+			dev_info(event->ctrl->device, "skipping sending uevent for lost device\n");
+			goto uevent_free;
+		}
+
+		r = kobject_uevent_env(kobj, event->action, event->ku_env.envp);
+		if (r)
+			dev_warn(event->ctrl->device, "kobject_uevent_env failed\n");
+uevent_free:
+		nvme_put_ctrl(event->ctrl);
+		nvme_uevent_free(event);
+	}
+}
+
+/**
+ * nvme_aen_uevent - called to create a new  asynchronous event and queue it
+ *
+ * @ctrl:			pointer to a nvme_ctrl
+ * @event_type:	    path event type enum
+ * @aen_info:		more info for event_type
+ * @log_page:		log page info for event_type
+ *
+ */
+void nvme_aen_uevent(struct nvme_ctrl *ctrl,
+				enum nvme_uevent_aen_type event_type,
+				u8 event_info,
+				u8 log_page)
+{
+	struct nvme_uevent *event;
+	int valid_index;
+
+	if (is_valid_aen_type(event_type, &valid_index) == false) {
+		dev_warn(ctrl->device, "Invalid event_type %d\n", event_type);
+		return;
+	}
+
+	if (!kref_get_unless_zero(&ctrl->kref))
+		return;
+
+	event = nvme_build_aen_uevent(ctrl,
+				_nvme_uevent_type_names[valid_index].action,
+				_nvme_uevent_type_names[valid_index].name,
+				event_info,
+				log_page);
+	if (IS_ERR(event))
+		return;
+
+	nvme_uevent_add(ctrl, &event->elist);
+}
+
+int nvme_uevent_init(void)
+{
+	_nvme_event_cache = KMEM_CACHE(nvme_uevent, 0);
+	if (!_nvme_event_cache)
+		return -ENOMEM;
+
+	return 0;
+}
+
+void nvme_uevent_exit(void)
+{
+	kmem_cache_destroy(_nvme_event_cache);
+}
\ No newline at end of file
diff --git a/drivers/nvme/host/nvme-uevent.h b/drivers/nvme/host/nvme-uevent.h
new file mode 100644
index 0000000..7a4c5c7
--- /dev/null
+++ b/drivers/nvme/host/nvme-uevent.h
@@ -0,0 +1,58 @@
+/*
+ * Nvme Uevent Support for Asynchronous Event Notice (nvme-uevent)
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
+ * option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * (C) Copyright HUAWEI Technology Corp. 2017   All Rights Reserved.
+ *	Author: Zou Ming <zouming.zouming at huawei.com>
+ */
+#ifndef NVME_UEVENT_H
+#define NVME_UEVENT_H
+
+enum nvme_uevent_aen_type {
+	NVME_AEN_ERROR_STATUS = 0,
+	NVME_AEN_SMART_STATUS = 1,
+	NVME_AEN_NOTICE = 2,
+	NVME_AEN_IO_SPECIFIC_STATUS = 6,
+	NVME_AEN_VENDOR_SPECIFIC = 7,
+};
+
+#ifdef CONFIG_NVME_UEVENT
+
+extern int nvme_uevent_init(void);
+extern void nvme_uevent_exit(void);
+extern void nvme_send_uevents(struct list_head *events, struct kobject *kobj);
+extern void nvme_aen_uevent(struct nvme_ctrl *ctrl,
+			enum nvme_uevent_aen_type event_type,
+			u8 event_info, u8 log_page);
+
+#else
+
+static inline int nvme_uevent_init(void)
+{
+	return 0;
+}
+static inline void nvme_uevent_exit(void)
+{
+}
+static inline void nvme_send_uevents(struct list_head *events,
+				   struct kobject *kobj)
+{
+}
+static inline void nvme_aen_uevent(struct nvme_ctrl *ctrl,
+					enum nvme_uevent_aen_type event_type,
+					u8 event_info, u8 log_page)
+{
+}
+
+#endif	/* CONFIG_nvme_UEVENT */
+
+#endif	/* nvme_UEVENT_H */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 9d6a070..36a08b5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -132,6 +132,14 @@ struct nvme_ctrl {
 	struct list_head node;
 	struct ida ns_ida;
 
+	/*
+	 * Event handling.
+	 */
+	atomic_t uevent_seq;
+	struct list_head uevent_list;
+	spinlock_t uevent_lock; /* Protect access to uevent_list */
+	struct work_struct trigger_event_work;
+
 	struct opal_dev *opal_dev;
 
 	char name[12];
@@ -367,4 +375,6 @@ static inline struct nvme_ns *nvme_get_ns_from_dev(struct device *dev)
 int __init nvme_core_init(void);
 void nvme_core_exit(void);
 
+uint32_t nvme_next_uevent_seq(struct nvme_ctrl *ctrl);
+void nvme_uevent_add(struct nvme_ctrl *ctrl, struct list_head *elist);
 #endif /* _NVME_H */
-- 
1.8.5.2
