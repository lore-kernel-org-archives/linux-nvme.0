From: sbradshaw@micron.com (Sam Bradshaw)
Date: Tue, 4 Nov 2014 16:18:06 -0800
Subject: [PATCH] NVMe: Defer namespace add_disk() until after char device
 creation
Message-ID: <54596CBE.5070501@micron.com>

In the current probe flow, each namespace gets an add_disk() then the 
char device for the controller is registered.  For misbehaving devices 
or namespace(s) that are not yet ready when add_disk() is called (eg. 
namespace accesses that return NVME_SC_NS_NOT_READY and are requeued), 
it can take time to disposition all the accesses.

This change moves add_disk() after the char device is created to give 
manageability stacks an interface to query as IO flushes out.

(I also considered deferring the nvme_ns_add() to an async context but
that requires some sort of mutex between probe and remove to handle the
surprise remove during add_disk condition and was messier than this 
patch)

Signed-off-by: Sam Bradshaw <sbradshaw at micron.com>
---
diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 00fa5d2..1d14378 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2336,6 +2336,16 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	return result;
 }
 
+static int nvme_ns_add(struct nvme_dev *dev)
+{
+	struct nvme_ns *ns;
+
+	list_for_each_entry(ns, &dev->namespaces, list)
+		add_disk(ns->disk);
+
+	return 0;
+}
+
 /*
  * Return: error value if an error occurred setting up the queues or calling
  * Identify Device.  0 if these succeeded, even if adding some of the
@@ -2398,8 +2408,6 @@ static int nvme_dev_add(struct nvme_dev *dev)
 		if (ns)
 			list_add_tail(&ns->list, &dev->namespaces);
 	}
-	list_for_each_entry(ns, &dev->namespaces, list)
-		add_disk(ns->disk);
 	res = 0;
 
  out:
@@ -2941,10 +2949,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (result)
 		goto remove;
 
+	nvme_ns_add(dev);
+
 	dev->initialized = 1;
 	return 0;
 
  remove:
+	INIT_LIST_HEAD(&dev->namespaces);
 	nvme_dev_remove(dev);
 	nvme_free_namespaces(dev);
  shutdown:
