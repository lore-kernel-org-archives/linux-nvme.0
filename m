From: keith.busch@intel.com (Keith Busch)
Date: Tue, 12 Jan 2016 15:09:31 -0700
Subject: [PATCH RESEND] NVMe: Export NVMe attributes to sysfs group
Message-ID: <1452636571-309-1-git-send-email-keith.busch@intel.com>

Adds all controller information to attribute list exposed to sysfs, and
appends the reset_controller attribute to it. The nvme device is created
with this attribute list, so driver no long manages its attributes.

Reported-by: Sujith Pandel <sujithpshankar at gmail.com>
Cc: Sujith Pandel <sujithpshankar@ gmail.com>
Cc: David Milburn <dmilburn at redhat.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
I think this was meant to be picked up. At least the namespace attributes
were that came right after this. This patch respins on top of that one
so it applies cleanly.

 drivers/nvme/host/core.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2713005..70e6d28 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1022,6 +1022,36 @@ static const struct attribute_group nvme_ns_attr_group = {
 	.is_visible	= nvme_attrs_are_visible,
 };
 
+#define nvme_show_function(field)						\
+static ssize_t  field##_show(struct device *dev,				\
+			    struct device_attribute *attr, char *buf)		\
+{										\
+        struct nvme_ctrl *ctrl = dev_get_drvdata(dev);				\
+        return sprintf(buf, "%.*s\n", (int)sizeof(ctrl->field), ctrl->field);	\
+}										\
+static DEVICE_ATTR(field, S_IRUGO, field##_show, NULL);
+
+nvme_show_function(model);
+nvme_show_function(serial);
+nvme_show_function(firmware_rev);
+
+static struct attribute *nvme_dev_attrs[] = {
+	&dev_attr_reset_controller.attr,
+	&dev_attr_model.attr,
+	&dev_attr_serial.attr,
+	&dev_attr_firmware_rev.attr,
+	NULL
+};
+
+static struct attribute_group nvme_dev_attrs_group = {
+	.attrs = nvme_dev_attrs,
+};
+
+static const struct attribute_group *nvme_dev_attr_groups[] = {
+	&nvme_dev_attrs_group,
+	NULL,
+};
+
 static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 {
 	struct nvme_ns *nsa = container_of(a, struct nvme_ns, list);
@@ -1256,7 +1286,6 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
  {
-	device_remove_file(ctrl->device, &dev_attr_reset_controller);
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
@@ -1299,9 +1328,10 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out;
 
-	ctrl->device = device_create(nvme_class, ctrl->dev,
+	ctrl->device = device_create_with_groups(nvme_class, ctrl->dev,
 				MKDEV(nvme_char_major, ctrl->instance),
-				dev, "nvme%d", ctrl->instance);
+				dev, nvme_dev_attr_groups,
+				"nvme%d", ctrl->instance);
 	if (IS_ERR(ctrl->device)) {
 		ret = PTR_ERR(ctrl->device);
 		goto out_release_instance;
@@ -1309,19 +1339,11 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	get_device(ctrl->device);
 	dev_set_drvdata(ctrl->device, ctrl);
 
-	ret = device_create_file(ctrl->device, &dev_attr_reset_controller);
-	if (ret)
-		goto out_put_device;
-
 	spin_lock(&dev_list_lock);
 	list_add_tail(&ctrl->node, &nvme_ctrl_list);
 	spin_unlock(&dev_list_lock);
 
 	return 0;
-
-out_put_device:
-	put_device(ctrl->device);
-	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 out_release_instance:
 	nvme_release_instance(ctrl);
 out:
-- 
2.6.2.307.g37023ba
