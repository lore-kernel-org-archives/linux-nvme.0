From: hare@suse.de (Hannes Reinecke)
Date: Fri, 10 Nov 2017 10:58:23 +0100
Subject: [PATCH 2/2] nvme: expose subsys attribute to sysfs
In-Reply-To: <1510307903-3346-1-git-send-email-hare@suse.de>
References: <1510307903-3346-1-git-send-email-hare@suse.de>
Message-ID: <1510307903-3346-3-git-send-email-hare@suse.de>

We should be exposing the subsystem attributes like 'model' and
'subsysnqn' to sysfs to allow for easier identification of the
subsystem.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 6e9effa..4e574b4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1912,6 +1912,52 @@ static struct nvme_subsystem *__nvme_find_get_subsystem(const char *subsysnqn)
 	return NULL;
 }
 
+#define SUBSYS_ATTR_RO(_name, _mode, _show)			\
+	struct device_attribute subsys_attr_##_name = __ATTR(_name, _mode, _show, NULL)
+
+static ssize_t nvme_subsys_show_nqn(struct device *dev,
+				    struct device_attribute *attr,
+				    char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n", subsys->subnqn);
+}
+static SUBSYS_ATTR_RO(subsysnqn, S_IRUGO, nvme_subsys_show_nqn);
+
+#define nvme_subsys_show_str_function(field)				\
+static ssize_t subsys_##field##_show(struct device *dev,		\
+			    struct device_attribute *attr, char *buf)	\
+{									\
+	struct nvme_subsystem *subsys =					\
+		container_of(dev, struct nvme_subsystem, dev);		\
+	return sprintf(buf, "%.*s\n",					\
+		       (int)sizeof(subsys->field), subsys->field);	\
+}									\
+static SUBSYS_ATTR_RO(field, S_IRUGO, subsys_##field##_show);
+
+nvme_subsys_show_str_function(model);
+nvme_subsys_show_str_function(serial);
+nvme_subsys_show_str_function(firmware_rev);
+
+static struct attribute *nvme_subsys_attrs[] = {
+	&subsys_attr_model.attr,
+	&subsys_attr_serial.attr,
+	&subsys_attr_firmware_rev.attr,
+	&subsys_attr_subsysnqn.attr,
+	NULL,
+};
+
+static struct attribute_group nvme_subsys_attrs_group = {
+	.attrs = nvme_subsys_attrs,
+};
+
+static const struct attribute_group *nvme_subsys_attrs_groups[] = {
+	&nvme_subsys_attrs_group,
+	NULL,
+};
+
 static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	struct nvme_subsystem *subsys, *found;
@@ -1939,6 +1985,7 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	subsys->dev.class = nvme_subsys_class;
 	subsys->dev.release = nvme_release_subsystem;
+	subsys->dev.groups = nvme_subsys_attrs_groups;
 	dev_set_name(&subsys->dev, "nvme-subsys%d", subsys->instance);
 	device_initialize(&subsys->dev);
 
-- 
1.8.5.6
