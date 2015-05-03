From: David.Sariel@pmcs.com (David Sariel)
Date: Sun, 3 May 2015 18:26:05 +0000
Subject: [PATCH] NVMe: Add reset controller sysfs entry
In-Reply-To: <BN1PR0401MB0931F0B9E7345CA59544CDFBF2FE0@BN1PR0401MB0931.namprd04.prod.outlook.com>
References: <1428096023-1887-1-git-send-email-keith.busch@intel.com>
 <BN1PR0401MB0931F0B9E7345CA59544CDFBF2FE0@BN1PR0401MB0931.namprd04.prod.outlook.com>
Message-ID: <31FEE40556302F408590926A3C4AC65FED561E45@BBYEXM01.pmc-sierra.internal>

Hi Keith, Brandon,
It took me a while to get hands on it. Attaching the patch according to Keith's remarks:

diff -uprN a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
--- a/drivers/block/nvme-core.c	2014-09-06 02:37:11.000000000 +0300
+++ b/drivers/block/nvme-core.c	2015-05-03 21:05:12.000000000 +0300
@@ -2627,6 +2627,18 @@ static long nvme_dev_ioctl(struct file *
 	switch (cmd) {
 	case NVME_IOCTL_ADMIN_CMD:
 		return nvme_user_admin_cmd(dev, (void __user *)arg);
+	case NVME_IOCTL_RESET:
+        if(work_busy(&dev->reset_work) )
+        	return -EBUSY;
+
+        dev_warn(&dev->pci_dev->dev, "resetting controller\n");
+        dev->reset_workfn = nvme_reset_failed_dev;
+        queue_work(nvme_workq, &dev->reset_work);
+
+        /* Wait for a work to finish executing the last queueing instance */
+        flush_work(&dev->reset_work);
+
+		return 0;
 	default:
 		return -ENOTTY;
 	}
diff -uprN a/include/uapi/linux/nvme.h b/include/uapi/linux/nvme.h
--- a/include/uapi/linux/nvme.h	2014-09-06 02:37:11.000000000 +0300
+++ b/include/uapi/linux/nvme.h	2015-05-03 21:05:30.000000000 +0300
@@ -513,5 +513,7 @@ struct nvme_admin_cmd {
 #define NVME_IOCTL_ID		_IO('N', 0x40)
 #define NVME_IOCTL_ADMIN_CMD	_IOWR('N', 0x41, struct nvme_admin_cmd)
 #define NVME_IOCTL_SUBMIT_IO	_IOW('N', 0x42, struct nvme_user_io)
+/* 0x43 is used by nvme-cli */
+#define NVME_IOCTL_RESET  _IO('N', 0x44)
 
 #endif /* _UAPI_LINUX_NVME_H */


Although the use case is for the reset is for pre 3.15 kernels, I guess that the patch should be applied to the latest kernel. Am I right?
Thanks
David


-----Original Message-----
From: Brandon Schulz [mailto:brandon.schulz@hgst.com] 
Sent: Monday, April 06, 2015 7:56 PM
To: Keith Busch; linux-nvme at lists.infradead.org; David Sariel
Cc: David Darrington
Subject: RE: [PATCH] NVMe: Add reset controller sysfs entry

Keith -

Thanks for submitting this patch.  I think this sysfs mechanism is a good add.  I talked to Dave Darrington about getting it applied to our internal tree and let you know if he has any feedback as well.

I'm also interested in eventually providing the IOCTL you mentioned, because I think they have different use-cases.

David Sariel - Are you planning to revise the patch posted earlier for this, or should I talk to our team about that as well?

Brandon

-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Friday, April 3, 2015 4:20 PM
To: linux-nvme at lists.infradead.org
Cc: Keith Busch; Brandon Schulz; David Sariel
Subject: [PATCH] NVMe: Add reset controller sysfs entry

We need the ability to perform an nvme controller reset as discussed on the mailing list thread:

  http://lists.infradead.org/pipermail/linux-nvme/2015-March/001585.html

This adds a sysfs entry that when written to will reset perform an NVMe controller reset if the controller was successfully initialized in the first place.

This also adds locking around resetting the device in the async probe method so the driver can't schedule two resets.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Brandon Schultz <brandon.schulz at hgst.com>
Cc: David Sariel <david.sariel at pmcs.com>
---
The other proposals were to use an IOCTL, and I'm still open to Ack if someone wants to submit that patch. This patch just makes it possible to do with sysfs since I'm in a minority that prefers to script these things rather than write a program to issue ioctls.

 drivers/block/nvme-core.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index 0d72ff2..07b92f4 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2908,6 +2908,26 @@ static void nvme_reset_workfn(struct work_struct *work)
 	dev->reset_workfn(work);
 }
 
+static ssize_t nvme_reset(struct device *dev, struct device_attribute *attr,
+                                               const char *buf, size_t 
+count) {
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
 static void nvme_async_probe(struct work_struct *work);  static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)  { @@ -2952,12 +2972,20 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 
 static void nvme_reset_notify(struct pci_dev *pdev, bool prepare) @@ -3019,6 +3049,7 @@ static void nvme_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 	flush_work(&dev->probe_work);
 	flush_work(&dev->reset_work);
+	device_remove_file(dev->device, &dev_attr_reset_controller);
 	nvme_dev_shutdown(dev);
 	nvme_dev_remove(dev);
 	nvme_dev_remove_admin(dev);
--
1.7.10.4
