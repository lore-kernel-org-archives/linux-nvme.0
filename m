From: jg@lightnvm.io (=?UTF-8?q?Javier=20Gonz=C3=A1lez?=)
Date: Fri,  3 Nov 2017 11:02:49 +0100
Subject: [PATCH 2/3] nvme: compare NQN string with right size
In-Reply-To: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
References: <1509703370-20379-1-git-send-email-javier@cnexlabs.com>
Message-ID: <1509703370-20379-3-git-send-email-javier@cnexlabs.com>

Compare subnqns using NVMF_NQN_SIZE as it is < 256

Signed-off-by: Javier Gonz?lez <javier at cnexlabs.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bd1d5ff911c9..ae8ab0a1ef0d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1743,7 +1743,7 @@ static void nvme_init_subnqn(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strcpy(ctrl->subnqn, id->subnqn);
+		strncpy(ctrl->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
