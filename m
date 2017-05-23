From: rakesh@tuxera.com (Rakesh Pandit)
Date: Wed, 24 May 2017 01:16:41 +0300
Subject: [PATCH 2/2] nvme: fix status message while removing controller
Message-ID: <20170523221639.GA23955@dhcp-216.srv.tuxera.com>

Instead of -ENODEV, -EBUSY seems more appropriate if device state
change fails inside nvme_reset_work.  This should ideally only fail if
device is already undergoing deletion or is dead.

Signed-off-by: Rakesh Pandit <rakesh at tuxera.com>
---
 drivers/nvme/host/pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 177e5ee..04fe52c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1910,8 +1910,10 @@ static void nvme_reset_work(struct work_struct *work)
 	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
 		nvme_dev_disable(dev, false);
 
-	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_RESETTING)) {
+		result = -EBUSY;
 		goto out;
+	}
 
 	result = nvme_pci_enable(dev);
 	if (result)
-- 
2.5.5
