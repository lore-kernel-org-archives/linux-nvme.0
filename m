From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:56 -0600
Subject: [PATCHv3 5/9] nvme-pci: End IO requests in CONNECTING state
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-6-keith.busch@intel.com>

IO is always quiesced in the CONNECTING state, so any any timeout for an
IO command had already been completed.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6be88f662e7d..54e22b964385 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1227,6 +1227,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 */
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_CONNECTING:
+		/*
+		 * IO is never dispatched from the connecting state. If an IO
+		 * queue timed out here, the block layer missed the completion
+		 * the driver already requested, so return handled.
+		 */
+		if (nvmeq->qid)
+			return BLK_EH_HANDLED;
+		/* FALLTHRU */
 	case NVME_CTRL_RESETTING:
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
-- 
2.14.3
