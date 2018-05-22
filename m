From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:31 -0600
Subject: [PATCHv2 7/8] nvme-pci: End IO requests in CONNECTING state
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-8-keith.busch@intel.com>

The patch is catching a possibility the unlikely block layer doesn't
complete a request the driver completed during the connecting state of
a controller reset.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index d6576934476a..84eeac683322 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1234,6 +1234,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
