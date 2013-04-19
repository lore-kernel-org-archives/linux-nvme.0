From: keith.busch@intel.com (Keith Busch)
Date: Fri, 19 Apr 2013 14:11:06 -0600
Subject: [PATCH 2/2] NVMe: Schedule timeout for sync commands
In-Reply-To: <1366402266-10131-1-git-send-email-keith.busch@intel.com>
References: <1366402266-10131-1-git-send-email-keith.busch@intel.com>
Message-ID: <1366402266-10131-3-git-send-email-keith.busch@intel.com>

Schedule a timeout on sync commands in case the command times out and
the device is not being polled for timeouts. This prevents device removal
from hanging forever if the device has stopped responding.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index e64beaa..2660b6c 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -731,7 +731,7 @@ int nvme_submit_sync_cmd(struct nvme_queue *nvmeq, struct nvme_command *cmd,
 
 	set_current_state(TASK_KILLABLE);
 	nvme_submit_cmd(nvmeq, cmd);
-	schedule();
+	schedule_timeout(timeout);
 
 	if (cmdinfo.status == -EINTR) {
 		nvme_abort_command(nvmeq, cmdid);
-- 
1.7.0.4
