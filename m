From: keith.busch@intel.com (Keith Busch)
Date: Thu,  9 May 2013 14:01:38 -0600
Subject: [PATCH v2] NVMe: Use user defined admin ioctl timeout
Message-ID: <1368129698-29228-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a232dfc..f960c53 100644
--- a/drivers/block/nvme-core.c
+++ b/drivers/block/nvme-core.c
@@ -1362,6 +1362,7 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 	struct nvme_command c;
 	int status, length;
 	struct nvme_iod *uninitialized_var(iod);
+	unsigned timeout;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
@@ -1391,10 +1392,13 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 								GFP_KERNEL);
 	}
 
+	timeout = cmd.timeout_ms ? msecs_to_jiffies(cmd.timeout_ms) :
+								ADMIN_TIMEOUT;
 	if (length != cmd.data_len)
 		status = -ENOMEM;
 	else
-		status = nvme_submit_admin_cmd(dev, &c, &cmd.result);
+		status = nvme_submit_sync_cmd(dev->queues[0], &c, &cmd.result,
+								timeout);
 
 	if (cmd.data_len) {
 		nvme_unmap_user_pages(dev, cmd.opcode & 1, iod);
-- 
1.7.0.4
