From: mashimiao.fnst@cn.fujitsu.com (Ma Shimiao)
Date: Tue, 12 Dec 2017 17:36:39 +0800
Subject: [PATCH] drviers/nvme/target: fix max dup length for kstrndup
Message-ID: <20171212093639.21274-1-mashimiao.fnst@cn.fujitsu.com>

If source string longer than max, kstrndup will alloc max+1 space.
So, we should make sure the result will not over limit.

Signed-off-by: Ma Shimiao <mashimiao.fnst at cn.fujitsu.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index b54748ad5f48..0ca259ee4dea 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -975,7 +975,7 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 		return NULL;
 	}
 	subsys->type = type;
-	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE,
+	subsys->subsysnqn = kstrndup(subsysnqn, NVMF_NQN_SIZE - 1,
 			GFP_KERNEL);
 	if (!subsys->subsysnqn) {
 		kfree(subsys);
-- 
2.13.6
