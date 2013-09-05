From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:12 -0600
Subject: [PATCH 6/9] NVMe: User initiated controller reset
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-7-git-send-email-keith.busch@intel.com>

Creates a sysfs entry for each nvme controller that when written to
initiates a controller reset. This may be done by a root user if they
need to reset the controller for any reason. For example, it may be
required as part of an firmware activate procedure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   19 ++++++++++++++++++-
 1 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e179614..c400c0a 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2267,6 +2267,16 @@ static void nvme_reset_failed_dev(struct work_struct *ws)
 	nvme_dev_reset(dev);
 }
 
+static ssize_t nvme_reset(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct pci_dev  *pdev = container_of(dev, struct pci_dev, dev);
+	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	nvme_dev_reset(ndev);
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_reset);
+
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	int result = -ENOMEM;
@@ -2307,6 +2317,10 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto shutdown;
 
  create_cdev:
+	result = device_create_file(&pdev->dev, &dev_attr_reset_controller);
+	if (result)
+		goto remove;
+
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
@@ -2314,12 +2328,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	dev->miscdev.fops = &nvme_dev_fops;
 	result = misc_register(&dev->miscdev);
 	if (result)
-		goto remove;
+		goto del_sysfs;
 
 	kref_init(&dev->kref);
 	dev->is_initialised = 1;
 	return 0;
 
+ del_sysfs:
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
  remove:
 	nvme_dev_remove(dev);
  shutdown:
@@ -2339,6 +2355,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
 	misc_deregister(&dev->miscdev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.0.4
