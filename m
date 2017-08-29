From: roland@kernel.org (Roland Dreier)
Date: Tue, 29 Aug 2017 10:33:44 -0700
Subject: [PATCH] nvme-fabrics: Convert nvmf_transports_mutex to an rwsem
Message-ID: <20170829173344.3402-1-roland@kernel.org>

From: Roland Dreier <roland@purestorage.com>

The mutex protects against the list of transports changing while a controller is
being created, but using a plain old mutex means that it also serializes controller
creation.  This unnecessarily slows down creating multiple controllers - for example
for the RDMA transport, creating a controller involves establishing one connection
for every IO queue, which involves even more network/software round trips, so the
delay can become significant.

The simplest way to fix this is to change the mutex to an rwsem and only hold it for
writing when the list is being mutated.  Since we can take the rwsem for reading
while creating a controller, we can create multiple controllers in parallel.

Signed-off-by: Roland Dreier <roland at purestorage.com>
---
 drivers/nvme/host/fabrics.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 5f5cd306f76d..714535903b7f 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -22,7 +22,7 @@
 #include "fabrics.h"
 
 static LIST_HEAD(nvmf_transports);
-static DEFINE_MUTEX(nvmf_transports_mutex);
+static DECLARE_RWSEM(nvmf_transports_rwsem);
 
 static LIST_HEAD(nvmf_hosts);
 static DEFINE_MUTEX(nvmf_hosts_mutex);
@@ -495,9 +495,9 @@ int nvmf_register_transport(struct nvmf_transport_ops *ops)
 	if (!ops->create_ctrl)
 		return -EINVAL;
 
-	mutex_lock(&nvmf_transports_mutex);
+	down_write(&nvmf_transports_rwsem);
 	list_add_tail(&ops->entry, &nvmf_transports);
-	mutex_unlock(&nvmf_transports_mutex);
+	up_write(&nvmf_transports_rwsem);
 
 	return 0;
 }
@@ -514,9 +514,9 @@ EXPORT_SYMBOL_GPL(nvmf_register_transport);
  */
 void nvmf_unregister_transport(struct nvmf_transport_ops *ops)
 {
-	mutex_lock(&nvmf_transports_mutex);
+	down_write(&nvmf_transports_rwsem);
 	list_del(&ops->entry);
-	mutex_unlock(&nvmf_transports_mutex);
+	up_write(&nvmf_transports_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvmf_unregister_transport);
 
@@ -525,7 +525,7 @@ static struct nvmf_transport_ops *nvmf_lookup_transport(
 {
 	struct nvmf_transport_ops *ops;
 
-	lockdep_assert_held(&nvmf_transports_mutex);
+	lockdep_assert_held(&nvmf_transports_rwsem);
 
 	list_for_each_entry(ops, &nvmf_transports, entry) {
 		if (strcmp(ops->name, opts->transport) == 0)
@@ -850,7 +850,7 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		goto out_free_opts;
 	opts->mask &= ~NVMF_REQUIRED_OPTS;
 
-	mutex_lock(&nvmf_transports_mutex);
+	down_read(&nvmf_transports_rwsem);
 	ops = nvmf_lookup_transport(opts);
 	if (!ops) {
 		pr_info("no handler found for transport %s.\n",
@@ -877,16 +877,16 @@ nvmf_create_ctrl(struct device *dev, const char *buf, size_t count)
 		dev_warn(ctrl->device,
 			"controller returned incorrect NQN: \"%s\".\n",
 			ctrl->subnqn);
-		mutex_unlock(&nvmf_transports_mutex);
+		up_read(&nvmf_transports_rwsem);
 		ctrl->ops->delete_ctrl(ctrl);
 		return ERR_PTR(-EINVAL);
 	}
 
-	mutex_unlock(&nvmf_transports_mutex);
+	up_read(&nvmf_transports_rwsem);
 	return ctrl;
 
 out_unlock:
-	mutex_unlock(&nvmf_transports_mutex);
+	up_read(&nvmf_transports_rwsem);
 out_free_opts:
 	nvmf_free_options(opts);
 	return ERR_PTR(ret);
-- 
2.14.1
