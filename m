From: keith.busch@intel.com (Keith Busch)
Date: Fri, 16 Aug 2013 16:00:30 -0600
Subject: [PATCHv2 3/5] NVMe: Reset controller on timed out commands
In-Reply-To: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
References: <1376690432-9775-1-git-send-email-keith.busch@intel.com>
Message-ID: <1376690432-9775-4-git-send-email-keith.busch@intel.com>

This fixes the race between the controller and the timeout handler. Timing
out the command previously called the completion handler with a failure
status and the completion handler frees the command's target memory. If
the controller is still active, it may use this memory for dma, which can
be bad. This patch makes a timed out command trigger a controller reset,
which will shut down the controller prior to freeing memory associated
with outstanding commands.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
I know we should send an abort command prior to going to the big
hammer. That gets complicated quickly though, so I just want to submit
something that should fix the race condition first, then tackle the
abort handling.

 drivers/block/nvme-core.c |   13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index c0f2533..c07a507 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1010,7 +1010,7 @@ int nvme_set_features(struct nvme_dev *dev, unsigned fid, unsigned dword11,
  * @queue: The queue to cancel I/Os on
  * @timeout: True to only cancel I/Os which have timed out
  */
-static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
+static int nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 {
 	int depth = nvmeq->q_depth - 1;
 	struct nvme_cmd_info *info = nvme_cmd_info(nvmeq);
@@ -1028,10 +1028,14 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			continue;
 		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
 			continue;
+		if (timeout)
+			return 1;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
 	}
+
+	return 0;
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
@@ -1620,7 +1624,12 @@ static int nvme_kthread(void *data)
 				if (nvmeq->q_suspended)
 					goto unlock;
 				nvme_process_cq(nvmeq);
-				nvme_cancel_ios(nvmeq, true);
+				if (nvme_cancel_ios(nvmeq, true)) {
+					dev_warn(&dev->pci_dev->dev,
+						"command time out, reset controller\n");
+					queue_work(nvme_workq, &dev->ws);
+					goto unlock;
+				}
 				nvme_resubmit_bios(nvmeq);
  unlock:
 				spin_unlock_irq(&nvmeq->q_lock);
-- 
1.7.10.4
