From: martinus.gpy@gmail.com (martinus.gpy@gmail.com)
Date: Mon, 28 Jan 2019 19:54:46 +0530
Subject: [PATCH] nvme-multipath: relax ANA state check
Message-ID: <20190128142446.6732-1-marting@netapp.com>

From: Martin George <marting@netapp.com>

Always call nvme_mpath_set_live() when transitioning to a live
state, where live is defined as ANA Optimized or Non-Optimized,
irrespective of what the previous asymmetric access state was.
This removes the restriction of only permitting transitions
from states that were not considered live.

Signed-off-by: Martin George <marting at netapp.com>
Signed-off-by: Gargi Srinivas <sring at netapp.com>
---
 drivers/nvme/host/multipath.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index b9fff3b8ed1b..23da7beadd62 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -366,15 +366,12 @@ static inline bool nvme_state_is_live(enum nvme_ana_state state)
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
2.17.1
