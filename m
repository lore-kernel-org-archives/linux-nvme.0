From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 May 2019 20:21:07 -0700
Subject: [RFC PATCH 2/4] nvmet: allow user to specify ioprioty from cfgfs
In-Reply-To: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
References: <20190516032109.13048-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20190516032109.13048-4-chaitanya.kulkarni@wdc.com>

This patch adds the configfs interface to initialize the iopriority
class and values from the user for each port. By default we use
NONE iopriority class.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/configfs.c | 76 ++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 08dd5af357f7..51548b0f605e 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -11,6 +11,7 @@
 #include <linux/ctype.h>
 #include <linux/pci.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/ioprio.h>
 
 #include "nvmet.h"
 
@@ -143,6 +144,74 @@ static ssize_t nvmet_addr_traddr_store(struct config_item *item,
 
 CONFIGFS_ATTR(nvmet_, addr_traddr);
 
+static ssize_t nvmet_ioprio_class_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_port(item)->ioprio_class);
+}
+
+static ssize_t nvmet_ioprio_class_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 class;
+
+	if (kstrtou8(page, 0, &class))
+		return -EINVAL;
+
+	if (class > 3) {
+		pr_err("class %u is out of range ioprio_class [0-3]\n", class);
+		port->ioprio_class = 0;
+		port->ioprio_value = 0;
+		return -EINVAL;
+	}
+	/*
+	 * Right now update ioprio value everytime class or value is
+	 * initialized.
+	 *
+	 * XXX: add lock here.
+	 */
+	port->ioprio = IOPRIO_PRIO_VALUE(port->ioprio_class,
+			port->ioprio_value);
+	port->ioprio_class = class;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, ioprio_class);
+
+static ssize_t nvmet_ioprio_value_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_port(item)->ioprio_value);
+}
+
+static ssize_t nvmet_ioprio_value_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	u8 value;
+
+	if (kstrtou8(page, 0, &value))
+		return -EINVAL;
+
+	if (value > 7) {
+		pr_err("value %u is out of range ioprio_value [0-7]\n", value);
+		port->ioprio_class = 0;
+		port->ioprio_value = 0;
+		return -EINVAL;
+	}
+	/*
+	 * Right now update ioprio value everytime class or value is
+	 * initialized.
+	 *
+	 * XXX: add lock here.
+	 */
+	port->ioprio = IOPRIO_PRIO_VALUE(port->ioprio_class,
+			port->ioprio_value);
+	port->ioprio_value = value;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, ioprio_value);
+
 static ssize_t nvmet_addr_treq_show(struct config_item *item,
 		char *page)
 {
@@ -1158,6 +1227,8 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_addr_trsvcid,
 	&nvmet_attr_addr_trtype,
 	&nvmet_attr_param_inline_data_size,
+	&nvmet_attr_ioprio_class,
+	&nvmet_attr_ioprio_value,
 	NULL,
 };
 
@@ -1206,6 +1277,11 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	INIT_LIST_HEAD(&port->referrals);
 	port->inline_data_size = -1;	/* < 0 == let the transport choose */
 
+	port->ioprio_class = IOPRIO_CLASS_NONE;
+	port->ioprio_value = 0;
+	port->ioprio = IOPRIO_PRIO_VALUE(port->ioprio_class,
+			port->ioprio_value);
+
 	port->disc_addr.portid = cpu_to_le16(portid);
 	port->disc_addr.treq = NVMF_TREQ_DISABLE_SQFLOW;
 	config_group_init_type_name(&port->group, name, &nvmet_port_type);
-- 
2.17.0
