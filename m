From: hare@suse.de (Hannes Reinecke)
Date: Wed,  3 Jul 2019 15:12:32 +0200
Subject: [PATCH 2/2] nvme-multipath: do not select namespaces which are about
 to be removed
In-Reply-To: <20190703131232.58595-1-hare@suse.de>
References: <20190703131232.58595-1-hare@suse.de>
Message-ID: <20190703131232.58595-3-hare@suse.de>

nvme_ns_remove() will first set the NVME_NS_REMOVING flag before removing
it from the list at the very last step.
So to avoid selecting a namespace in nvme_find_path() which is about to be
removed check the NVME_NS_REMOVING flag, too, when selecting a new path.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index c8cc82639327..1f6105a5c596 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -130,7 +130,8 @@ static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
 		if (ns->ctrl->state != NVME_CTRL_LIVE ||
-		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		    test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+		    test_bit(NVME_NS_REMOVING, &ns->flags))
 			continue;
 
 		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
@@ -180,7 +181,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 
 	if (list_is_singular(&head->list)) {
 		if (old->ctrl->state != NVME_CTRL_LIVE ||
-		    test_bit(NVME_NS_ANA_PENDING, &old->flags))
+		    test_bit(NVME_NS_ANA_PENDING, &old->flags)||
+		    test_bit(NVME_NS_REMOVING, &old->flags))
 			return NULL;
 		return old;
 	}
@@ -189,7 +191,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 	     ns != old;
 	     ns = nvme_next_ns(head, ns)) {
 		if (ns->ctrl->state != NVME_CTRL_LIVE ||
-		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		    test_bit(NVME_NS_ANA_PENDING, &ns->flags) ||
+		    test_bit(NVME_NS_REMOVING, &ns->flags))
 			continue;
 
 		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
-- 
2.16.4
