From: keith.busch@intel.com (Keith Busch)
Date: Fri, 27 Jul 2012 11:53:28 -0600
Subject: [PATCH] NVMe: Fix uninitialized iod compiler warning
Message-ID: <1343411608-16133-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 7bcd882..47578ba 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1157,7 +1157,7 @@ static int nvme_user_admin_cmd(struct nvme_dev *dev,
 	struct nvme_admin_cmd cmd;
 	struct nvme_command c;
 	int status, length;
-	struct nvme_iod *iod;
+	struct nvme_iod *uninitialized_var(iod);
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-- 
1.7.0.4
