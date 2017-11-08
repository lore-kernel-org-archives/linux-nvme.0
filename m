From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Wed,  8 Nov 2017 10:59:03 +0100
Subject: [PATCH v2] nvme: compare NQN string with right size
Message-ID: <1510135144-1557-1-git-send-email-javier@cnexlabs.com>

From: Javier Gonz?lez <jg@lightnvm.io>

Copy subnqns using NVMF_NQN_SIZE as it is < 256

Changes since V1:
  - Fix commit message to indicate that it is a copy and not a comparison.

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 37f9039bb9ca..b3bc9fb39a6c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1744,7 +1744,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strcpy(ctrl->subnqn, id->subnqn);
+		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
