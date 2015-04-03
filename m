From: keith.busch@intel.com (Keith Busch)
Date: Fri,  3 Apr 2015 15:20:23 -0600
Subject: [PATCH] NVMe: Add reset controller sysfs entry
Message-ID: <1428096023-1887-1-git-send-email-keith.busch@intel.com>

We need the ability to perform an nvme controller reset as discussed on
the mailing list thread:

  http://lists.infradead.org/pipermail/linux-nvme/2015-March/001585.html

This adds a sysfs entry that when written to will reset perform an NVMe
controller reset if the controller was successfully initialized in the
first place.

This also adds locking around resetting the device in the async probe
method so the driver can't schedule two resets.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Brandon Schultz <brandon.schulz at hgst.com>
Cc: David Sariel <david.sariel at pmcs.com>
---
The other proposals were to use an IOCTL, and I'm still open to Ack if
someone wants to submit that patch. This patch just makes it possible
to do with sysfs since I'm in a minority that prefers to script these
things rather than write a program to issue ioctls.

 drivers/block/nvme-core.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 0d72ff2..07b92f4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2908,6 +2908,26 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+static ssize_t nvme_reset(struct device *dev, struct device_attribute *attr,
+                                               const char *buf, size_t count)
+{
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
+
+	if (!ndev->admin_q || blk_queue_dying(ndev->admin_q))
+		return -ENODEV;
+
+	spin_lock(&dev_list_lock);
+	if (!work_pending(&ndev->reset_work)) {
+		ndev->reset_workfn = nvme_reset_failed_dev;
+		queue_work(nvme_workq, &ndev->reset_work);
+	}
+	spin_unlock(&dev_list_lock);
+
+	flush_work(&ndev->reset_work);
+	return count;
+}
+static DEVICE_ATTR(reset_controller, S_IWUSR, NULL, nvme_reset);
+
 static void nvme_async_probe(struct work_struct *work);
 static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
@@ -2952,12 +2972,20 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 	get_device(dev->device);
+	dev_set_drvdata(dev->device, dev);
+
+	result = device_create_file(dev->device, &dev_attr_reset_controller);
+	if (result)
+		goto put_dev;
 
 	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
 	schedule_work(&dev->probe_work);
 	return 0;
 
+ put_dev:
+	device_destroy(nvme_class, MKDEV(nvme_char_major, dev->instance));
+	put_device(dev->device);
  release_pools:
 	nvme_release_prp_pools(dev);
  release:
@@ -2986,10 +3014,12 @@ static void nvme_async_probe(struct work_struct *work)
 		goto reset;
 	return;
  reset:
+	spin_lock(&dev_list_lock);
 	if (!work_busy(&dev->reset_work)) {
 		dev->reset_workfn = nvme_reset_failed_dev;
 		queue_work(nvme_workq, &dev->reset_work);
 	}
+	spin_unlock(&dev_list_lock);
 }
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare)
@@ -3019,6 +3049,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
+	device_remove_file(dev->device, &dev_attr_reset_controller);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
-- 
1.7.10.4
