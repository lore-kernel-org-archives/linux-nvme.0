From: hare@suse.de (Hannes Reinecke)
Date: Fri, 26 Oct 2018 14:57:18 +0200
Subject: [PATCH 3/3] nvme-multipath: automatic NUMA path balancing
In-Reply-To: <20181026125718.122767-1-hare@suse.de>
References: <20181026125718.122767-1-hare@suse.de>
Message-ID: <20181026125718.122767-4-hare@suse.de>

In order to utilize both paths on dual-ported HBAs we cannot rely
on the NUMA affinity alone, but rather have to distribute the
locality information to get the best possible result.
This patch implements a two-pass algorithm for assinging NUMA
locality information:
1. Distribute existing locality information so that no core has
more than one 'local' controller
2. Assign a 'local' controller for each of the remaining cores,
so that the overall weight (ie the sum of all locality information)
per ctrl is minimal.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 111 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 111 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index a589a1a7b6ce..9e4183401539 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -262,6 +262,115 @@ static void nvme_requeue_work(struct work_struct *work)
 	}
 }
 
+void nvme_mpath_distribute_paths(struct nvme_subsystem *subsys, int num_ctrls,
+				 struct nvme_ctrl *ctrl, int node_id)
+{
+	int node;
+	int found_node = NUMA_NO_NODE;
+	int max = LOCAL_DISTANCE * num_ctrls;
+
+	for_each_node(node) {
+		struct nvme_ctrl *c;
+		int sum = 0;
+
+		list_for_each_entry(c, &subsys->ctrls, subsys_entry)
+			sum += c->node_map[node];
+		if (sum > max) {
+			max = sum;
+			found_node = node;
+		}
+	}
+	if (found_node != NUMA_NO_NODE) {
+		ctrl->node_map[found_node] = LOCAL_DISTANCE;
+		ctrl->node_map[node_id] = REMOTE_DISTANCE;
+	}
+}
+
+void nvme_mpath_balance_node(struct nvme_subsystem *subsys,
+			     int num_ctrls, int node_id)
+{
+	struct nvme_ctrl *found = NULL, *ctrl;
+	int max = LOCAL_DISTANCE * num_ctrls, node;
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		int sum = 0;
+
+		for_each_node(node)
+			sum += ctrl->node_map[node];
+		if (sum > max) {
+			max = sum;
+			found = ctrl;
+		}
+	}
+	if (found)
+		found->node_map[node_id] = LOCAL_DISTANCE;
+}
+
+void nvme_mpath_balance_subsys(struct nvme_subsystem *subsys)
+{
+	struct nvme_ctrl *ctrl;
+	int num_ctrls = 0;
+	int node;
+
+	mutex_lock(&subsys->lock);
+
+	/*
+	 * 1. Reset set NUMA distance
+	 *    During creation the NUMA distance is only set
+	 *    per controller, so after connecting the other
+	 *    controllers the NUMA information on the existing
+	 *    ones is incorrect.
+	 */
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		for_each_node(node)
+			ctrl->node_map[node] =
+				node_distance(node, ctrl->node_id);
+		num_ctrls++;
+	}
+
+	/*
+	 * 2. Distribute optimal paths:
+	 *    Only one primary paths per node.
+	 *    Additional primary paths are moved to unassigned nodes.
+	 */
+	for_each_node(node) {
+		bool optimal = false;
+
+		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+			if (ctrl->node_map[node] == LOCAL_DISTANCE) {
+				if (!optimal) {
+					optimal = true;
+					continue;
+				}
+				nvme_mpath_distribute_paths(subsys, num_ctrls,
+							    ctrl, node);
+			}
+		}
+	}
+
+	/*
+	 * 3. Balance unassigned nodes:
+	 *    Each unassigned node should have one primary path;
+	 *    the primary path is assigned to the ctrl with the
+	 *    minimal weight (ie the sum of distances over all nodes)
+	 */
+	for_each_node(node) {
+		bool optimal = false;
+
+		list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+			if (ctrl->node_map[node] == LOCAL_DISTANCE) {
+				optimal = true;
+				break;
+			}
+		}
+		if (optimal)
+			continue;
+		nvme_mpath_balance_node(subsys, num_ctrls, node);
+	}
+
+	mutex_unlock(&subsys->lock);
+}
+
 int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 {
 	struct request_queue *q;
@@ -553,6 +662,8 @@ int nvme_mpath_init(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 {
 	int error;
 
+	nvme_mpath_balance_subsys(ctrl->subsys);
+
 	if (!nvme_ctrl_use_ana(ctrl))
 		return 0;
 
-- 
2.16.4
