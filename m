From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Jun 2016 11:29:05 -0600
Subject: [PATCH 2/3] nvme: Kill detached namespaces prior to removal
In-Reply-To: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
Message-ID: <1466702946-13065-3-git-send-email-keith.busch@intel.com>

If a previously namespace allocated is detatched or deleted from the
controller, the driver needs to make sure nothing can send new IO to
the namespace prior to removing. This prevents buffered writers from
potentially stalling device removal indefinitely.

The patch pulls the request queue stoppage into a function and provides
a function to kill and remove the namespace. Any invalid namespace being
removed should go through here.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 38 ++++++++++++++++++++++++--------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 67aba46..43d6947 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1534,6 +1534,26 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	nvme_put_ns(ns);
 }
 
+static void nvme_ns_kill(struct nvme_ns *ns)
+{
+	/*
+	 * Revalidating a dead namespace sets capacity to 0. This will
+	 * end buffered writers dirtying pages that can't be synced.
+	 */
+	if (!test_and_set_bit(NVME_NS_DEAD, &ns->flags))
+		revalidate_disk(ns->disk);
+
+	blk_set_queue_dying(ns->queue);
+	blk_mq_abort_requeue_list(ns->queue);
+	blk_mq_start_stopped_hw_queues(ns->queue, true);
+}
+
+static void nvme_remove_dead_ns(struct nvme_ns *ns)
+{
+	nvme_ns_kill(ns);
+	nvme_ns_remove(ns);
+}
+
 static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns;
@@ -1554,7 +1574,7 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->ns_id > nsid)
-			nvme_ns_remove(ns);
+			nvme_remove_dead_ns(ns);
 	}
 }
 
@@ -1584,7 +1604,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 			while (++prev < nsid) {
 				ns = nvme_get_ns(ctrl, prev);
 				if (ns) {
-					nvme_ns_remove(ns);
+					nvme_remove_dead_ns(ns);
 					nvme_put_ns(ns);
 				}
 			}
@@ -1837,19 +1857,9 @@ void nvme_kill_queues(struct nvme_ctrl *ctrl)
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
 		if (!kref_get_unless_zero(&ns->kref))
-			continue;
-
-		/*
-		 * Revalidating a dead namespace sets capacity to 0. This will
-		 * end buffered writers dirtying pages that can't be synced.
-		 */
-		if (!test_and_set_bit(NVME_NS_DEAD, &ns->flags))
-			revalidate_disk(ns->disk);
-
-		blk_set_queue_dying(ns->queue);
-		blk_mq_abort_requeue_list(ns->queue);
-		blk_mq_start_stopped_hw_queues(ns->queue, true);
+			return;
 
+		nvme_ns_kill(ns);
 		nvme_put_ns(ns);
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
-- 
2.7.2
