From: mgandhi@redhat.com (Milan P. Gandhi)
Date: Thu, 9 Aug 2018 19:03:44 +0530
Subject: [PATCH] Remove extra goto label from nvmet_ns_enable
Message-ID: <20180809133344.GA11707@machine1>

Currently nvmet_ns_enable has two labels viz. out_unlock and
out_dev_put, and the reverse call from out_dev_put to out_unlock
is little bit confusing. We could simplify it by calling
nvmet_ns_dev_disable before. This would eliminate need for
2nd label out_dev_put.

Also, this function already initializes ret variable to 0,
so there is no need to initialize it to 0 before out_unlock,
so removing it.

Signed-off-by: Milan P. Gandhi <mgandhi at redhat.com>
---
 drivers/nvme/target/core.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 9838103f2d62..b40fb6d724b4 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -346,9 +346,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace,
 				0, GFP_KERNEL);
-	if (ret)
-		goto out_dev_put;
-
+	if (ret) {
+		nvmet_ns_dev_disable(ns);
+		goto out_unlock;
+	}
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
 
@@ -372,13 +373,10 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
-	ret = 0;
+
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
-out_dev_put:
-	nvmet_ns_dev_disable(ns);
-	goto out_unlock;
 }
 
 void nvmet_ns_disable(struct nvmet_ns *ns)
-- 
2.14.3
