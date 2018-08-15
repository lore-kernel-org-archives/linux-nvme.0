From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:49 -0400
Subject: [PATCH V4 4/9] nvmet: add global subsystem list
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-5-chaitanya.kulkarni@wdc.com>

This adds a new structure member for nvmet_subsys and global
list of the subsystems.
We use this global list to maintain currently connected,
not connected, linked and not linked subsystem on the lists.

This is a preparation patch for implementing the NVMeOF target
passthru code.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/core.c  | 12 ++++++++++++
 drivers/nvme/target/nvmet.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 4317678df194..ada700cce2d2 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -22,6 +22,9 @@ struct workqueue_struct *buffered_io_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
 static DEFINE_IDA(cntlid_ida);
 
+static LIST_HEAD(nvmet_subsystems);
+DEFINE_MUTEX(nvmet_subsystems_lock);
+
 /*
  * This read/write semaphore is used to synchronize access to configuration
  * information on a target system that will result in discovery log page
@@ -1166,6 +1169,11 @@ struct nvmet_subsys *nvmet_subsys_alloc(const char *subsysnqn,
 	INIT_LIST_HEAD(&subsys->namespaces);
 	INIT_LIST_HEAD(&subsys->ctrls);
 	INIT_LIST_HEAD(&subsys->hosts);
+	INIT_LIST_HEAD(&subsys->entry);
+
+	mutex_lock(&nvmet_subsystems_lock);
+	list_add_tail(&subsys->entry, &nvmet_subsystems);
+	mutex_unlock(&nvmet_subsystems_lock);
 
 	return subsys;
 }
@@ -1177,6 +1185,10 @@ static void nvmet_subsys_free(struct kref *ref)
 
 	WARN_ON_ONCE(!list_empty(&subsys->namespaces));
 
+	mutex_lock(&nvmet_subsystems_lock);
+	list_del(&subsys->entry);
+	mutex_unlock(&nvmet_subsystems_lock);
+
 	kfree(subsys->subsysnqn);
 	kfree(subsys);
 }
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 221cf6cacd4a..72f7380ab590 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -211,6 +211,8 @@ struct nvmet_subsys {
 
 	struct config_group	namespaces_group;
 	struct config_group	allowed_hosts_group;
+
+	struct list_head	entry;
 };
 
 static inline struct nvmet_subsys *to_subsys(struct config_item *item)
-- 
2.14.1
