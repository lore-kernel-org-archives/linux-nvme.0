From: sujithpshankar@gmail.com (Sujith Pandel)
Date: Tue, 25 Aug 2015 10:24:39 +0530
Subject: [PATCH] NVMe:Expose model attribute in sysfs
Message-ID: <20150825045412.GA20360@localhost.localdomain>

Currently, nvme driver does not show the model attribute of disk in sysfs.
nvme_dev already has this attribute populated during nvme_dev_add().
Define the end of string for model and create the sysfs model entry.

Signed-off-by: Sujith Pandel <sujithpshankar at gmail.com>
Reviewed-by: David Milburn <dmilburn at redhat.com>
---
 drivers/block/nvme-core.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 7920c27..1098856 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2360,6 +2360,7 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	dev->vwc = ctrl->vwc;
 	memcpy(dev->serial, ctrl->sn, sizeof(ctrl->sn));
 	memcpy(dev->model, ctrl->mn, sizeof(ctrl->mn));
+	dev->model[sizeof(ctrl->mn) - 1] = '\0';
 	memcpy(dev->firmware_rev, ctrl->fr, sizeof(ctrl->fr));
 	if (ctrl->mdts)
 		dev->max_hw_sectors = 1 << (ctrl->mdts + shift - 9);
@@ -3031,6 +3032,16 @@ static ssize_t nvme_sysfs_reset(struct device *dev,
 }
 static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_sysfs_reset);
 
+/* Expose model name in sysfs */
+static ssize_t nvme_sysfs_model(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+
+	return sprintf(buf, "%s\n", ndev->model);
+}
+static DEVICE_ATTR(model, S_IRUGO, nvme_sysfs_model, NULL);
+
 static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -3081,6 +3092,12 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto put_dev;
 
+	result = device_create_file(dev->device, &dev_attr_model);
+	if (result) {
+		device_remove_file(dev->device, &dev_attr_reset_controller);
+		goto put_dev;
+	}
+
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->scan_work, nvme_dev_scan);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
@@ -3140,6 +3157,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	flush_work(&dev->reset_work);
 	flush_work(&dev->scan_work);
 	device_remove_file(dev->device, &dev_attr_reset_controller);
+	device_remove_file(dev->device, &dev_attr_model);
 	nvme_dev_remove(dev);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove_admin(dev);
-- 
2.4.3
