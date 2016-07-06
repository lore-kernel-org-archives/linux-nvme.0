From: weiyj_lk@163.com (weiyj_lk@163.com)
Date: Wed,  6 Jul 2016 12:02:09 +0000
Subject: [PATCH -next] nvmet: fix return value check in nvmet_subsys_alloc()
Message-ID: <1467806529-23712-1-git-send-email-weiyj_lk@163.com>

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function kstrndup() returns NULL pointer
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei at trendmicro.com.cn>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index e0b3f01..8a891ca 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -895,7 +895,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	subsys->type = type;
 	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
 			GFP_KERNEL);
-	if (IS_ERR(subsys->subsysnqn)) {
+	if (!subsys->subsysnqn) {
 		kfree(subsys);
 		return NULL;
 	}
