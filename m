From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 29 Mar 2017 12:03:32 +0300
Subject: [PATCH 1/1] nvme: don't ignore tagset allocation failures
Message-ID: <1490778212-11007-1-git-send-email-maxg@mellanox.com>

the nvme_dev_add() function silently ignores failures.
In case blk_mq_alloc_tag_set fails, we hit NULL deref while
calling blk_mq_init_queue during nvme_alloc_ns with tagset == NULL.
Instead, we'll not issue the scan_work in case tagset allocation
failed and leave the ctrl functional.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9b3b57f..493722a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2115,9 +2115,9 @@ void nvme_queue_scan(struct nvme_ctrl *ctrl)
 {
 	/*
 	 * Do not queue new scan work when a controller is reset during
-	 * removal.
+	 * removal or if the tagset doesn't exist.
 	 */
-	if (ctrl->state == NVME_CTRL_LIVE)
+	if (ctrl->state == NVME_CTRL_LIVE && ctrl->tagset)
 		schedule_work(&ctrl->scan_work);
 }
 EXPORT_SYMBOL_GPL(nvme_queue_scan);
-- 
1.7.1
