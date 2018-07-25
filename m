From: hare@suse.de (Hannes Reinecke)
Date: Wed, 25 Jul 2018 08:34:45 +0200
Subject: [PATCH] nvmet: only check for filebacking on -ENOTBLK
Message-ID: <20180725063445.94447-1-hare@suse.de>

We only need to check for a file-backed namespace if
nvmet_bdev_ns_enable() returns -ENOTBLK. For any other error
it's pointless as the open() error will remain the same.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ddd85715a00a..a216d7eb1050 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -344,7 +344,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ret = nvmet_bdev_ns_enable(ns);
-	if (ret)
+	if (ret == -ENOTBLK)
 		ret = nvmet_file_ns_enable(ns);
 	if (ret)
 		goto out_unlock;
-- 
2.12.3
