From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Jun 2014 14:25:35 -0600
Subject: [PATCH] NVMe: Handling devices incapable of I/O
Message-ID: <1403555135-16633-1-git-send-email-keith.busch@intel.com>

This is a minor refactor for handling devices that are incapable of IO.
The driver previously used special error codes to know that IO queues
are unavailable, but we have an online queue count now.

This also fixes an issue where the driver successfully sets the queue
count, but either is unable to allocate an IO queue or the device can't
create one for some reason.

If the driver can successfully enable the device and get responses to
admin commands, the driver will bring up a character device for managment
but not create block devices.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 02351e2..522a746 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2106,7 +2106,7 @@ static int set_queue_count(struct nvme_dev *dev, int count)
 	if (status > 0) {
 		dev_err(&dev->pci_dev->dev, "Could not set queue count (%d)\n",
 									status);
-		return -EBUSY;
+		return 0;
 	}
 	return min(result & 0xffff, result >> 16) + 1;
 }
@@ -2148,7 +2148,7 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 
 	nr_io_queues = num_possible_cpus();
 	result = set_queue_count(dev, nr_io_queues);
-	if (result < 0)
+	if (result <= 0)
 		return result;
 	if (result < nr_io_queues)
 		nr_io_queues = result;
@@ -2673,7 +2673,7 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	}
 
 	result = nvme_setup_io_queues(dev);
-	if (result && result != -EBUSY)
+	if (result)
 		goto disable;
 
 	return result;
@@ -2710,9 +2710,9 @@ static int nvme_dev_resume(struct nvme_dev *dev)
 	int ret;
 
 	ret = nvme_dev_start(dev);
-	if (ret && ret != -EBUSY)
+	if (ret)
 		return ret;
-	if (ret == -EBUSY) {
+	if (dev->online_queues < 2) {
 		spin_lock(&dev_list_lock);
 		dev->reset_workfn = nvme_remove_disks;
 		queue_work(nvme_workq, &dev->reset_work);
@@ -2785,17 +2785,14 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	kref_init(&dev->kref);
 	result = nvme_dev_start(dev);
-	if (result) {
-		if (result == -EBUSY)
-			goto create_cdev;
+	if (result)
 		goto release_pools;
-	}
 
-	result = nvme_dev_add(dev);
+	if (dev->online_queues > 1)
+		result = nvme_dev_add(dev);
 	if (result)
 		goto shutdown;
 
- create_cdev:
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
-- 
1.7.10.4
