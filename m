From: keith.busch@intel.com (Keith Busch)
Date: Tue, 30 Apr 2013 11:19:38 -0600
Subject: [PATCH] NVMe: Do not cancel command multiple times
Message-ID: <1367342378-9265-1-git-send-email-keith.busch@intel.com>

Cancelling an already cancelled command does not do anything, so check
the command context before cancelling it, continuing if had already been
cancelled so we do not log the same problem every second if a device
stops responding.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index 40908a0..8899e79 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -880,6 +880,8 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d\n", cmdid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
 		fn(nvmeq->dev, ctx, &cqe);
-- 
1.7.0.4
