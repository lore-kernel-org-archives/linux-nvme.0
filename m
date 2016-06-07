From: nab@linux-iscsi.org (Nicholas A. Bellinger)
Date: Tue,  7 Jun 2016 06:36:50 +0000
Subject: [RFC 2/8] nvmet: Add support for configfs-ng multi-tenant logic
In-Reply-To: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
References: <1465281416-28355-1-git-send-email-nab@linux-iscsi.org>
Message-ID: <1465281416-28355-3-git-send-email-nab@linux-iscsi.org>

From: Nicholas Bellinger <nab@linux-iscsi.org>

This patch introduces support for configfs-ng, that allows
for multi-tenant /sys/kernel/config/nvmet/subsystems/$SUBSYS_NQN/
operation, using existing /sys/kernel/config/target/core/
backends from target-core to be configfs symlinked as
per nvme-target subsystem NQN namespaces.

Here's how the layout looks:

/sys/kernel/config/nvmet/
??? subsystems
    ??? nqn.2003-01.org.linux-iscsi.NVMf.skylake-ep
        ??? namespaces
        ??? ??? 1
        ???     ??? ramdisk0 -> ../../../../../target/core/rd_mcp_1/ramdisk0
        ??? ports
            ??? loop
                ??? addr_adrfam
                ??? addr_portid
                ??? addr_traddr
                ??? addr_treq
                ??? addr_trsvcid
                ??? addr_trtype
                ??? enable

Also convert nvmet_find_get_subsys to port->nf_subsys, and
do the same for nvmet_host_discovery_allowed.

Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Martin Petersen <martin.petersen at oracle.com>
Cc: Sagi Grimberg <sagi at grimberg.me>
Cc: Hannes Reinecke <hare at suse.de>
Cc: Mike Christie <michaelc at cs.wisc.edu>
Signed-off-by: Nicholas Bellinger <nab at linux-iscsi.org>
---
 drivers/nvme/target/Makefile      |   2 +-
 drivers/nvme/target/configfs-ng.c | 586 ++++++++++++++++++++++++++++++++++++++
 drivers/nvme/target/configfs.c    |   5 +-
 drivers/nvme/target/core.c        |  22 +-
 drivers/nvme/target/nvmet.h       |  11 +
 5 files changed, 608 insertions(+), 18 deletions(-)
 create mode 100644 drivers/nvme/target/configfs-ng.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index b7a0623..2799e07 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -3,7 +3,7 @@ obj-$(CONFIG_NVME_TARGET)		+= nvmet.o
 obj-$(CONFIG_NVME_TARGET_LOOP)		+= nvme-loop.o
 obj-$(CONFIG_NVME_TARGET_RDMA)		+= nvmet-rdma.o
 
-nvmet-y		+= core.o configfs.o admin-cmd.o io-cmd.o fabrics-cmd.o \
+nvmet-y		+= core.o configfs-ng.o admin-cmd.o io-cmd.o fabrics-cmd.o \
 			discovery.o
 nvme-loop-y	+= loop.o
 nvmet-rdma-y	+= rdma.o
diff --git a/drivers/nvme/target/configfs-ng.c b/drivers/nvme/target/configfs-ng.c
new file mode 100644
index 0000000..d495017
--- /dev/null
+++ b/drivers/nvme/target/configfs-ng.c
@@ -0,0 +1,586 @@
+/*
+ * Based on target_core_fabric_configfs.c code
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/stat.h>
+#include <linux/ctype.h>
+#include <target/target_core_base.h>
+#include <target/target_core_backend.h>
+
+#include "nvmet.h"
+
+/*
+ * nvmet_port Generic ConfigFS definitions.
+ */
+static ssize_t nvmet_port_addr_adrfam_show(struct config_item *item,
+		char *page)
+{
+	switch (to_nvmet_port(item)->disc_addr.adrfam) {
+	case NVMF_ADDR_FAMILY_IP4:
+		return sprintf(page, "ipv4\n");
+	case NVMF_ADDR_FAMILY_IP6:
+		return sprintf(page, "ipv6\n");
+	case NVMF_ADDR_FAMILY_IB:
+		return sprintf(page, "ib\n");
+	default:
+		return sprintf(page, "\n");
+	}
+}
+
+static ssize_t nvmet_port_addr_adrfam_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+
+	if (sysfs_streq(page, "ipv4")) {
+		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IP4;
+	} else if (sysfs_streq(page, "ipv6")) {
+		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IP6;
+	} else if (sysfs_streq(page, "ib")) {
+		port->disc_addr.adrfam = NVMF_ADDR_FAMILY_IB;
+	} else {
+		pr_err("Invalid value '%s' for adrfam\n", page);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_adrfam);
+
+static ssize_t nvmet_port_addr_portid_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%d\n",
+			le16_to_cpu(port->disc_addr.portid));
+}
+
+static ssize_t nvmet_port_addr_portid_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u16 portid = 0;
+
+	if (kstrtou16(page, 0, &portid)) {
+		pr_err("Invalid value '%s' for portid\n", page);
+		return -EINVAL;
+	}
+
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+	port->disc_addr.portid = cpu_to_le16(portid);
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_portid);
+
+static ssize_t nvmet_port_addr_traddr_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->disc_addr.traddr);
+}
+
+static ssize_t nvmet_port_addr_traddr_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (count > NVMF_TRADDR_SIZE) {
+		pr_err("Invalid value '%s' for traddr\n", page);
+		return -EINVAL;
+	}
+
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+	return snprintf(port->disc_addr.traddr,
+			sizeof(port->disc_addr.traddr), "%s", page);
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_traddr);
+
+static ssize_t nvmet_port_addr_treq_show(struct config_item *item,
+		char *page)
+{
+	switch (to_nvmet_port(item)->disc_addr.treq) {
+	case NVMF_TREQ_NOT_SPECIFIED:
+		return sprintf(page, "not specified\n");
+	case NVMF_TREQ_REQUIRED:
+		return sprintf(page, "required\n");
+	case NVMF_TREQ_NOT_REQUIRED:
+		return sprintf(page, "not required\n");
+	default:
+		return sprintf(page, "\n");
+	}
+}
+
+static ssize_t nvmet_port_addr_treq_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+
+	if (sysfs_streq(page, "not specified")) {
+		port->disc_addr.treq = NVMF_TREQ_NOT_SPECIFIED;
+	} else if (sysfs_streq(page, "required")) {
+		port->disc_addr.treq = NVMF_TREQ_REQUIRED;
+	} else if (sysfs_streq(page, "not required")) {
+		port->disc_addr.treq = NVMF_TREQ_NOT_REQUIRED;
+	} else {
+		pr_err("Invalid value '%s' for treq\n", page);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_treq);
+
+static ssize_t nvmet_port_addr_trsvcid_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->disc_addr.trsvcid);
+}
+
+static ssize_t nvmet_port_addr_trsvcid_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (count > NVMF_TRSVCID_SIZE) {
+		pr_err("Invalid value '%s' for trsvcid\n", page);
+		return -EINVAL;
+	}
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+	return snprintf(port->disc_addr.trsvcid,
+			sizeof(port->disc_addr.trsvcid), "%s", page);
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_trsvcid);
+
+static ssize_t nvmet_port_addr_trtype_show(struct config_item *item,
+		char *page)
+{
+	switch (to_nvmet_port(item)->disc_addr.trtype) {
+	case NVMF_TRTYPE_RDMA:
+		return sprintf(page, "rdma\n");
+	case NVMF_TRTYPE_LOOP:
+		return sprintf(page, "loop\n");
+	default:
+		return sprintf(page, "\n");
+	}
+}
+
+static void nvmet_port_init_tsas_rdma(struct nvmet_port *port)
+{
+	port->disc_addr.trtype = NVMF_TRTYPE_RDMA;
+	memset(&port->disc_addr.tsas.rdma, 0, NVMF_TSAS_SIZE);
+	port->disc_addr.tsas.rdma.qptype = NVMF_RDMA_QPTYPE_CONNECTED;
+	port->disc_addr.tsas.rdma.prtype = NVMF_RDMA_PRTYPE_NOT_SPECIFIED;
+	port->disc_addr.tsas.rdma.cms = NVMF_RDMA_CMS_RDMA_CM;
+}
+
+static void nvmet_port_init_tsas_loop(struct nvmet_port *port)
+{
+	port->disc_addr.trtype = NVMF_TRTYPE_LOOP;
+	memset(&port->disc_addr.tsas, 0, NVMF_TSAS_SIZE);
+}
+
+static ssize_t nvmet_port_addr_trtype_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (port->enabled) {
+		pr_err("Cannot modify address while enabled\n");
+		pr_err("Disable the address before modifying\n");
+		return -EACCES;
+	}
+
+	if (sysfs_streq(page, "rdma")) {
+		nvmet_port_init_tsas_rdma(port);
+	} else if (sysfs_streq(page, "loop")) {
+		nvmet_port_init_tsas_loop(port);
+	} else {
+		pr_err("Invalid value '%s' for trtype\n", page);
+		return -EINVAL;
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_port_, addr_trtype);
+
+static void nvmet_port_disable(struct nvmet_port *port)
+{
+	struct nvmet_fabrics_ops *ops = port->nf_ops;
+
+	if (!ops)
+		return;
+
+	ops->remove_port(port);
+	nvmet_put_transport(port);
+	port->nf_ops = NULL;
+}
+
+static ssize_t nvmet_port_enable_show(struct config_item *item, char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	return sprintf(page, "%d\n", port->enabled);
+}
+
+static ssize_t nvmet_port_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	struct nvmet_fabrics_ops *ops;
+	bool enable;
+	int rc;
+
+	printk("Entering port enable %d\n", port->disc_addr.trtype);
+
+	if (strtobool(page, &enable))
+		return -EINVAL;
+
+	if (enable) {
+		ops = nvmet_get_transport(port);
+		if (IS_ERR(ops))
+			return PTR_ERR(ops);
+
+		port->nf_ops = ops;
+
+		rc = ops->add_port(port);
+		if (rc) {
+			nvmet_put_transport(port);
+			return rc;
+		}
+		port->enabled = true;
+	} else {
+		if (!port->nf_ops)
+			return -EINVAL;
+
+		nvmet_port_disable(port);
+	}
+
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_port_, enable);
+
+static struct configfs_attribute *nvmet_port_attrs[] = {
+	&nvmet_port_attr_addr_adrfam,
+	&nvmet_port_attr_addr_portid,
+	&nvmet_port_attr_addr_traddr,
+	&nvmet_port_attr_addr_treq,
+	&nvmet_port_attr_addr_trsvcid,
+	&nvmet_port_attr_addr_trtype,
+	&nvmet_port_attr_enable,
+	NULL,
+};
+
+/*
+ * NVMf transport port CIT
+ */
+static void nvmet_port_release(struct config_item *item)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	nvmet_port_disable(port);
+	kfree(port);
+}
+
+static struct configfs_item_operations nvmet_port_item_ops = {
+	.release	= nvmet_port_release,
+};
+
+static struct config_item_type nvmet_port_type = {
+	.ct_item_ops		= &nvmet_port_item_ops,
+	.ct_attrs		= nvmet_port_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_make_ports(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys = ports_to_subsys(&group->cg_item);
+	struct nvmet_port *port;
+
+	printk("Entering nvmet_make_port %s >>>>>>>>>>>>>>>>>>\n", name);
+
+	port = kzalloc(sizeof(*port), GFP_KERNEL);
+	if (!port)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&port->entry);
+	port->nf_subsys = subsys;
+
+	config_group_init_type_name(&port->group, name, &nvmet_port_type);
+
+	return &port->group;
+}
+
+static void nvmet_drop_ports(struct config_group *group, struct config_item *item)
+{
+	config_item_put(item);
+}
+
+static struct configfs_group_operations nvmet_ports_group_ops = {
+	.make_group		= nvmet_make_ports,
+	.drop_item		= nvmet_drop_ports,
+};
+
+static struct config_item_type nvmet_ports_type = {
+	.ct_group_ops		= &nvmet_ports_group_ops,
+	.ct_item_ops		= NULL,
+	.ct_attrs		= NULL,
+	.ct_owner		= THIS_MODULE,
+};
+
+/*
+ * NVMf namespace <-> /sys/kernel/config/target/core/ backend configfs symlink
+ */
+static int nvmet_ns_link(struct config_item *ns_ci, struct config_item *dev_ci)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(ns_ci);
+	struct se_device *dev =
+		container_of(to_config_group(dev_ci), struct se_device, dev_group);
+
+	if (dev->dev_link_magic != SE_DEV_LINK_MAGIC) {
+		pr_err("Bad dev->dev_link_magic, not a valid se_dev_ci pointer:"
+		       " %p to struct se_device: %p\n", dev_ci, dev);
+		return -EFAULT;
+	}
+
+	if (!(dev->dev_flags & DF_CONFIGURED)) {
+		pr_err("se_device not configured yet, cannot namespace link\n");
+		return -ENODEV;
+	}
+
+	if (!dev->transport->sbc_ops) {
+		pr_err("se_device does not have sbc_ops, cannot namespace link\n");
+		return -ENOSYS;
+	}
+
+	// XXX: Pass in struct se_device into nvmet_ns_enable
+	return nvmet_ns_enable(ns);
+}
+
+static int nvmet_ns_unlink(struct config_item *ns_ci, struct config_item *dev_ci)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(ns_ci);
+
+	nvmet_ns_disable(ns);
+	return 0;
+}
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
+	.allow_link		= nvmet_ns_link,
+	.drop_link		= nvmet_ns_unlink,
+};
+
+static struct config_item_type nvmet_ns_type = {
+	.ct_item_ops		= &nvmet_ns_item_ops,
+	.ct_attrs		= NULL,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_make_namespace(struct config_group *group,
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
+	pr_info("adding nsid %d to subsystem %s\n", nsid, subsys->subsysnqn);
+
+	return &ns->group;
+out:
+	return ERR_PTR(ret);
+}
+
+static void nvmet_drop_namespace(struct config_group *group, struct config_item *item)
+{
+	/*
+	 * struct nvmet_ns is released via nvmet_ns_release()
+	 */
+	config_item_put(item);
+}
+
+static struct configfs_group_operations nvmet_namespaces_group_ops = {
+	.make_group		= nvmet_make_namespace,
+	.drop_item		= nvmet_drop_namespace,
+};
+
+static struct config_item_type nvmet_namespaces_type = {
+	.ct_group_ops		= &nvmet_namespaces_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+/*
+ * Subsystem structures & folder operation functions below
+ */
+static void nvmet_subsys_release(struct config_item *item)
+{
+	struct nvmet_subsys *subsys = to_subsys(item);
+
+	nvmet_subsys_put(subsys);
+}
+
+static struct configfs_item_operations nvmet_subsys_item_ops = {
+	.release		= nvmet_subsys_release,
+};
+
+static struct config_item_type nvmet_subsys_type = {
+	.ct_item_ops		= &nvmet_subsys_item_ops,
+//	.ct_attrs		= nvmet_subsys_attrs,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group *nvmet_make_subsys(struct config_group *group,
+		const char *name)
+{
+	struct nvmet_subsys *subsys;
+
+	if (sysfs_streq(name, NVME_DISC_SUBSYS_NAME)) {
+		pr_err("can't create discovery subsystem through configfs\n");
+		return ERR_PTR(-EINVAL);
+	}
+
+	subsys = nvmet_subsys_alloc(name, NVME_NQN_NVME);
+	if (!subsys)
+		return ERR_PTR(-ENOMEM);
+
+	config_group_init_type_name(&subsys->group, name, &nvmet_subsys_type);
+
+	config_group_init_type_name(&subsys->namespaces_group,
+			"namespaces", &nvmet_namespaces_type);
+	configfs_add_default_group(&subsys->namespaces_group, &subsys->group);
+
+	config_group_init_type_name(&subsys->ports_group,
+			"ports", &nvmet_ports_type);
+	configfs_add_default_group(&subsys->ports_group, &subsys->group);
+
+#if 0
+	config_group_init_type_name(&subsys->allowed_hosts_group,
+			"allowed_hosts", &nvmet_allowed_hosts_type);
+	configfs_add_default_group(&subsys->allowed_hosts_group,
+			&subsys->group);
+#endif
+//	XXX: subsys->allow_any_host hardcoded to true
+	subsys->allow_any_host = true;
+
+	return &subsys->group;
+}
+
+static void nvmet_drop_subsys(struct config_group *group, struct config_item *item)
+{
+	/*
+	 * struct nvmet_port is releated via nvmet_subsys_release()
+	 */
+	config_item_put(item);
+}
+
+static struct configfs_group_operations nvmet_subsystems_group_ops = {
+	.make_group		= nvmet_make_subsys,
+	.drop_item		= nvmet_drop_subsys,
+};
+
+static struct config_item_type nvmet_subsystems_type = {
+	.ct_group_ops		= &nvmet_subsystems_group_ops,
+	.ct_owner		= THIS_MODULE,
+};
+
+static struct config_group nvmet_subsystems_group;
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
+	configfs_add_default_group(&nvmet_subsystems_group,
+			&nvmet_configfs_subsystem.su_group);
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
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index aebe646..d355a36 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -441,7 +441,9 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	if (!link)
 		return -ENOMEM;
 	link->subsys = subsys;
-
+#if 1
+	BUG_ON(1);
+#else
 	down_write(&nvmet_config_sem);
 	ret = -EEXIST;
 	list_for_each_entry(p, &port->subsystems, entry) {
@@ -458,6 +460,7 @@ static int nvmet_port_subsys_allow_link(struct config_item *parent,
 	list_add_tail(&link->entry, &port->subsystems);
 	nvmet_genctr++;
 	up_write(&nvmet_config_sem);
+#endif
 	return 0;
 
 out_free_link:
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9af813c..7b42d2b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -696,10 +696,8 @@ static bool __nvmet_host_allowed(struct nvmet_subsys *subsys,
 static bool nvmet_host_discovery_allowed(struct nvmet_req *req,
 		const char *hostnqn)
 {
-	struct nvmet_subsys_link *s;
-
-	list_for_each_entry(s, &req->port->subsystems, entry) {
-		if (__nvmet_host_allowed(s->subsys, hostnqn))
+	if (req->port && req->port->nf_subsys) {
+		if (__nvmet_host_allowed(req->port->nf_subsys, hostnqn))
 			return true;
 	}
 
@@ -874,8 +872,6 @@ EXPORT_SYMBOL_GPL(nvmet_ctrl_fatal_error);
 static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		const char *subsysnqn)
 {
-	struct nvmet_subsys_link *p;
-
 	if (!port)
 		return NULL;
 
@@ -886,17 +882,11 @@ static struct nvmet_subsys *nvmet_find_get_subsys(struct nvmet_port *port,
 		return nvmet_disc_subsys;
 	}
 
-	down_read(&nvmet_config_sem);
-	list_for_each_entry(p, &port->subsystems, entry) {
-		if (!strncmp(p->subsys->subsysnqn, subsysnqn,
-				NVMF_NQN_SIZE)) {
-			if (!kref_get_unless_zero(&p->subsys->ref))
-				break;
-			up_read(&nvmet_config_sem);
-			return p->subsys;
-		}
+	if (port->nf_subsys) {
+		if (kref_get_unless_zero(&port->nf_subsys->ref))
+			return port->nf_subsys;
 	}
-	up_read(&nvmet_config_sem);
+
 	return NULL;
 }
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2bf15088b..db12e06 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -98,6 +98,9 @@ struct nvmet_port {
 	struct list_head		referrals;
 	void				*priv;
 	bool				enabled;
+
+	struct nvmet_subsys		*nf_subsys;
+	struct nvmet_fabrics_ops	*nf_ops;
 };
 
 static inline struct nvmet_port *to_nvmet_port(struct config_item *item)
@@ -158,6 +161,7 @@ struct nvmet_subsys {
 	struct config_group	group;
 
 	struct config_group	namespaces_group;
+	struct config_group	ports_group;
 	struct config_group	allowed_hosts_group;
 };
 
@@ -173,6 +177,13 @@ static inline struct nvmet_subsys *namespaces_to_subsys(
 			namespaces_group);
 }
 
+static inline struct nvmet_subsys *ports_to_subsys(
+		struct config_item *item)
+{
+	return container_of(to_config_group(item), struct nvmet_subsys,
+			ports_group);
+}
+
 struct nvmet_host {
 	struct config_group	group;
 };
-- 
1.9.1
