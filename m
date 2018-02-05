From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon,  5 Feb 2018 17:20:15 +0800
Subject: [PATCH V2 6/6] nvme-pci: discard wait timeout when delete cq/sq
In-Reply-To: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1517822415-11710-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1517822415-11710-7-git-send-email-jianchao.w.wang@oracle.com>

Currently, nvme_disable_io_queues could be wakeup by both request
completion and wait timeout path. This is unnecessary and could
introduce race between nvme_dev_disable and request timeout path.
When delete cq/sq command expires, the nvme_disable_io_queues will
also be wakeup and return to nvme_dev_disable, then handle the
outstanding requests. This will race with the request timeout path.

To fix it, just use wait_for_completion instead of the timeout one.
The request timeout path will wakeup it.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/pci.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 43033fc..f3262cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2050,7 +2050,6 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 static void nvme_disable_io_queues(struct nvme_dev *dev)
 {
 	int pass, queues = dev->online_queues - 1;
-	unsigned long timeout;
 	u8 opcode = nvme_admin_delete_sq;
 
 	for (pass = 0; pass < 2; pass++) {
@@ -2058,15 +2057,12 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 
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
