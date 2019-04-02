From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue,  2 Apr 2019 14:52:47 +0300
Subject: [PATCH 1/1] nvmet: never fail double namespace enablement
Message-ID: <1554205967-2380-1-git-send-email-maxg@mellanox.com>

In case we create N namespaces while N < NVMET_MAX_NAMESPACES, we can
perform "echo 1 > <nsid>/enable" as much as we want. In case N ==
NVMET_MAX_NAMESPACES we fail. Make sure we have the same flow for any N.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/target/core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d42de97..4d8dd29 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -496,13 +496,14 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	int ret;
 
 	mutex_lock(&subsys->lock);
-	ret = -EMFILE;
-	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
-		goto out_unlock;
 	ret = 0;
 	if (ns->enabled)
 		goto out_unlock;
 
+	ret = -EMFILE;
+	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
+		goto out_unlock;
+
 	ret = nvmet_bdev_ns_enable(ns);
 	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
-- 
1.8.3.1
