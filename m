From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:42 +0100
Subject: [PATCH 7/8] nvmet: add a generic NVMe target
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-8-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/Kconfig            |   1 +
 drivers/nvme/Makefile           |   1 +
 drivers/nvme/target/Kconfig     |   4 +
 drivers/nvme/target/Makefile    |   4 +
 drivers/nvme/target/admin-cmd.c | 353 +++++++++++++++++++++++++++++++
 drivers/nvme/target/configfs.c  | 205 ++++++++++++++++++
 drivers/nvme/target/core.c      | 454 ++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd.c    | 114 ++++++++++
 drivers/nvme/target/nvmet.h     | 172 +++++++++++++++
 9 files changed, 1308 insertions(+)
 create mode 100644 drivers/nvme/target/Kconfig
 create mode 100644 drivers/nvme/target/Makefile
 create mode 100644 drivers/nvme/target/admin-cmd.c
 create mode 100644 drivers/nvme/target/configfs.c
 create mode 100644 drivers/nvme/target/core.c
 create mode 100644 drivers/nvme/target/io-cmd.c
 create mode 100644 drivers/nvme/target/nvmet.h

diff --git a/drivers/nvme/Kconfig b/drivers/nvme/Kconfig
index a39d943..b7c78a5 100644
--- a/drivers/nvme/Kconfig
+++ b/drivers/nvme/Kconfig
@@ -1 +1,2 @@
 source "drivers/nvme/host/Kconfig"
+source "drivers/nvme/target/Kconfig"
diff --git a/drivers/nvme/Makefile b/drivers/nvme/Makefile
index 9421e82..0096a7f 100644
--- a/drivers/nvme/Makefile
+++ b/drivers/nvme/Makefile
@@ -1,2 +1,3 @@
 
 obj-y		+= host/
+obj-y		+= target/
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
new file mode 100644
index 0000000..9a3d742
--- /dev/null
+++ b/drivers/nvme/target/Kconfig
@@ -0,0 +1,4 @@
+
+config NVME_TARGET
+	depends on BLOCK
+	tristate
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
new file mode 100644
index 0000000..9c236e4
--- /dev/null
+++ b/drivers/nvme/target/Makefile
@@ -0,0 +1,4 @@
+
+obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
+
+nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
new file mode 100644
index 0000000..d9db0d4
--- /dev/null
+++ b/drivers/nvme/target/admin-cmd.c
@@ -0,0 +1,353 @@
+/*
+ * Copyright (c) 2015 HGST, a Western Digital Company.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "nvmet.h"
+
+static void nvmet_execute_get_error_log(struct nvmet_req *req)
+{
+	void *buf;
+
+	/*
+	 * We currently never set the More bit in the status field,
+	 * so all error log entries are invalid and can be zeroed out.
+	 * This is called a minum viable implementation (TM) of this
+	 * mandatory log page.
+	 */
+	buf = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	memset(buf, 0, req->data_len);
+	kunmap_atomic(buf);
+
+	nvmet_req_complete(req, 0);
+}
+
+static void nvmet_execute_get_smart_log(struct nvmet_req *req)
+{
+	struct nvme_smart_log *log;
+
+	/*
+	 * XXX: fill out actual smart log
+	 *
+	 * We might have a hard time coming up with useful values for many
+	 * of the fields, and even when we have useful data available
+	 * (e.g. units or commands read/written) those aren't persistent
+	 * over power loss.
+	 */
+	log = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	memset(log, 0, req->data_len);
+	kunmap_atomic(log);
+
+	nvmet_req_complete(req, 0);
+}
+
+static void nvmet_execute_get_fwslot_log(struct nvmet_req *req)
+{
+	void *buf;
+
+	/*
+	 * We only support a single firmware slot which always is active,
+	 * so we can zero out the whole firmware slot log and still claim
+	 * to fully implement this mandatory log page.
+	 */
+	buf = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	memset(buf, 0, req->data_len);
+	kunmap_atomic(buf);
+
+	nvmet_req_complete(req, 0);
+}
+
+static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvme_id_ctrl *id;
+
+	id = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	memset(id, 0, sizeof(*id));
+
+	/* XXX: figure out how to assign real vendors IDs. */
+	id->vid = 0;
+	id->ssvid = 0;
+
+	/* XXX: figure out real serial / model / revision values */
+	memset(id->sn, ' ', sizeof(id->sn));
+	memset(id->mn, ' ', sizeof(id->mn));
+	memset(id->fr, ' ', sizeof(id->fr));
+	strcpy((char *)id->mn, "Fake NVMe");
+
+	id->rab = 6;
+
+	/* XXX: figure out a real IEEE OUI */
+	id->ieee[0] = 0x00;
+	id->ieee[1] = 0x02;
+	id->ieee[2] = 0xb3;
+
+	/* we may have multiple controllers attached to the subsystem */
+	id->mic = (1 << 1);
+
+	/* no limit on data transfer sizes for now */
+	id->mdts = 0;
+	id->cntlid = cpu_to_le16(ctrl->cntlid);
+	id->ver = cpu_to_le32(ctrl->subsys->ver);
+
+	/* XXX: figure out what to do about RTD3R/RTD3 */
+
+	id->oacs = 0;
+	id->acl = 3;
+	id->aerl = 3;
+
+	/* first slot is read-only, only one slot supported */
+	id->frmw = (1 << 0) | (1 << 1);
+	id->lpa = 1 << 0;
+#define NVMET_ERROR_LOG_SLOTS	128
+	id->elpe = NVMET_ERROR_LOG_SLOTS - 1;
+	id->npss = 0;
+
+	id->sqes = (0x6 << 4) | 0x6;
+	id->cqes = (0x4 << 4) | 0x4;
+	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
+
+	/* XXX: don't report vwc if the underlying device is write through */
+	id->vwc = NVME_CTRL_VWC_PRESENT;
+
+	/*
+	 * We can't support atomic writes bigger than a LBA without support
+	 * from the backend device.
+	 */
+	id->awun = 0;
+	id->awupf = 0;
+
+	/*
+	 * We support SGLs, but nothing fancy.
+	 */
+	id->sgls = (1 << 0);
+
+	/*
+	 * Meh, we don't really support any power state.  Fake up the same
+	 * values that qemu does.
+	 */
+	id->psd[0].max_power = cpu_to_le16(0x9c4);
+	id->psd[0].entry_lat = cpu_to_le32(0x10);
+	id->psd[0].exit_lat = cpu_to_le32(0x4);
+
+	kunmap_atomic(id);
+
+	nvmet_req_complete(req, 0);
+}
+
+static void nvmet_execute_identify_ns(struct nvmet_req *req)
+{
+	struct nvmet_ns *ns;
+	struct nvme_id_ns *id;
+	u16 status = 0;
+
+	ns = nvmet_find_namespace(req->sq->ctrl, req->cmd->identify.nsid);
+	if (!ns) {
+		status = NVME_SC_INVALID_NS | NVME_SC_DNR;
+		goto out;
+	}
+
+	id = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	memset(id, 0, sizeof(*id));
+
+	/*
+	 * nuse = ncap = nsze isn't aways true, but we have no way to find
+	 * that out from the underlying device.
+	 */
+	id->ncap = id->nuse = id->nsze =
+		cpu_to_le64(ns->size >> ns->blksize_shift);
+
+	/*
+	 * We just provide a single LBA format that matches what the
+	 * underlying device reports.
+	 */
+	id->nlbaf = 0;
+	id->flbas = 0;
+
+	/*
+	 * Our namespace might always be shared.  Not just with other
+	 * controllers, but also with any other user of the block device.
+	 */
+	id->nmic = (1 << 0);
+
+	/* XXX: provide a nguid value! */
+
+	id->lbaf[0].ds = ns->blksize_shift;
+
+	kunmap_atomic(id);
+
+	nvmet_put_namespace(ns);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_identify_nslist(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_ns *ns;
+	u32 min_nsid = le32_to_cpu(req->cmd->identify.nsid);
+	__le32 *list;
+	int i = 0;
+
+	list = kmap_atomic(sg_page(req->sg)) + req->sg->offset;
+	rcu_read_lock();
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		if (ns->nsid <= min_nsid)
+			continue;
+		list[i++] = cpu_to_le32(ns->nsid);
+		if (i == req->data_len / sizeof(__le32))
+			goto out;
+	}
+
+	list[i] = 0;
+out:
+	rcu_read_unlock();
+	kunmap_atomic(list);
+
+	nvmet_req_complete(req, 0);
+}
+
+static void nvmet_execute_set_features(struct nvmet_req *req)
+{
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status = 0;
+
+	switch (cdw10 & 0xf) {
+	case NVME_FEAT_NUM_QUEUES:
+		nvmet_set_result(req,
+			subsys->max_qid | (subsys->max_qid << 16));
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_get_features(struct nvmet_req *req)
+{
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10[0]);
+	u16 status = 0;
+
+	switch (cdw10 & 0xf) {
+	/*
+	 * These features are mandatory in the spec, but we don't
+	 * have a useful way to implement them.  We'll eventually
+	 * need to come up with some fake values for these.
+	 */
+#if 0
+	case NVME_FEAT_ARBITRATION:
+		break;
+	case NVME_FEAT_POWER_MGMT:
+		break;
+	case NVME_FEAT_TEMP_THRESH:
+		break;
+	case NVME_FEAT_ERR_RECOVERY:
+		break;
+	case NVME_FEAT_IRQ_COALESCE:
+		break;
+	case NVME_FEAT_IRQ_CONFIG:
+		break;
+	case NVME_FEAT_WRITE_ATOMIC:
+		break;
+	case NVME_FEAT_ASYNC_EVENT:
+		break;
+#endif
+	case NVME_FEAT_VOLATILE_WC:
+		nvmet_set_result(req, 1);
+		break;
+	case NVME_FEAT_NUM_QUEUES:
+		nvmet_set_result(req,
+			subsys->max_qid | (subsys->max_qid << 16));
+		break;
+	default:
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		break;
+	}
+
+	nvmet_req_complete(req, status);
+}
+
+static inline u32 nvmet_get_log_page_len(struct nvme_command *cmd)
+{
+	u32 cdw10 = cmd->common.cdw10[0];
+
+	return ((cdw10 >> 16) & 0xff) * sizeof(u32);
+}
+
+int nvmet_parse_admin_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	req->ns = NULL;
+
+	switch (cmd->common.opcode) {
+	case nvme_admin_get_log_page:
+		req->data_len = nvmet_get_log_page_len(cmd);
+
+		switch (cmd->common.cdw10[0] & 0xf) {
+		case 0x01:
+			req->execute = nvmet_execute_get_error_log;
+			return 0;
+		case 0x02:
+			req->execute = nvmet_execute_get_smart_log;
+			return 0;
+		case 0x03:
+			req->execute = nvmet_execute_get_fwslot_log;
+			return 0;
+		}
+		break;
+	case nvme_admin_identify:
+		switch (cmd->identify.cns) {
+		case 0x00:
+			req->execute = nvmet_execute_identify_ns;
+			req->data_len = sizeof(struct nvme_id_ns);
+			return 0;
+		case 0x01:
+			req->execute = nvmet_execute_identify_ctrl;
+			req->data_len = sizeof(struct nvme_id_ctrl);
+			return 0;
+		case 0x02:
+			req->execute = nvmet_execute_identify_nslist;
+			req->data_len = 4096;
+			return 0;
+		}
+		break;
+#if 0
+	case nvme_admin_abort_cmd:
+		req->execute = nvmet_execute_abort;
+		req->data_len = 0;
+		return 0;
+#endif
+	case nvme_admin_set_features:
+		req->execute = nvmet_execute_set_features;
+		req->data_len = 0;
+		return 0;
+	case nvme_admin_get_features:
+		req->execute = nvmet_execute_get_features;
+		req->data_len = 0;
+		return 0;
+#if 0
+	case nvme_admin_async_event:
+		req->exectute = nvmet_execute_aen;
+		req->data = 0;
+		return 0;
+#endif
+	}
+
+	pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+	return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+}
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
new file mode 100644
index 0000000..7dcdc58e
--- /dev/null
+++ b/drivers/nvme/target/configfs.c
@@ -0,0 +1,205 @@
+/*
+ * Copyright (c) 2015 HGST, a Western Digital Company.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+
+#include "nvmet.h"
+
+
+CONFIGFS_ATTR_STRUCT(nvmet_ns);
+CONFIGFS_ATTR_OPS(nvmet_ns);
+
+static ssize_t nvmet_ns_device_path_show(struct nvmet_ns *ns, char *page)
+{
+	return sprintf(page, "%s", ns->device_path);
+}
+
+static ssize_t nvmet_ns_device_path_store(struct nvmet_ns *ns, const char *page,
+		size_t count)
+{
+	int ret = nvmet_ns_enable(ns, page);
+
+	return ret ? ret : count;
+}
+
+static struct nvmet_ns_attribute nvmet_ns_attr_device_path = {
+	.attr = {
+		.ca_name	= "device_path",
+		.ca_mode	= S_IRUSR | S_IWUSR,
+		.ca_owner	= THIS_MODULE,
+	},
+	.show			= nvmet_ns_device_path_show,
+	.store			= nvmet_ns_device_path_store,
+};
+
+static struct configfs_attribute *nvmet_ns_attrs[] = {
+	&nvmet_ns_attr_device_path.attr,
+	NULL,
+};
+
+static void nvmet_ns_release(struct config_item *item)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+
+	nvmet_ns_free(ns);
+}
+
+static struct configfs_item_operations nvmet_ns_item_ops = {
+	.release		= nvmet_ns_release,
+	.show_attribute		= nvmet_ns_attr_show,
+	.store_attribute        = nvmet_ns_attr_store,
+};
+
+static struct config_item_type nvmet_ns_type = {
+	.ct_item_ops		= &nvmet_ns_item_ops,
+	.ct_attrs		= nvmet_ns_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_ns_make(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys = namespaces_to_subsys(&group->cg_item);
+	struct nvmet_ns *ns;
+	int ret;
+	u32 nsid;
+
+	ret = kstrtou32(name, 0, &nsid);
+	if (ret)
+		goto out;
+
+	ret = -EINVAL;
+	if (nsid == 0 || nsid == 0xffffffff)
+		goto out;
+
+	ret = -ENOMEM;
+	ns = nvmet_ns_alloc(subsys, nsid);
+	if (!ns)
+		goto out;
+	config_group_init_type_name(&ns->group, name, &nvmet_ns_type);
+
+	pr_info("adding nsid %d to subsystem %s\n", nsid, subsys->subsys_name);
+
+	return &ns->group;
+out:
+	return ERR_PTR(ret);
+}
+
+static struct configfs_group_operations nvmet_namespaces_group_ops = {
+	.make_group		= nvmet_ns_make,
+};
+
+static struct config_item_type nvmet_namespaces_type = {
+	.ct_group_ops		= &nvmet_namespaces_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_item_type nvmet_controllers_type = {
+	.ct_owner		= THIS_MODULE,
+};
+
+static void nvmet_subsys_release(struct config_item *item)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	nvmet_subsys_free(subsys);
+}
+
+static struct configfs_item_operations nvmet_subsys_item_ops = {
+	.release		= nvmet_subsys_release,
+};
+
+static struct config_item_type nvmet_subsys_type = {
+	.ct_item_ops		= &nvmet_subsys_item_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_subsys_make(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys;
+
+	subsys = nvmet_subsys_alloc(name);
+	if (!subsys)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&subsys->group, name, &nvmet_subsys_type);
+
+	config_group_init_type_name(&subsys->namespaces_group,
+			"namespaces", &nvmet_namespaces_type);
+	config_group_init_type_name(&subsys->controllers_group,
+			"controllers", &nvmet_controllers_type);
+
+	subsys->default_groups[0] = &subsys->namespaces_group;
+	subsys->default_groups[1] = &subsys->controllers_group;
+	subsys->default_groups[2] = NULL;
+
+	subsys->group.default_groups = subsys->default_groups;
+	return &subsys->group;
+}
+
+static struct configfs_group_operations nvmet_subsystems_group_ops = {
+	.make_group		= nvmet_subsys_make,
+};
+
+static struct config_item_type nvmet_subsystems_type = {
+	.ct_group_ops		= &nvmet_subsystems_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+struct config_group nvmet_subsystems_group;
+
+struct config_group *nvmet_root_default_groups[] = {
+	&nvmet_subsystems_group,
+	NULL,
+};
+
+static struct config_item_type nvmet_root_type = {
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct configfs_subsystem nvmet_configfs_subsystem = {
+	.su_group = {
+		.cg_item = {
+			.ci_namebuf	= "nvmet",
+			.ci_type	= &nvmet_root_type,
+		},
+		.default_groups = nvmet_root_default_groups,
+	},
+};
+
+int __init nvmet_init_configfs(void)
+{
+	int ret;
+
+	config_group_init(&nvmet_configfs_subsystem.su_group);
+	mutex_init(&nvmet_configfs_subsystem.su_mutex);
+
+	config_group_init_type_name(&nvmet_subsystems_group,
+			"subsystems", &nvmet_subsystems_type);
+
+	ret = configfs_register_subsystem(&nvmet_configfs_subsystem);
+	if (ret) {
+		pr_err("configfs_register_subsystem: %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+void __exit nvmet_exit_configfs(void)
+{
+	configfs_unregister_subsystem(&nvmet_configfs_subsystem);
+}
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
new file mode 100644
index 0000000..5c770bf
--- /dev/null
+++ b/drivers/nvme/target/core.c
@@ -0,0 +1,454 @@
+/*
+ * Copyright (c) 2015 HGST, a Western Digital Company.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "nvmet.h"
+
+static DEFINE_MUTEX(nvmet_subsystem_mutex);
+static LIST_HEAD(nvmet_subsystems);
+
+static struct nvmet_ns *__nvmet_find_namespace(struct nvmet_ctrl *ctrl,
+		__le32 nsid)
+{
+	struct nvmet_ns *ns;
+
+	list_for_each_entry_rcu(ns, &ctrl->subsys->namespaces, dev_link) {
+		if (ns->nsid == le32_to_cpu(nsid))
+			return ns;
+	}
+
+	return NULL;
+}
+
+struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid)
+{
+	struct nvmet_ns *ns;
+
+	rcu_read_lock();
+	ns = __nvmet_find_namespace(ctrl, nsid);
+	if (ns && !kref_get_unless_zero(&ns->ref))
+		ns = NULL;
+	rcu_read_unlock();
+
+	return ns;
+}
+
+static void nvmet_destroy_namespace(struct kref *ref)
+{
+	struct nvmet_ns *ns = container_of(ref, struct nvmet_ns, ref);
+
+	if (ns->bdev)
+		blkdev_put(ns->bdev, FMODE_WRITE|FMODE_READ);
+	kfree(ns->device_path);
+	kfree(ns);
+}
+
+void nvmet_put_namespace(struct nvmet_ns *ns)
+{
+	kref_put(&ns->ref, nvmet_destroy_namespace);
+}
+
+int nvmet_ns_enable(struct nvmet_ns *ns, const char *path)
+{
+	int ret;
+
+	mutex_lock(&ns->subsys->lock);
+	ret = -EBUSY;
+	if (ns->device_path)
+		goto out_unlock;
+
+	ret = -ENOMEM;
+	ns->device_path = kstrdup(path, GFP_KERNEL);
+	if (!ns->device_path)
+		goto out_unlock;
+
+	ns->bdev = blkdev_get_by_path(path, FMODE_READ|FMODE_WRITE, NULL);
+	if (IS_ERR(ns->bdev)) {
+		pr_err("nvmet: failed to open block device %s: (%ld)\n",
+			path, PTR_ERR(ns->bdev));
+		ret = PTR_ERR(ns->bdev);
+		goto out_free_device_path;
+	}
+
+	ns->size = i_size_read(ns->bdev->bd_inode);
+	ns->blksize_shift = blksize_bits(bdev_logical_block_size(ns->bdev));
+
+	if (ns->nsid > ns->subsys->max_nsid)
+		ns->subsys->max_nsid = ns->nsid;
+
+	list_add_rcu(&ns->dev_link, &ns->subsys->namespaces);
+	mutex_unlock(&ns->subsys->lock);
+
+	return 0;
+
+out_free_device_path:
+	kfree(ns->device_path);
+	ns->device_path = NULL;
+out_unlock:
+	mutex_unlock(&ns->subsys->lock);
+	return ret;
+}
+
+void nvmet_ns_free(struct nvmet_ns *ns)
+{
+	struct nvmet_subsys *subsys = ns->subsys;
+
+	mutex_lock(&subsys->lock);
+	if (!list_empty(&ns->dev_link))
+		list_del_init(&ns->dev_link);
+	mutex_unlock(&subsys->lock);
+
+	nvmet_put_namespace(ns);
+}
+
+struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid)
+{
+	struct nvmet_ns *ns;
+
+	ns = kzalloc(sizeof(*ns), GFP_KERNEL);
+	if (!ns)
+		return NULL;
+
+	kref_init(&ns->ref);
+	ns->nsid = nsid;
+	ns->subsys = subsys;
+	return ns;
+}
+
+void nvmet_req_complete(struct nvmet_req *req, u16 status)
+{
+	if (status)
+		nvmet_set_status(req, status);
+
+	/* XXX: need to fill in something useful for sq_head */
+	req->rsp->sq_head = 0;
+	req->rsp->sq_id = cpu_to_le16(req->sq->qid);
+	req->rsp->command_id = req->cmd->common.command_id;
+
+	if (req->ns)
+		nvmet_put_namespace(req->ns);
+	req->queue_response(req);
+}
+EXPORT_SYMBOL_GPL(nvmet_req_complete);
+
+void nvmet_cq_init(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq,
+		u16 qid, u16 size)
+{
+	cq->qid = qid;
+	cq->size = size;
+
+	ctrl->cqs[qid] = cq;
+}
+EXPORT_SYMBOL_GPL(nvmet_cq_init);
+
+void nvmet_sq_init(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq,
+		u16 qid, u16 size)
+{
+	sq->ctrl = ctrl;
+	sq->qid = qid;
+	sq->size = size;
+
+	ctrl->sqs[qid] = sq;
+}
+EXPORT_SYMBOL_GPL(nvmet_sq_init);
+
+void nvmet_sq_destroy(struct nvmet_sq *sq)
+{
+	if (sq->ctrl)
+		nvmet_ctrl_put(sq->ctrl);
+}
+EXPORT_SYMBOL_GPL(nvmet_sq_destroy);
+
+u16 nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
+		struct nvmet_sq *sq,
+		void (*queue_response)(struct nvmet_req *req))
+{
+	u16 status;
+
+	req->cq = cq;
+	req->sq = sq;
+	req->queue_response = queue_response;
+	req->sg = NULL;
+	req->sg_cnt = 0;
+	req->rsp->status = 0;
+
+	if (unlikely(req->sq->qid == 0))
+		status = nvmet_parse_admin_cmd(req);
+	else
+		status = nvmet_parse_io_cmd(req);
+
+	if (status)
+		return status;
+
+	if (unlikely(!req->sq->ctrl)) {
+		pr_err("queue not connected!\n");
+		return NVME_SC_QID_INVALID | NVME_SC_DNR;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvmet_req_init);
+
+static inline bool nvmet_cc_en(u32 cc)
+{
+	return cc & 0x1;
+}
+
+static inline u8 nvmet_cc_css(u32 cc)
+{
+	return (cc >> 4) & 0x7;
+}
+
+static inline u8 nvmet_cc_mps(u32 cc)
+{
+	return (cc >> 7) & 0xf;
+}
+
+static inline u8 nvmet_cc_ams(u32 cc)
+{
+	return (cc >> 11) & 0x7;
+}
+
+static inline u8 nvmet_cc_shn(u32 cc)
+{
+	return (cc >> 14) & 0x3;
+}
+
+static inline u8 nvmet_cc_iosqes(u32 cc)
+{
+	return (cc >> 16) & 0xf;
+}
+
+static inline u8 nvmet_cc_iocqes(u32 cc)
+{
+	return (cc >> 20) & 0xf;
+}
+
+static void nvmet_start_ctrl(struct nvmet_ctrl *ctrl)
+{
+#if 0
+	    nvmet_cc_iosqes(n->bar.cc) < NVME_CTRL_SQES_MIN(n->id_ctrl.sqes) ||
+	    nvmet_cc_iosqes(n->bar.cc) > NVME_CTRL_SQES_MAX(n->id_ctrl.sqes) ||
+	    nvmet_cc_iocqes(n->bar.cc) < NVME_CTRL_CQES_MIN(n->id_ctrl.cqes) ||
+	    nvmet_cc_iocqes(n->bar.cc) > NVME_CTRL_CQES_MAX(n->id_ctrl.cqes) ||
+#endif
+	if (nvmet_cc_mps(ctrl->cc) != 0 ||
+	    nvmet_cc_ams(ctrl->cc) != 0 ||
+	    nvmet_cc_css(ctrl->cc) != 0) {
+		ctrl->csts = NVME_CSTS_CFS;
+		return;
+	}
+
+	ctrl->csts = NVME_CSTS_RDY;
+}
+
+static void nvmet_clear_ctrl(struct nvmet_ctrl *ctrl)
+{
+	/* XXX: tear down queues? */
+	ctrl->csts &= ~NVME_CSTS_RDY;
+	ctrl->cc = 0;
+}
+
+void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new)
+{
+	u32 old;
+
+	/* XXX: locking? */
+	old = ctrl->cc;
+	ctrl->cc = new;
+
+	if (nvmet_cc_en(new) && !nvmet_cc_en(old))
+		nvmet_start_ctrl(ctrl);
+	if (!nvmet_cc_en(new) && nvmet_cc_en(old))
+		nvmet_clear_ctrl(ctrl);
+	if (nvmet_cc_shn(new) && !nvmet_cc_shn(old)) {
+		nvmet_clear_ctrl(ctrl);
+		ctrl->csts |= NVME_CSTS_SHST_CMPLT;
+	}
+	if (!nvmet_cc_shn(new) && nvmet_cc_shn(old))
+		ctrl->csts &= ~NVME_CSTS_SHST_CMPLT;
+}
+EXPORT_SYMBOL_GPL(nvmet_update_cc);
+
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmet_subsys *subsys, u16 cntlid)
+{
+	struct nvmet_ctrl *ctrl;
+
+	lockdep_assert_held(&subsys->lock);
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (ctrl->cntlid == cntlid) {
+			if (kref_get_unless_zero(&ctrl->ref))
+				return ctrl;
+			return NULL;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(nvmet_ctrl_find_get);
+
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_subsys *subsys,
+		const char *subsys_name)
+{
+	struct nvmet_ctrl *ctrl;
+	int ret = -ENOMEM;
+
+	lockdep_assert_held(&subsys->lock);
+
+	ctrl = kzalloc(sizeof(*ctrl), GFP_KERNEL);
+	if (!ctrl)
+		goto out;
+
+	/* command sets supported: NVMe command set: */
+	ctrl->cap |= (1ULL << 37);
+	/* CC.EN timeout in 500msec units: */
+	ctrl->cap |= (15ULL << 24);
+	/* maximum queue entries supported: */
+	ctrl->cap |= NVMET_QUEUE_SIZE - 1;
+
+	memcpy(ctrl->subsys_name, subsys_name, NVMET_SUBSYS_NAME_LEN);
+
+	kref_init(&ctrl->ref);
+	ctrl->subsys = subsys;
+
+	ctrl->cqs = kcalloc(subsys->max_qid + 1,
+			sizeof(struct nvmet_queue *),
+			GFP_KERNEL);
+	if (!ctrl->cqs)
+		goto out_free_ctrl;
+
+	ctrl->sqs = kcalloc(subsys->max_qid + 1,
+			sizeof(struct nvmet_queue *),
+			GFP_KERNEL);
+	if (!ctrl->sqs)
+		goto out_free_cqs;
+
+	ctrl->cntlid = ida_simple_get(&subsys->cntlid_ida, 0, USHRT_MAX - 1,
+			GFP_KERNEL);
+	if (ctrl->cntlid < 0) {
+		ret = ctrl->cntlid;
+		goto out_free_sqs;
+	}
+
+	list_add_tail(&ctrl->subsys_entry, &subsys->ctrls);
+	return ctrl;
+
+out_free_sqs:
+	kfree(ctrl->sqs);
+out_free_cqs:
+	kfree(ctrl->cqs);
+out_free_ctrl:
+	kfree(ctrl);
+out:
+	return ERR_PTR(ret);
+}
+EXPORT_SYMBOL_GPL(nvmet_alloc_ctrl);
+
+static void nvmet_ctrl_free(struct kref *ref)
+{
+	struct nvmet_ctrl *ctrl = container_of(ref, struct nvmet_ctrl, ref);
+	struct nvmet_subsys *subsys = ctrl->subsys;
+
+	mutex_lock(&ctrl->subsys->lock);
+	list_del(&ctrl->subsys_entry);
+	mutex_unlock(&ctrl->subsys->lock);
+
+	mutex_lock(&subsys->lock);
+	ida_simple_remove(&subsys->cntlid_ida, ctrl->cntlid);
+	mutex_unlock(&subsys->lock);
+
+	kfree(ctrl->sqs);
+	kfree(ctrl->cqs);
+	kfree(ctrl);
+}
+
+void nvmet_ctrl_put(struct nvmet_ctrl *ctrl)
+{
+	kref_put(&ctrl->ref, nvmet_ctrl_free);
+}
+
+struct nvmet_subsys *nvmet_find_subsys(char *subsys_name)
+{
+	struct nvmet_subsys *subsys;
+
+	mutex_lock(&nvmet_subsystem_mutex);
+	list_for_each_entry(subsys, &nvmet_subsystems, entry) {
+		if (!strncmp(subsys->subsys_name, subsys_name,
+				NVMET_SUBSYS_NAME_LEN)) {
+			/* XXX: need to start refcounting subsystems.. */
+			mutex_unlock(&nvmet_subsystem_mutex);
+			return subsys;
+		}
+	}
+	mutex_unlock(&nvmet_subsystem_mutex);
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(nvmet_find_subsys);
+
+struct nvmet_subsys *nvmet_subsys_alloc(const char *subsys_name)
+{
+	struct nvmet_subsys *subsys;
+
+	subsys = kzalloc(sizeof(*subsys), GFP_KERNEL);
+	if (!subsys)
+		return NULL;
+
+	subsys->subsys_name = kstrndup(subsys_name, NVMET_SUBSYS_NAME_LEN,
+			GFP_KERNEL);
+	if (IS_ERR(subsys->subsys_name)) {
+		kfree(subsys);
+		return NULL;
+	}
+
+	mutex_init(&subsys->lock);
+	INIT_LIST_HEAD(&subsys->namespaces);
+	INIT_LIST_HEAD(&subsys->ctrls);
+
+	ida_init(&subsys->cntlid_ida);
+	subsys->max_qid = NVMET_NR_QUEUES;
+
+	mutex_lock(&nvmet_subsystem_mutex);
+	list_add_tail(&subsys->entry, &nvmet_subsystems);
+	mutex_unlock(&nvmet_subsystem_mutex);
+
+	return subsys;
+}
+
+void nvmet_subsys_free(struct nvmet_subsys *subsys)
+{
+	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
+
+	mutex_lock(&nvmet_subsystem_mutex);
+	list_del(&subsys->entry);
+	mutex_unlock(&nvmet_subsystem_mutex);
+
+	kfree(subsys->subsys_name);
+	kfree(subsys);
+}
+
+static int __init nvmet_init(void)
+{
+	return nvmet_init_configfs();
+}
+
+static void __exit nvmet_exit(void)
+{
+	nvmet_exit_configfs();
+}
+
+module_init(nvmet_init);
+module_exit(nvmet_exit);
+
+MODULE_LICENSE("GPL v2");
diff --git a/drivers/nvme/target/io-cmd.c b/drivers/nvme/target/io-cmd.c
new file mode 100644
index 0000000..2cf1811
--- /dev/null
+++ b/drivers/nvme/target/io-cmd.c
@@ -0,0 +1,114 @@
+/*
+ * Copyright (c) 2015 HGST, a Western Digital Company.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blkdev.h>
+#include <linux/module.h>
+#include "nvmet.h"
+
+static void nvmet_bio_done(struct bio *bio)
+{
+	nvmet_req_complete(bio->bi_private,
+		bio->bi_error ? NVME_SC_INTERNAL | NVME_SC_DNR : 0);
+	bio_put(bio);
+}
+
+static void nvmet_execute_rw(struct nvmet_req *req)
+{
+	int sg_cnt = req->sg_cnt;
+	struct scatterlist *sg;
+	struct bio *bio;
+	sector_t sector;
+	int rw, i;
+
+	if (!req->sg_cnt) {
+		nvmet_req_complete(req, 0);
+		return;
+	}
+
+	if (req->cmd->rw.opcode == nvme_cmd_write) {
+		if (req->cmd->rw.control & cpu_to_le16(NVME_RW_FUA))
+			rw = WRITE_FUA;
+		else
+			rw = WRITE;
+	} else {
+		rw = READ;
+	}
+
+	sector = le64_to_cpu(req->cmd->rw.slba);
+	sector <<= (req->ns->blksize_shift - 9);
+
+	bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+	bio->bi_bdev = req->ns->bdev;
+	bio->bi_iter.bi_sector = sector;
+	bio->bi_private = req;
+	bio->bi_end_io = nvmet_bio_done;
+
+	for_each_sg(req->sg, sg, req->sg_cnt, i) {
+		if (bio_add_page(bio, sg_page(sg), sg->length, sg->offset)
+				!= sg->length) {
+			struct bio *prev = bio;
+
+			bio = bio_alloc(GFP_KERNEL, min(sg_cnt, BIO_MAX_PAGES));
+			bio->bi_bdev = req->ns->bdev;
+			bio->bi_iter.bi_sector = sector;
+
+			bio_chain(bio, prev);
+			submit_bio(rw, prev);
+		}
+
+		sector += sg->length >> 9;
+		sg_cnt--;
+	}
+
+	submit_bio(rw, bio);
+}
+
+static void nvmet_execute_flush(struct nvmet_req *req)
+{
+	struct bio *bio = bio_alloc(GFP_KERNEL, 0);
+
+	bio->bi_bdev = req->ns->bdev;
+	bio->bi_private = req;
+	bio->bi_end_io = nvmet_bio_done;
+
+	submit_bio(WRITE_FLUSH, bio);
+}
+
+int nvmet_parse_io_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	req->ns = nvmet_find_namespace(req->sq->ctrl, cmd->rw.nsid);
+	if (!req->ns)
+		return NVME_SC_INVALID_NS | NVME_SC_DNR;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_read:
+		req->execute = nvmet_execute_rw;
+		req->data_len = ((u32)le16_to_cpu(cmd->rw.length) + 1) <<
+				req->ns->blksize_shift;
+		return 0;
+	case nvme_cmd_write:
+		req->execute = nvmet_execute_rw;
+		req->data_len = ((u32)le16_to_cpu(cmd->rw.length) + 1) <<
+				req->ns->blksize_shift;
+		return 0;
+	case nvme_cmd_flush:
+		req->execute = nvmet_execute_flush;
+		req->data_len = 0;
+		return 0;
+	default:
+		pr_err("nvmet: unhandled cmd %d\n", cmd->common.opcode);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
new file mode 100644
index 0000000..9335584
--- /dev/null
+++ b/drivers/nvme/target/nvmet.h
@@ -0,0 +1,172 @@
+#ifndef _NVME_CMD_H
+#define _NVME_CMD_H
+
+#include <linux/dma-mapping.h>
+#include <linux/types.h>
+#include <linux/device.h>
+#include <linux/kref.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/nvme.h>
+#include <linux/configfs.h>
+#include <linux/rcupdate.h>
+
+struct nvmet_ns {
+	struct list_head	dev_link;
+	struct kref		ref;
+	struct block_device	*bdev;
+	u32			nsid;
+	u32			blksize_shift;
+	loff_t			size;
+
+	struct nvmet_subsys	*subsys;
+	const char		*device_path;
+
+	struct config_group	device_group;
+	struct config_group	default_groups[2];
+	struct config_group	group;
+	struct rcu_head		rcu;
+};
+
+static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_ns, group);
+}
+
+struct nvmet_cq {
+	u16			qid;
+	u16			size;
+};
+
+struct nvmet_sq {
+	struct nvmet_ctrl	*ctrl;
+	u16			qid;
+	u16			size;
+};
+
+struct nvmet_ctrl {
+	struct nvmet_subsys	*subsys;
+	struct nvmet_cq		**cqs;
+	struct nvmet_sq		**sqs;
+
+	u64			cap;
+	u32			cc;
+	u32			csts;
+
+	u16			cntlid;
+
+	struct list_head	subsys_entry;
+	struct kref		ref;
+#define NVMET_SUBSYS_NAME_LEN		256
+	char			subsys_name[NVMET_SUBSYS_NAME_LEN];
+};
+
+struct nvmet_subsys {
+	struct mutex		lock;
+
+	struct list_head	namespaces;
+	unsigned int		max_nsid;
+
+	struct list_head	ctrls;
+	struct ida		cntlid_ida;
+
+	u16			max_qid;
+
+	u64			ver;
+	char			*subsys_name;
+
+	struct list_head	entry;
+	struct config_group	group;
+
+	struct config_group	namespaces_group;
+	struct config_group	controllers_group;
+	struct config_group	*default_groups[3];
+};
+
+static inline struct nvmet_subsys *to_subsys(struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys, group);
+}
+
+static inline struct nvmet_subsys *namespaces_to_subsys(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys,
+			namespaces_group);
+}
+
+struct nvmet_req {
+	struct nvme_command	*cmd;
+	struct nvme_completion	*rsp;
+	struct nvmet_sq		*sq;
+	struct nvmet_cq		*cq;
+	struct nvmet_ns		*ns;
+	struct scatterlist	*sg;
+	int			sg_cnt;
+	size_t			data_len;
+
+	void (*execute)(struct nvmet_req *req);
+	void (*queue_response)(struct nvmet_req *req);
+};
+
+static inline void nvmet_set_status(struct nvmet_req *req, u16 status)
+{
+	req->rsp->status = cpu_to_le16(status << 1);
+}
+
+static inline void nvmet_set_result(struct nvmet_req *req, u32 result)
+{
+	req->rsp->result = cpu_to_le32(result);
+}
+
+static inline bool nvmet_is_write(struct nvmet_req *req)
+{
+	return req->cmd->common.opcode & 1;
+}
+
+/*
+ * NVMe command writes actually are DMA reads for us on the target side.
+ */
+static inline enum dma_data_direction
+nvmet_data_dir(struct nvmet_req *cmd)
+{
+	return nvmet_is_write(cmd) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+}
+
+int nvmet_parse_io_cmd(struct nvmet_req *req);
+int nvmet_parse_admin_cmd(struct nvmet_req *req);
+
+u16 nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
+		struct nvmet_sq *sq,
+		void (*queue_response)(struct nvmet_req *req));
+void nvmet_req_complete(struct nvmet_req *req, u16 status);
+
+void nvmet_cq_init(struct nvmet_ctrl *ctrl, struct nvmet_cq *cq, u16 qid,
+		u16 size);
+void nvmet_sq_init(struct nvmet_ctrl *ctrl, struct nvmet_sq *sq, u16 qid,
+		u16 size);
+void nvmet_sq_destroy(struct nvmet_sq *sq);
+
+void nvmet_update_cc(struct nvmet_ctrl *ctrl, u32 new);
+struct nvmet_ctrl *nvmet_alloc_ctrl(struct nvmet_subsys *subsys,
+		const char *subsys_name);
+struct nvmet_ctrl *nvmet_ctrl_find_get(struct nvmet_subsys *subsys, u16 cntlid);
+void nvmet_ctrl_put(struct nvmet_ctrl *ctrl);
+
+struct nvmet_subsys *nvmet_find_subsys(char *subsys_name);
+struct nvmet_subsys *nvmet_subsys_alloc(const char *subsys_name);
+void nvmet_subsys_free(struct nvmet_subsys *subsys);
+
+struct nvmet_ns *nvmet_find_namespace(struct nvmet_ctrl *ctrl, __le32 nsid);
+void nvmet_put_namespace(struct nvmet_ns *ns);
+int nvmet_ns_enable(struct nvmet_ns *ns, const char *path);
+struct nvmet_ns *nvmet_ns_alloc(struct nvmet_subsys *subsys, u32 nsid);
+void nvmet_ns_free(struct nvmet_ns *ns);
+
+#define NVMET_QUEUE_SIZE	1024
+#define NVMET_NR_QUEUES		64
+
+int __init nvmet_init_configfs(void);
+void __exit nvmet_exit_configfs(void);
+
+#endif /* _NVME_CMD_H */
-- 
1.9.1
