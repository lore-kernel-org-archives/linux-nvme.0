From: John.Utz@wdc.com (John Utz)
Date: Thu, 5 Sep 2013 21:23:15 +0000
Subject: [PATCH 1/9] NVMe: Merge issue on character device bring-up
In-Reply-To: <1378413915-16667-2-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
 <1378413915-16667-2-git-send-email-keith.busch@intel.com>
Message-ID: <8A51900D08212F40B3DE22453052F698EE5F28@wdscexmb02.sc.wdc.com>

What will happen when you go to create_cdev: if the character device already exists? 

Harmless? Or Not?

Just curious.

Tnx!

johnu

-----Original Message-----
From: Linux-nvme [mailto:linux-nvme-bounces@lists.infradead.org] On Behalf Of Keith Busch
Sent: Thursday, September 5, 2013 1:45 PM
To: linux-nvme at lists.infradead.org
Cc: Keith Busch
Subject: [PATCH 1/9] NVMe: Merge issue on character device bring-up

A recent patch made it possible to bring up the character handle when the device is responsive but not accepting a set-features command. Another recent patch moved the initialization that requires we move where the checks for this condition occur. This patch merges these two ideas so it works much as before.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c index 9f2b424..da52092 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -2135,10 +2135,10 @@ static int nvme_dev_start(struct nvme_dev *dev)
 	spin_unlock(&dev_list_lock);
 
 	result = nvme_setup_io_queues(dev);
-	if (result)
+	if (result && result != -EBUSY)
 		goto disable;
 
-	return 0;
+	return result;
 
  disable:
 	spin_lock(&dev_list_lock);
@@ -2177,13 +2177,17 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release;
 
 	result = nvme_dev_start(dev);
-	if (result)
+	if (result) {
+		if (result == -EBUSY)
+			goto create_cdev;
 		goto release_pools;
+	}
 
 	result = nvme_dev_add(dev);
-	if (result && result != -EBUSY)
+	if (result)
 		goto shutdown;
 
+ create_cdev:
 	scnprintf(dev->name, sizeof(dev->name), "nvme%d", dev->instance);
 	dev->miscdev.minor = MISC_DYNAMIC_MINOR;
 	dev->miscdev.parent = &pdev->dev;
--
1.7.0.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme at lists.infradead.org
http://merlin.infradead.org/mailman/listinfo/linux-nvme
