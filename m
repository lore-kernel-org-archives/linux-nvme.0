From: mskorzhinskiy@solarflare.com (Mikhail Skorzhinskii)
Date: Thu, 4 Jul 2019 10:01:48 +0200
Subject: [PATCH] nvmet: print a hint while rejecting NSID 0 or 0xffffffff
Message-ID: <c3a8458b54fcd189f7a441eb959274937faf8568.1562586068.git.mskorzhinskiy@solarflare.com>

Adding this hint for the sake of convenience.

It was spotted that a few times people spent some time before understanding
what is exactly wrong in configuration process. This should save a few time
in such situations, especially for people who is not very confident with
NVMe requirements.

Signed-off-by: Mikhail Skorzhinskii <mskorzhinskiy at solarflare.com>
---
 drivers/nvme/target/configfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 08dd5af357f7..cd52b9f15376 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -588,8 +588,10 @@ static struct config_group *nvmet_ns_make(struct config_group *group,
 		goto out;
 
 	ret = -EINVAL;
-	if (nsid == 0 || nsid == NVME_NSID_ALL)
+	if (nsid == 0 || nsid == NVME_NSID_ALL) {
+		pr_err("invalid nsid %#x", nsid);
 		goto out;
+	}
 
 	ret = -ENOMEM;
 	ns = nvmet_ns_alloc(subsys, nsid);
-- 
2.16.4
