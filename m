From: keith.busch@intel.com (Keith Busch)
Date: Thu, 24 May 2018 14:34:55 -0600
Subject: [PATCHv3 4/9] nvme-pci: Rate limit the nvme timeout warnings
In-Reply-To: <20180524203500.14081-1-keith.busch@intel.com>
References: <20180524203500.14081-1-keith.busch@intel.com>
Message-ID: <20180524203500.14081-5-keith.busch@intel.com>

The block layer's timeout handling currently prevents drivers from
completing commands outside the timeout callback once blk-mq decides
they've expired. If a device breaks, this could potentially create many
thousands of timed out commands. There's nothing of value to be gleaned
from observing each of those messages, so this patch adds a rate limit
on them.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 243534139df7..6be88f662e7d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1228,7 +1228,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	switch (dev->ctrl.state) {
 	case NVME_CTRL_CONNECTING:
 	case NVME_CTRL_RESETTING:
-		dev_warn(dev->ctrl.device,
+		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, disable controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-- 
2.14.3
