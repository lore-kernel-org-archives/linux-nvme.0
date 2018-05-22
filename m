From: keith.busch@intel.com (Keith Busch)
Date: Tue, 22 May 2018 16:03:30 -0600
Subject: [PATCHv2 6/8] nvme-pci: Rate limit the nvme timeout warnings
In-Reply-To: <20180522220332.9244-1-keith.busch@intel.com>
References: <20180522220332.9244-1-keith.busch@intel.com>
Message-ID: <20180522220332.9244-7-keith.busch@intel.com>

The block layer's timeout handling currently doesn't let the driver
complete commands outside the timeout callback once blk-mq decides they've
expired. If a device breaks, this could potentially create many thousands
of timed out commands. There's nothing of value to be gleaned from
observing each of those messages, so this patch adds a ratelimit on them.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index dfaf22ff6328..d6576934476a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1235,7 +1235,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
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
