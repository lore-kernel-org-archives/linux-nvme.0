From: keith.busch@intel.com (Keith Busch)
Date: Thu,  5 Sep 2013 14:45:08 -0600
Subject: [PATCH 2/9] NVMe: Differentiate commands not completed
In-Reply-To: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
References: <1378413915-16667-1-git-send-email-keith.busch@intel.com>
Message-ID: <1378413915-16667-3-git-send-email-keith.busch@intel.com>

If we interally abort a command the device has not returned to us, do not
create a fake completetion queue entry so the callback can know the device
is not responsive. The only real use of this is the sync completion which
may use the return status to know if the device should be used or not.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index da52092..8b22068 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -181,13 +181,15 @@ static void special_completion(struct nvme_dev *dev, void *ctx,
 	if (ctx == CMD_CTX_FLUSH)
 		return;
 	if (ctx == CMD_CTX_COMPLETED) {
-		dev_warn(&dev->pci_dev->dev,
+		if (cqe)
+			dev_warn(&dev->pci_dev->dev,
 				"completed id %d twice on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
 	}
 	if (ctx == CMD_CTX_INVALID) {
-		dev_warn(&dev->pci_dev->dev,
+		if (cqe)
+			dev_warn(&dev->pci_dev->dev,
 				"invalid id %d completed on queue %d\n",
 				cqe->command_id, le16_to_cpup(&cqe->sq_id));
 		return;
@@ -346,7 +348,7 @@ static void bio_completion(struct nvme_dev *dev, void *ctx,
 {
 	struct nvme_iod *iod = ctx;
 	struct bio *bio = iod->private;
-	u16 status = le16_to_cpup(&cqe->status) >> 1;
+	u16 status = cqe ? le16_to_cpup(&cqe->status) >> 1 : -EIO;
 
 	if (iod->nents) {
 		dma_unmap_sg(&dev->pci_dev->dev, iod->sg, iod->nents,
@@ -847,8 +849,10 @@ static void sync_completion(struct nvme_dev *dev, void *ctx,
 						struct nvme_completion *cqe)
 {
 	struct sync_cmd_info *cmdinfo = ctx;
-	cmdinfo->result = le32_to_cpup(&cqe->result);
-	cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	if (cqe) {
+		cmdinfo->result = le32_to_cpup(&cqe->result);
+		cmdinfo->status = le16_to_cpup(&cqe->status) >> 1;
+	}
 	wake_up_process(cmdinfo->task);
 }
 
@@ -1016,9 +1020,6 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 	for_each_set_bit(cmdid, nvmeq->cmdid_data, depth) {
 		void *ctx;
 		nvme_completion_fn fn;
-		static struct nvme_completion cqe = {
-			.status = cpu_to_le16(NVME_SC_ABORT_REQ << 1),
-		};
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
@@ -1026,7 +1027,7 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-		fn(nvmeq->dev, ctx, &cqe);
+		fn(nvmeq->dev, ctx, NULL);
 	}
 }
 
-- 
1.7.0.4
