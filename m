From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Wed, 9 Sep 2015 11:57:36 +0530
Subject: [PATCH v2] NVMe:Expose model attribute in sysfs
Message-ID: <20150909062713.GA14279@localhost.localdomain>

nvme driver does not show the model attribute of disk in sysfs.
nvme_dev already has this attribute populated during nvme_dev_add().
Group model and other the device attributes as an attribute group
and create sysfs files for the group using sysfs_create_group().

Signed-off-by: Sujith Pandel <sujithpshankar at gmail.com>
Reviewed-by: David Milburn <dmilburn at redhat.com>
---
Changes since v1:
- Remove the model string termination in nvme_dev_add().
- Simplify the maintenance of sysfs attributes using groups.
- Use macro to show the string attributes.
- Remove the addition of a new goto label.

 drivers/block/nvme-core.c | 46 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b97fc3f..fda0a6a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3151,6 +3151,48 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+#define nvme_string_attr(name)                                             \
+static ssize_t  name##_show(struct device *dev,                            \
+			    struct device_attribute *attr, char *buf)	    \
+{                                                                          \
+        struct nvme_dev *ndev = dev_get_drvdata(dev);                      \
+        return sprintf(buf, "%.*s\n", (int)sizeof(ndev->name), ndev->name);\
+}                                                                          \
+static DEVICE_ATTR(name, S_IRUGO, name##_show, NULL);
+
+/*
+ * Device string attributes.
+ * Can add serial and firmware_rev attributes here.
+ */
+nvme_string_attr(model);
+
+static struct attribute *nvme_dev_attrs[] = {
+	&dev_attr_reset_controller.attr,
+	&dev_attr_model.attr,
+	NULL
+};
+
+static struct attribute_group nvme_dev_attrs_group = {
+	.attrs = nvme_dev_attrs,
+};
+
+/*
+ * Remove sysfs entries for device attributes.
+ */
+void nvme_remove_sysfs_files(struct device *dev)
+{
+	sysfs_remove_group(&dev->kobj, &nvme_dev_attrs_group);
+}
+
+/*
+ * Create sysfs entries for device attributes.
+ * Returns 0 on success.
+ */
+int nvme_create_sysfs_files(struct device *dev)
+{
+	return sysfs_create_group(&dev->kobj, &nvme_dev_attrs_group);
+}
+
 static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -3197,7 +3239,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	get_device(dev->device);
 	dev_set_drvdata(dev->device, dev);
 
-	result = device_create_file(dev->device, &dev_attr_reset_controller);
+	result = nvme_create_sysfs_files(dev->device);
 	if (result)
 		goto put_dev;
 
@@ -3259,7 +3301,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
-	device_remove_file(dev->device, &dev_attr_reset_controller);
+	nvme_remove_sysfs_files(dev->device);
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
-- 
2.4.3
