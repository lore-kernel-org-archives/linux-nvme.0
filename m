From: keith.busch@intel.com (Keith Busch)
Date: Fri, 18 May 2018 10:38:23 -0600
Subject: [PATCH 6/6] nvme-pci: Rate limit the nvme timeout warnings
In-Reply-To: <20180518163823.27820-1-keith.busch@intel.com>
References: <20180518163823.27820-1-keith.busch@intel.com>
Message-ID: <20180518163823.27820-6-keith.busch@intel.com>

The block layer's timeout handling currently refuses to let the driver
complete commands outside the timeout callback once blk-mq decides they've
expired. If a device breaks, this could potentially create many thousands
of timed out commands. There's nothing of value to be gleaned from
observing each of those messages, so this patch adds a ratelimit on them.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ddfeb186d129..e4b91c246e36 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1251,7 +1251,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
  	 * returned to the driver, or if this is the admin queue.
 	 */
 	if (!nvmeq->qid || iod->aborted) {
-		dev_warn(dev->ctrl.device,
+		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O %d QID %d timeout, reset controller\n",
 			 req->tag, nvmeq->qid);
 		nvme_dev_disable(dev, false);
-- 
2.14.3
