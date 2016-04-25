From: mlin@kernel.org (Ming Lin)
Date: Mon, 25 Apr 2016 14:20:19 -0700
Subject: [PATCH v2 2/2] nvme: fix nvme_ns_remove() deadlock
In-Reply-To: <1461619219-18144-1-git-send-email-mlin@kernel.org>
References: <1461619219-18144-1-git-send-email-mlin@kernel.org>
Message-ID: <1461619219-18144-3-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

On receipt of a namespace attribute changed AER, we acquire the
namespace mutex lock before proceeding to scan and validate the
namespace list. In case of namespace detach/delete command,
nvme_ns_remove function deadlocks trying to acquire the already held
lock.

All callers, except nvme_remove_namespaces(), of nvme_ns_remove()
already held namespaces_mutex. So we can simply fix the deadlock by
not acquiring the mutex in nvme_ns_remove() and acquiring it in
nvme_remove_namespaces().

Reported-by: Sunad Bhandary S <sunad.s at samsung.com>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 914d336..4fff373 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1403,6 +1403,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
+	lockdep_assert_held(&ns->ctrl->namespaces_mutex);
+
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -1415,9 +1417,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 		blk_mq_abort_requeue_list(ns->queue);
 		blk_cleanup_queue(ns->queue);
 	}
-	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
-	mutex_unlock(&ns->ctrl->namespaces_mutex);
 	synchronize_rcu();
 	nvme_put_ns(ns);
 }
@@ -1513,8 +1513,10 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
+	mutex_unlock(&ctrl->namespaces_mutex);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
-- 
1.9.1
