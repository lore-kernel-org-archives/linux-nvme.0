From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 18 Apr 2018 15:00:04 -0400
Subject: [PATCH 13/20] nvmet: initialize new ns and subsys members
In-Reply-To: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
References: <20180418190011.3973-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180418190011.3973-14-chaitanya.kulkarni@wdc.com>

We initialize newly introduce subsys and ns members.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4d25038ed05c..34a2b8903ec0 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -1091,6 +1091,8 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	subsys->mount_path = NULL;
+	subsys->nsid_map[0] = 0;
 
 	return subsys;
 }
@@ -1103,6 +1105,7 @@ static void nvmet_subsys_free(struct kref *ref)
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
 	kfree(subsys->subsysnqn);
+	kfree(subsys->mount_path);
 	kfree(subsys);
 }
 
-- 
2.14.1
