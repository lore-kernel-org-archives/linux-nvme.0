From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Apr 2019 01:12:21 +0200
Subject: [PATCHv2 RFC] nvme: use nvme_set_queue_dying() during namespace
 rescanning
Message-ID: <20190403231221.127008-1-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

There is a race condition between namespace rescanning and controller
reset; during controller reset all namespaces are quiesed vie
nams_stop_ctrl(), and after reset all namespaces are unquiesced
again.
When namespace scanning was active by the time controller reset was
triggered the rescan code will call nvme_ns_remove(), which then will
cause a kernel crash in nvme_start_ctrl() as it'll trip over
uninitialized namespaces.

This patch calls nvme_set_queue_dying() during namespace rescan,
which will already unquiesce the queue. Hence we can skip all namespaces
with the 'DEAD' flag during unquiesce in nvme_start_ctrl() and eliminate
this issue.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 23000a368e1f..21aa5c516d2a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3359,7 +3359,7 @@ static void nvme_validate_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	ns = nvme_find_get_ns(ctrl, nsid);
 	if (ns) {
 		if (ns->disk && revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
+			nvme_set_queue_dying(ns);
 		nvme_put_ns(ns);
 	} else
 		nvme_alloc_ns(ctrl, nsid);
@@ -3409,7 +3409,7 @@ static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
 			while (++prev < nsid) {
 				ns = nvme_find_get_ns(ctrl, prev);
 				if (ns) {
-					nvme_ns_remove(ns);
+					nvme_set_queue_dying(ns);
 					nvme_put_ns(ns);
 				}
 			}
@@ -3871,8 +3871,11 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (test_bit(NVME_NS_DEAD, &ns->flags))
+			continue;
 		blk_mq_quiesce_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_stop_queues);
@@ -3882,8 +3885,11 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	struct nvme_ns *ns;
 
 	down_read(&ctrl->namespaces_rwsem);
-	list_for_each_entry(ns, &ctrl->namespaces, list)
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (test_bit(NVME_NS_DEAD, &ns->flags))
+			continue;
 		blk_mq_unquiesce_queue(ns->queue);
+	}
 	up_read(&ctrl->namespaces_rwsem);
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
-- 
2.16.4
