From: mlin@kernel.org (Ming Lin)
Date: Tue, 17 May 2016 22:56:58 -0700
Subject: [PATCH 1/2] nvme: update nvme_cancel_io() a bit
In-Reply-To: <1463551019-16687-1-git-send-email-mlin@kernel.org>
References: <1463551019-16687-1-git-send-email-mlin@kernel.org>
Message-ID: <1463551019-16687-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

Pass in nvme_ctrl, so it can be used by Fabrics driver also.

Signed-off-by: Ming Lin <ming.l at samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a62c9c5..a2481ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -927,13 +927,13 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 
 static void nvme_cancel_io(struct request *req, void *data, bool reserved)
 {
+	struct nvme_ctrl *ctrl = data;
 	int status;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_dbg_ratelimited(((struct nvme_dev *) data)->ctrl.device,
-				"Cancelling I/O %d", req->tag);
+	dev_dbg_ratelimited(ctrl->device, "Cancelling I/O %d", req->tag);
 
 	status = NVME_SC_ABORT_REQ;
 	if (blk_queue_dying(req->q))
@@ -1720,8 +1720,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, dev);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, &dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
1.9.1
