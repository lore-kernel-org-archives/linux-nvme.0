From: hare@suse.de (Hannes Reinecke)
Date: Tue, 29 May 2018 12:14:30 +0200
Subject: [PATCH 09/10] nvmet: Set mnan correctly
In-Reply-To: <20180529101431.62271-1-hare@suse.de>
References: <20180529101431.62271-1-hare@suse.de>
Message-ID: <20180529101431.62271-10-hare@suse.de>

We already have the number of namespaces per subsystem, so we can as well
use that for the 'mnan' value.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a9d05eb03117..99592c7b8bc7 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -301,7 +301,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
 	id->nn = cpu_to_le32(ctrl->subsys->max_nsid);
-	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+	id->mnan = cpu_to_le32(ctrl->subsys->nr_namespaces);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
-- 
2.12.3
