From: hch@lst.de (Christoph Hellwig)
Date: Mon, 12 Jun 2017 18:27:38 +0200
Subject: [PATCH 2/2] nvme: no need to wait for the reset when keepalive fails
In-Reply-To: <20170612162738.19022-1-hch@lst.de>
References: <20170612162738.19022-1-hch@lst.de>
Message-ID: <20170612162738.19022-2-hch@lst.de>

We don't need to wait for the reset from the delayed work item that
is kicked off when we don't get a keepalive.

Signed-off-by: Christoph Hellwig <hch at lst.de>
Reported-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index afba749cac31..d0a5e963fafd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -623,7 +623,7 @@ static void nvme_keep_alive_work(struct work_struct *work)
 	if (nvme_keep_alive(ctrl)) {
 		/* allocation failure, reset the controller */
 		dev_err(ctrl->device, "keep-alive failed\n");
-		nvme_reset_ctrl_sync(ctrl);
+		nvme_reset_ctrl(ctrl);
 		return;
 	}
 }
-- 
2.11.0
