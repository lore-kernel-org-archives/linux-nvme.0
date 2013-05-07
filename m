From: keith.busch@intel.com (Keith Busch)
Date: Tue,  7 May 2013 14:17:54 -0600
Subject: [PATCH] NVMe: Use user defined admin ioctl timeout
Message-ID: <1367957874-20763-1-git-send-email-keith.busch@intel.com>

Use the user ioctl command timeout value if it is specified, and use
the default admin command timeout if one is not given.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme-core.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme-core.c b/drivers/block/nvme-core.c
index a232dfc..3ff3ba0 100644
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
 
+	timeout = cmd.timeout_ms ? DIV_ROUND_UP(cmd.timeout_ms * HZ, 1000):
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
