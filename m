From: hch@lst.de (Christoph Hellwig)
Date: Fri, 18 May 2018 18:56:24 +0200
Subject: [PATCH] PCI/sysfs: do not allow enabling/disabling a device with a
 driver
Message-ID: <20180518165624.13993-1-hch@lst.de>

Manpulating the enable_cnt behind the back of the driver will wreck
complete havok with the kernel state, so disallow it.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/pci/pci-sysfs.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 366d93af051d..788a200fb2dc 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -288,13 +288,16 @@ static ssize_t enable_store(struct device *dev, struct device_attribute *attr,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	if (!val) {
-		if (pci_is_enabled(pdev))
-			pci_disable_device(pdev);
-		else
-			result = -EIO;
-	} else
+	device_lock(dev);
+	if (dev->driver)
+		result = -EBUSY;
+	else if (val)
 		result = pci_enable_device(pdev);
+	else if (pci_is_enabled(pdev))
+		pci_disable_device(pdev);
+	else
+		result = -EIO;
+	device_unlock(dev);
 
 	return result < 0 ? result : count;
 }
-- 
2.17.0
