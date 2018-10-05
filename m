From: keith.busch@intel.com (Keith Busch)
Date: Fri,  5 Oct 2018 09:49:37 -0600
Subject: [PATCH] nvme: Update node paths after adding new path
Message-ID: <20181005154937.24198-1-keith.busch@intel.com>

The nvme namespace paths were being updated only when the current path
was not set or nonoptimized. If a new path comes online that is a better
path for its NUMA node, the multipath selector may continue using the
previously set path on a potentially further node.

This patch re-runs the path assignment after successfully adding a new
optimized path.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/multipath.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 52987052b7fc..fc3c5c2b3eca 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -321,6 +321,14 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		device_add_disk(&head->subsys->dev, head->disk,
 				nvme_ns_id_attr_groups);
 
+	if (nvme_path_is_optimized(ns)) {
+		int node, srcu_idx;
+
+		srcu_idx = srcu_read_lock(&head->srcu);
+		for_each_node(node)
+			__nvme_find_path(head, node);
+		srcu_read_unlock(&head->srcu, srcu_idx);
+	}
 	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
-- 
2.14.4
