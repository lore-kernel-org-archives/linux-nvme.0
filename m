From: keith.busch@intel.com (Keith Busch)
Date: Fri, 24 May 2019 14:20:34 -0600
Subject: [PATCH 1/3] nvme-pci: reset timeout when processing is paused
In-Reply-To: <20190524202036.17265-1-keith.busch@intel.com>
References: <20190524202036.17265-1-keith.busch@intel.com>
Message-ID: <20190524202036.17265-2-keith.busch@intel.com>

From: Keith Busch <kbusch@kernel.org>

Do not escalate request timeout handling if the controller has
temporary paused command processing. We do not expect requests to
complete during this transient state, so just reset the timer.

Signed-off-by: Keith Busch <kbusch at kernel.org>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f562154551ce..101e20522374 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1263,7 +1263,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (pci_channel_offline(to_pci_dev(dev->dev)) || (csts & NVME_CSTS_PP))
 		return BLK_EH_RESET_TIMER;
 
 	/*
-- 
2.14.4
