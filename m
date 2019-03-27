From: hare@suse.de (Hannes Reinecke)
Date: Wed, 27 Mar 2019 09:09:29 +0100
Subject: [PATCH 3/3] nvme-multipath: test namespace state when selecting a new
 path
In-Reply-To: <20190327080929.27918-1-hare@suse.de>
References: <20190327080929.27918-1-hare@suse.de>
Message-ID: <20190327080929.27918-4-hare@suse.de>

When selecting a new path we need to check if the namespace is
not about to be removed.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f69c9476d663..a87462efc927 100644
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
@@ -185,7 +186,8 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
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
