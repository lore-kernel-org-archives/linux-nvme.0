From: daniel.verkamp@intel.com (Daniel Verkamp)
Date: Wed,  7 Dec 2016 11:39:47 -0700
Subject: [PATCH] nvmet: fix KATO offset in Set Features
Message-ID: <20161207183947.128897-1-daniel.verkamp@intel.com>

The Set Features implementation for Keep Alive Timer was using the wrong
structure when retrieving the KATO value; it was treating the Set
Features command as a Property Set command.

The NVMe spec defines the Keep Alive Timer feature as having one input
in CDW11 (4 bytes at offset 44 in the command) whereas the code was
reading 8 bytes at offset 48.

Since the Linux NVMe over Fabrics host never sets this feature, this
code has presumably never been tested.

Signed-off-by: Daniel Verkamp <daniel.verkamp at intel.com>
---
 drivers/nvme/target/admin-cmd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fe4c48..bdae9ef 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -391,8 +391,7 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 			(subsys->max_qid - 1) | ((subsys->max_qid - 1) << 16));
 		break;
 	case NVME_FEAT_KATO:
-		val = le64_to_cpu(req->cmd->prop_set.value);
-		val32 = val & 0xffff;
+		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
-- 
2.9.3
