From: hch@lst.de (Christoph Hellwig)
Date: Thu, 27 Sep 2018 16:05:57 -0700
Subject: [PATCH] nvme: take node locality into account when selecting a path
Message-ID: <20180927230557.29444-1-hch@lst.de>

Make current_path an array with an entry for every possible node, and
cache the best path on a per-node basis.  Take the node distance into
account when selecting it.  This is primarily useful for dual-ported PCIe
devices which are connected to PCIe root ports on different sockets.

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c      |  7 ++++-
 drivers/nvme/host/multipath.c | 50 +++++++++++++++++++++++++++--------
 drivers/nvme/host/nvme.h      | 25 +++++++-----------
 3 files changed, 54 insertions(+), 28 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 41a6180649d2..eb10b263de8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2900,9 +2900,14 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		unsigned nsid, struct nvme_id_ns *id)
 {
 	struct nvme_ns_head *head;
+	size_t size = sizeof(*head);
 	int ret = -ENOMEM;
 
-	head = kzalloc(sizeof(*head), GFP_KERNEL);
+#ifdef CONFIG_NVME_MULTIPATH
+	size += num_possible_nodes() * sizeof(struct nvme_ns *);
+#endif
+
+	head = kzalloc(size, GFP_KERNEL);
 	if (!head)
 		goto out;
 	ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 5a9562881d4e..82c8911aff6f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -110,29 +110,55 @@ static const char *nvme_ana_state_names[] = {
 	[NVME_ANA_CHANGE]		= "change",
 };
 
-static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head)
+void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
-	struct nvme_ns *ns, *fallback = NULL;
+	struct nvme_ns_head *head = ns->head;
+	int node;
+
+	if (!head)
+		return;
+
+	for_each_node(node) {
+		if (ns == rcu_access_pointer(head->current_path[node]))
+			rcu_assign_pointer(head->current_path[node], NULL);
+	}
+}
+
+static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
+{
+	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
+	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (ns->ctrl->state != NVME_CTRL_LIVE ||
 		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
 			continue;
+
+		distance = node_distance(node, dev_to_node(ns->ctrl->dev));
+
 		switch (ns->ana_state) {
 		case NVME_ANA_OPTIMIZED:
-			rcu_assign_pointer(head->current_path, ns);
-			return ns;
+			if (distance < found_distance) {
+				found_distance = distance;
+				found = ns;
+			}
+			break;
 		case NVME_ANA_NONOPTIMIZED:
-			fallback = ns;
+			if (distance < fallback_distance) {
+				fallback_distance = distance;
+				fallback = ns;
+			}
 			break;
 		default:
 			break;
 		}
 	}
 
-	if (fallback)
-		rcu_assign_pointer(head->current_path, fallback);
-	return fallback;
+	if (!found)
+		found = fallback;
+	if (found)
+		rcu_assign_pointer(head->current_path[node], found);
+	return found;
 }
 
 static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
@@ -143,10 +169,12 @@ static inline bool nvme_path_is_optimized(struct nvme_ns *ns)
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
 {
-	struct nvme_ns *ns = srcu_dereference(head->current_path, &head->srcu);
+	int node = numa_node_id();
+	struct nvme_ns *ns;
 
+	ns = srcu_dereference(head->current_path[node], &head->srcu);
 	if (unlikely(!ns || !nvme_path_is_optimized(ns)))
-		ns = __nvme_find_path(head);
+		ns = __nvme_find_path(head, node);
 	return ns;
 }
 
@@ -193,7 +221,7 @@ static bool nvme_ns_head_poll(struct request_queue *q, blk_qc_t qc)
 	int srcu_idx;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = srcu_dereference(head->current_path, &head->srcu);
+	ns = srcu_dereference(head->current_path[numa_node_id()], &head->srcu);
 	if (likely(ns && nvme_path_is_optimized(ns)))
 		found = ns->queue->poll_fn(q, qc);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bb4a2003c097..5eec5b9205f3 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -277,14 +277,6 @@ struct nvme_ns_ids {
  * only ever has a single entry for private namespaces.
  */
 struct nvme_ns_head {
-#ifdef CONFIG_NVME_MULTIPATH
-	struct gendisk		*disk;
-	struct nvme_ns __rcu	*current_path;
-	struct bio_list		requeue_list;
-	spinlock_t		requeue_lock;
-	struct work_struct	requeue_work;
-	struct mutex		lock;
-#endif
 	struct list_head	list;
 	struct srcu_struct      srcu;
 	struct nvme_subsystem	*subsys;
@@ -293,6 +285,14 @@ struct nvme_ns_head {
 	struct list_head	entry;
 	struct kref		ref;
 	int			instance;
+#ifdef CONFIG_NVME_MULTIPATH
+	struct gendisk		*disk;
+	struct bio_list		requeue_list;
+	spinlock_t		requeue_lock;
+	struct work_struct	requeue_work;
+	struct mutex		lock;
+	struct nvme_ns __rcu	*current_path[];
+#endif
 };
 
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
@@ -474,14 +474,7 @@ void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
-
-static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
-{
-	struct nvme_ns_head *head = ns->head;
-
-	if (head && ns == rcu_access_pointer(head->current_path))
-		rcu_assign_pointer(head->current_path, NULL);
-}
+void nvme_mpath_clear_current_path(struct nvme_ns *ns);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
 
 static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
-- 
2.19.0
