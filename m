From: keith.busch@intel.com (Keith Busch)
Date: Mon, 23 Mar 2015 09:32:37 -0600
Subject: [PATCH for-4.0-rc6] NVMe: Initialize device list head before starting
Message-ID: <1427124757-30384-1-git-send-email-keith.busch@intel.com>

Driver recovery requires the device's list node to have been initialized.

Fixes: https://lkml.org/lkml/2015/3/22/262

Reported-by: Steven Noonan <steven at uplinklabs.net>
Signed-off-by: Keith Busch <keith.busch at intel.com>
Cc: Matthew Wilcox <willy at linux.intel.com>
Cc: Jens Axboe <axboe at fb.com>
---
 drivers/block/nvme-core.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index ceb32dd..e23be20 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -3003,6 +3003,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 	get_device(dev->device);
 
+	INIT_LIST_HEAD(&dev->node);
 	INIT_WORK(&dev->probe_work, nvme_async_probe);
 	schedule_work(&dev->probe_work);
 	return 0;
-- 
1.7.10.4
