From: hch@lst.de (Christoph Hellwig)
Date: Tue, 23 May 2017 07:42:02 +0200
Subject: [PATCH] PCI: ensure the PCI device is locked over ->reset_notify calls
In-Reply-To: <20170523054202.7985-1-hch@lst.de>
References: <20170523054202.7985-1-hch@lst.de>
Message-ID: <20170523054202.7985-2-hch@lst.de>

Without this ->notify_reset instance may race with ->remove calls,
which can be easily triggered in NVMe.

Reported-by: Rakesh Pandit <rakesh at tuxera.com>
Tested-by: Rakesh Pandit <rakesh at tuxera.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/pci/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index b01bd5bba8e6..b61ad77dc322 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4275,11 +4275,13 @@ int pci_reset_function(struct pci_dev *dev)
 	if (rc)
 		return rc;
 
+	pci_dev_lock(dev);
 	pci_dev_save_and_disable(dev);
 
-	rc = pci_dev_reset(dev, 0);
+	rc = __pci_dev_reset(dev, 0);
 
 	pci_dev_restore(dev);
+	pci_dev_unlock(dev);
 
 	return rc;
 }
-- 
2.11.0
