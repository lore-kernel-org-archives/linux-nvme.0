From: mlin@kernel.org (Ming Lin)
Date: Wed, 18 May 2016 14:05:01 -0700
Subject: [PATCH v2 1/2] nvme: update and rename nvme_cancel_io to
 nvme_cancel_request
In-Reply-To: <1463605502-27839-1-git-send-email-mlin@kernel.org>
References: <1463605502-27839-1-git-send-email-mlin@kernel.org>
Message-ID: <1463605502-27839-2-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@samsung.com>

nvme_cancel_io is a bit confusing (given the distinction of io/admin),
so rename it to nvme_cancel_request.

And update it a bit to pass in struct nvme_ctrl, so it can be used
by Fabrics driver also.

Signed-off-by: Ming Lin <ming.l at samsung.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Suggested-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index a62c9c5..16da89d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -925,14 +925,14 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	return BLK_EH_RESET_TIMER;
 }
 
-static void nvme_cancel_io(struct request *req, void *data, bool reserved)
+static void nvme_cancel_request(struct request *req, void *data, bool reserved)
 {
 	int status;
 
 	if (!blk_mq_request_started(req))
 		return;
 
-	dev_dbg_ratelimited(((struct nvme_dev *) data)->ctrl.device,
+	dev_dbg_ratelimited(((struct nvme_ctrl *) data)->device,
 				"Cancelling I/O %d", req->tag);
 
 	status = NVME_SC_ABORT_REQ;
@@ -1720,8 +1720,8 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_pci_disable(dev);
 
-	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_io, dev);
-	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_io, dev);
+	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
+	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
 	mutex_unlock(&dev->shutdown_lock);
 }
 
-- 
1.9.1
