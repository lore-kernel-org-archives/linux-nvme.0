From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Thu,  8 Mar 2018 14:19:30 +0800
Subject: [PATCH V4 4/5] nvme-pci: discard wait timeout when delete cq/sq
In-Reply-To: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1520489971-31174-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1520489971-31174-5-git-send-email-jianchao.w.wang@oracle.com>

nvme_disable_io_queues could be wakeup by both request completion
and wait timeout path. If delete cq/sq command expires, the
nvme_disable_io_queues will be wakeup, return, even get to
nvme_reset_work, while the timeout path is still ongoing. The disable
and initialization procedure may run in parallel.

Use wait_for_completion instead of the timeout one here. The timeout
path is reliable now and will complete the request to wakeup it.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce09057..6c7c19cb 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2062,7 +2062,6 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int pass, queues = dev->online_queues - 1;
-	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
 	for (pass = 0; pass < 2; pass++) {
@@ -2070,15 +2069,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
 		reinit_completion(&dev->ioq_wait);
  retry:
-		timeout = ADMIN_TIMEOUT;
 		for (; i > 0; i--, sent++)
 			if (nvme_delete_queue(&dev->queues[i], opcode))
 				break;
 
 		while (sent--) {
-			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
-			if (timeout == 0)
-				return;
+			wait_for_completion(&dev->ioq_wait);
 			if (i)
 				goto retry;
 		}
-- 
2.7.4
