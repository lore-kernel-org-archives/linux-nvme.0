From: nick.desaulniers@gmail.com (Nick Desaulniers)
Date: Mon, 28 May 2018 23:49:18 -0700
Subject: [PATCH] nvme: prefer strlcpy to strncpy
Message-ID: <1527576558-26817-1-git-send-email-nick.desaulniers@gmail.com>

Fixes a stringop-truncation warning from gcc-8.

Signed-off-by: Nick Desaulniers <nick.desaulniers at gmail.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 99b857e..b823ecb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2017,7 +2017,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	nqnlen = strnlen(id->subnqn, NVMF_NQN_SIZE);
 	if (nqnlen > 0 && nqnlen < NVMF_NQN_SIZE) {
-		strncpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
+		strlcpy(subsys->subnqn, id->subnqn, NVMF_NQN_SIZE);
 		return;
 	}
 
-- 
2.7.4
