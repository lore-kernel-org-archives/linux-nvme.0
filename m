From: keith.busch@intel.com (Keith Busch)
Date: Tue, 31 May 2016 13:49:08 -0600
Subject: [PATCH 2/2] NVMe: Synchronize resets with scan work
In-Reply-To: <1464724148-11169-1-git-send-email-keith.busch@intel.com>
References: <1464724148-11169-1-git-send-email-keith.busch@intel.com>
Message-ID: <1464724148-11169-2-git-send-email-keith.busch@intel.com>

A user could continuously reset a controller, which aborts active
commands. If the controller is currently scanning live namespaces, the
aborted commands could cause namespaces to fail. This patch synchronizes
the reset on a live controller with namespace scanning work to prevent
this from occuring.

Reported-by: Ming Lin <mlin at kernel.org>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dfb8f2a..7c4e194 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1781,10 +1781,13 @@ static void nvme_reset_work(struct work_struct *work)
 
 	/*
 	 * If we're called to reset a live controller first shut it down before
-	 * moving on.
+	 * moving on. Synchronize with controller scanning so a user can't
+	 * interrupt and fail active namespace validation.
 	 */
-	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE)
+	if (dev->ctrl.ctrl_config & NVME_CC_ENABLE) {
+		flush_work(&dev->ctrl.scan_work);
 		nvme_dev_disable(dev, false);
+	}
 
 	result = nvme_pci_enable(dev);
 	if (result)
-- 
2.7.2
