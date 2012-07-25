From: keith.busch@intel.com (Keith Busch)
Date: Wed, 25 Jul 2012 16:04:29 -0600
Subject: [PATCH] NVMe: fix uninitialized iod compiler warning
Message-ID: <1343253869-30836-1-git-send-email-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/block/nvme.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/block/nvme.c b/drivers/block/nvme.c
index 38b9c73..4692c8e 100644
--- a/drivers/block/nvme.c
+++ b/drivers/block/nvme.c
@@ -1158,7 +1158,7 @@ static int nvme_user_admin_cmd(struct nvme_ns *ns,
 	struct nvme_admin_cmd cmd;
 	struct nvme_command c;
 	int status, length;
-	struct nvme_iod *iod;
+	struct nvme_iod *iod = NULL;
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-- 
1.7.0.4
