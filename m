From: hare@suse.de (Hannes Reinecke)
Date: Wed, 27 Mar 2019 09:52:56 +0100
Subject: [PATCHv2] nvme-multipath: relax ANA state check
Message-ID: <20190327085256.28724-1-hare@suse.de>

From: Martin George <marting@netapp.com>

When undergoing state transitions I/O might be requeued, hence
we should always call nvme_mpath_set_live() to schedule requeue_work
whenever the nvme device is live, independent on whether the
old state was live or not.

Signed-off-by: Martin George <marting at netapp.com>
Signed-off-by: Gargi Srinivas <sring at netapp.com>
Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2839bb70badf..f0716f6ce41f 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -404,15 +404,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
-	enum nvme_ana_state old;
-
 	mutex_lock(&ns->head->lock);
-	old = ns->ana_state;
 	ns->ana_grpid = le32_to_cpu(desc->grpid);
 	ns->ana_state = desc->state;
 	clear_bit(NVME_NS_ANA_PENDING, &ns->flags);
 
-	if (nvme_state_is_live(ns->ana_state) && !nvme_state_is_live(old))
+	if (nvme_state_is_live(ns->ana_state))
 		nvme_mpath_set_live(ns);
 	mutex_unlock(&ns->head->lock);
 }
-- 
2.16.4
