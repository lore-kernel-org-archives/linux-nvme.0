From: keith.busch@intel.com (Keith Busch)
Date: Tue, 24 Jan 2017 18:07:00 -0500
Subject: [PATCH] nvme/pci: Don't mark IOD as aborted if abort wasn't sent
Message-ID: <1485299220-14866-1-git-send-email-keith.busch@intel.com>

This patch sets the aborted flag only if an abort was sent, reducing
excessive kernel message spamming for completed IO that wasn't actually
aborted.

Reported-by: Jens Axboe <axboe at kernel.dk>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3d21a15..f88659b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -905,12 +905,11 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 		return BLK_EH_HANDLED;
 	}
 
-	iod->aborted = 1;
-
 	if (atomic_dec_return(&dev->ctrl.abort_limit) < 0) {
 		atomic_inc(&dev->ctrl.abort_limit);
 		return BLK_EH_RESET_TIMER;
 	}
+	iod->aborted = 1;
 
 	memset(&cmd, 0, sizeof(cmd));
 	cmd.abort.opcode = nvme_admin_abort_cmd;
-- 
2.5.5
