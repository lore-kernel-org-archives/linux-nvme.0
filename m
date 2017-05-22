From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 May 2017 18:02:17 +0200
Subject: [PATCH] nvme: pci: Fix NULL dereference when resetting NVMe SSD
In-Reply-To: <20170522153829.GA17980@dhcp-216.srv.tuxera.com>
References: <20170520175952.GA11258@dhcp-216.srv.tuxera.com>
 <20170521061736.GA12287@lst.de>
 <20170522153829.GA17980@dhcp-216.srv.tuxera.com>
Message-ID: <20170522160217.GA26104@lst.de>

On Mon, May 22, 2017@06:38:29PM +0300, Rakesh Pandit wrote:
> Just got to use the using the test box again and you are right that
> nvme_remove_dead_ctrl_work is getting called just before the NULL
> pointer dereference.
> 
> Here call trace to nvme_timeout which results in eventually call to
> nvme_reset when it wants to reset the controller (which races with
> ->reset_notify from PCI layer):

Does the patch below fix the issue for you?

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5bba8e6..f8c15e2719c4 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4275,11 +4275,13 @@ int pci_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
+	device_lock(&dev->dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = pci_dev_reset(dev, 0);
+	rc = __pci_dev_reset(dev, 0);
 
 	pci_dev_restore(dev);
+	device_unlock(&dev->dev);
 
 	return rc;
 }
