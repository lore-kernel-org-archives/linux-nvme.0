From: hch@lst.de (Christoph Hellwig)
Date: Thu, 29 Nov 2018 20:13:03 +0100
Subject: [PATCH 06/13] nvme-pci: refactor nvme_disable_io_queues
In-Reply-To: <20181129191310.9795-1-hch@lst.de>
References: <20181129191310.9795-1-hch@lst.de>
Message-ID: <20181129191310.9795-7-hch@lst.de>

Pass the opcode for the delete SQ/CQ command as an argument instead of
the somewhat confusing pass loop.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 41 ++++++++++++++++++++---------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 10c26a2e355a..9ceba9900ca3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2244,31 +2244,29 @@ static int nvme_delete_queue(struct nvme_queue *nvmeq, u8 opcode)
 	return 0;
 }
 
-static void nvme_disable_io_queues(struct nvme_dev *dev)
+static bool nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode)
 {
-	int pass, queues = dev->online_queues - 1;
+	int nr_queues = dev->online_queues - 1, sent = 0;
 	unsigned long timeout;
-	u8 opcode = nvme_admin_delete_sq;
 
-	for (pass = 0; pass < 2; pass++) {
-		int sent = 0, i = queues;
-
-		reinit_completion(&dev->ioq_wait);
+	reinit_completion(&dev->ioq_wait);
  retry:
-		timeout = ADMIN_TIMEOUT;
-		for (; i > 0; i--, sent++)
-			if (nvme_delete_queue(&dev->queues[i], opcode))
-				break;
-
-		while (sent--) {
-			timeout = wait_for_completion_io_timeout(&dev->ioq_wait, timeout);
-			if (timeout == 0)
-				return;
-			if (i)
-				goto retry;
-		}
-		opcode = nvme_admin_delete_cq;
+	timeout = ADMIN_TIMEOUT;
+	while (nr_queues > 0) {
+		if (nvme_delete_queue(&dev->queues[nr_queues], opcode))
+			break;
+		nr_queues--;
+		sent++;
 	}
+	while (sent--) {
+		timeout = wait_for_completion_io_timeout(&dev->ioq_wait,
+				timeout);
+		if (timeout == 0)
+			return false;
+		if (nr_queues)
+			goto retry;
+	}
+	return true;
 }
 
 /*
@@ -2428,7 +2426,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	nvme_stop_queues(&dev->ctrl);
 
 	if (!dead && dev->ctrl.queue_count > 0) {
-		nvme_disable_io_queues(dev);
+		if (nvme_disable_io_queues(dev, nvme_admin_delete_sq))
+			nvme_disable_io_queues(dev, nvme_admin_delete_cq);
 		nvme_disable_admin_queue(dev, shutdown);
 	}
 	for (i = dev->ctrl.queue_count - 1; i >= 0; i--)
-- 
2.19.1
