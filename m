From: keith.busch@intel.com (Keith Busch)
Date: Wed,  7 Aug 2013 14:44:47 -0600
Subject: [PATCH 2/2] NVMe: User initiated controller reset
In-Reply-To: <1375908287-18884-1-git-send-email-keith.busch@intel.com>
References: <1375908287-18884-1-git-send-email-keith.busch@intel.com>
Message-ID: <1375908287-18884-3-git-send-email-keith.busch@intel.com>

Creates a sysfs entry for each nvme controller that when written to
initiates a controller reset. This may be done by a user if they need
to reset the controller for any reason. For example, it may be required
as part of an firmware activate procedure.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index f401e2b..ee29e2e 100644
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
@@ -2217,6 +2228,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto remove;
 
 	kref_init(&dev->kref);
+	device_create_file(&pdev->dev, &dev_attr_reset_controller);
 	return 0;
 
  remove:
@@ -2238,6 +2250,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 static void nvme_remove(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	device_remove_file(&pdev->dev, &dev_attr_reset_controller);
 	misc_deregister(&dev->miscdev);
 	kref_put(&dev->kref, nvme_free_dev);
 }
-- 
1.7.10.4
