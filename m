From: keith.busch@intel.com (Keith Busch)
Date: Wed, 14 Jun 2017 12:13:58 -0400
Subject: [PATCH nvme-4.13] nvme/pci: Use saved CSTS value
Message-ID: <1497456838-11593-1-git-send-email-keith.busch@intel.com>

Don't re-read controller status when checking controller health on an
IO timeout.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
Note for Christoph: I planned to fold this into a v2 of the watchdog
timer removal, but I see that was added in commit afd83d84461808, but
under the wrong author. :)

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 788bb2c..85f9739 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1003,7 +1003,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	/*
 	 * Reset immediately if the controller is failed
 	 */
-	if (nvme_should_reset(dev, readl(dev->bar + NVME_REG_CSTS))) {
+	if (nvme_should_reset(dev, csts)) {
 		nvme_warn_reset(dev, csts);
 		nvme_dev_disable(dev, false);
 		nvme_reset(dev);
-- 
2.5.5
