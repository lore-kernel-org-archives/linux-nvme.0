From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Dec 2013 11:14:09 -0700
Subject: [PATCH] NVMe: Use error handling on failed sync commands
Message-ID: <1387563249-27871-1-git-send-email-keith.busch@intel.com>

Sync commands schedule an internal timeout to cancel rather than using
the nvme timeout handler kthread. We should still try to recover so
moving the check for cancelled commands after the error handling.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index b59a93a..79a130c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1122,12 +1122,12 @@ static void nvme_cancel_ios(struct nvme_queue *nvmeq, bool timeout)
 
 		if (timeout && !time_after(now, info[cmdid].timeout))
 			continue;
-		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
-			continue;
 		if (timeout && nvmeq->dev->initialized) {
 			nvme_abort_cmd(cmdid, nvmeq);
 			continue;
 		}
+		if (info[cmdid].ctx == CMD_CTX_CANCELLED)
+			continue;
 		dev_warn(nvmeq->q_dmadev, "Cancelling I/O %d QID %d\n", cmdid,
 								nvmeq->qid);
 		ctx = cancel_cmdid(nvmeq, cmdid, &fn);
-- 
1.7.10.4
