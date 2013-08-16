From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:29 -0600
Subject: [PATCHv2 2/5] NVMe: User initiated controller reset
In-Reply-To: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
References: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
Message-ID: <1376690432-9775-3-git-send-email-keith.busch@intel.com>

Creates a sysfs entry for each nvme controller that when written to
initiates a controller reset. This may be done by a user if they need
to reset the controller for any reason. For example, it may be required
as part of an firmware activate procedure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
v1->v2:

Fix cleanup on device_create_file failure.

 drivers/block/nvme-core.c |   20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 5713dd2..c0f2533 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2171,6 +2171,17 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
 	nvme_dev_reset(dev);
 }
 
+static ssize_t nvme_reset(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dev  *pdev = container_of(dev, struct pci_dev, dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+
+	nvme_dev_reset(ndev);
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_reset);
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2207,6 +2218,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto shutdown;
 
+	result = device_create_file(&pdev->dev, &dev_attr_reset_controller);
+	if (result)
+		goto remove;
+
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
@@ -2214,11 +2229,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto remove;
+		goto del_sysfs;
 
 	kref_init(&dev->kref);
 	return 0;
 
+ del_sysfs:
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
  remove:
 	nvme_dev_remove(dev);
  shutdown:
@@ -2238,6 +2255,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
 	misc_deregister(&dev->miscdev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.10.4
