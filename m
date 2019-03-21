From: hare@suse.de (Hannes Reinecke)
Date: Thu, 21 Mar 2019 15:10:33 +0100
Subject: [PATCH] nvme: schedule requeue whenever a LIVE state is entered
Message-ID: <20190321141033.131308-1-hare@suse.de>

When undergoing state transitions I/O might be requeued, hence
we always have to schedule requeue_work whenever the nvme device
is live, independent on whether the old state was live or not.

Reported-by: Martin George <martin.george at netapp.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2839bb70badf..f69c9476d663 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -352,8 +352,6 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 			__nvme_find_path(head, node);
 		srcu_read_unlock(&head->srcu, srcu_idx);
 	}
-
-	kblockd_schedule_work(&ns->head->requeue_work);
 }
 
 static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
@@ -412,8 +410,11 @@ static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
-	if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
-		nvme_mpath_set_live(ns);
+	if (nvme_state_is_live(ns->ana_state)) {
+		if (!nvme_state_is_live(old))
+			nvme_mpath_set_live(ns);
+		kblockd_schedule_work(&ns->head->requeue_work);
+	}
 	mutex_unlock(&ns->head->lock);
 }
 
@@ -587,6 +588,7 @@ void nvme_mpath_add_disk(struct nvme_ns *ns, struct nvme_id_ns *id)
 		mutex_lock(&ns->head->lock);
 		ns->ana_state = NVME_ANA_OPTIMIZED; 
 		nvme_mpath_set_live(ns);
+		kblockd_schedule_work(&ns->head->requeue_work);
 		mutex_unlock(&ns->head->lock);
 	}
 }
-- 
2.16.4
