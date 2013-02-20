From: keith.busch@intel.com (Keith Busch)
Date: Wed, 20 Feb 2013 16:52:45 -0700
Subject: [PATCH 8/8] NVMe: Use schedule_timeout for sync commands
In-Reply-To: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
References: <1361404365-18982-1-git-send-email-keith.busch@intel.com>
Message-ID: <1361404365-18982-8-git-send-email-keith.busch@intel.com>

Schedule a timeout for sync commands should the controller fail to return
status and the device is not being polled for timed out commands. This
could happen when a device's queues are being deleted.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 120686c..dfb2e57 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -755,7 +755,7 @@ static int nvme_submit_sync_cmd(struct nvme_queue *nvmeq,
 
 	set_current_state(TASK_KILLABLE);
 	nvme_submit_cmd(nvmeq, cmd);
-	schedule();
+	schedule_timeout(timeout);
 
 	if (cmdinfo.status == -EINTR) {
 		nvme_abort_command(nvmeq, cmdid);
-- 
1.7.0.4
