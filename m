From: hare@suse.de (Hannes Reinecke)
Date: Thu,  4 Jul 2019 08:10:46 +0200
Subject: [PATCH 1/2] nvme-multipath: check singular list in
 vme_round_robin_path()
In-Reply-To: <20190704061047.94976-1-hare@suse.de>
References: <20190704061047.94976-1-hare@suse.de>
Message-ID: <20190704061047.94976-2-hare@suse.de>

When we have a singular list in nvme_round_robin_path() we still
need to check its validity.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/multipath.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 499acf07d61a..9b6dc11fa559 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -123,14 +123,19 @@ void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 	}
 }
 
+static bool nvme_path_is_disabled(struct nvme_ns *ns)
+{
+	return ns->ctrl->state != NVME_CTRL_LIVE ||
+		test_bit(NVME_NS_ANA_PENDING, &ns->flags);
+}
+
 static struct nvme_ns *__nvme_find_path(struct nvme_ns_head *head, int node)
 {
 	int found_distance = INT_MAX, fallback_distance = INT_MAX, distance;
 	struct nvme_ns *found = NULL, *fallback = NULL, *ns;
 
 	list_for_each_entry_rcu(ns, &head->list, siblings) {
-		if (ns->ctrl->state != NVME_CTRL_LIVE ||
-		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		if (nvme_path_is_disabled(ns))
 			continue;
 
 		if (READ_ONCE(head->subsys->iopolicy) == NVME_IOPOLICY_NUMA)
@@ -178,14 +183,16 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head,
 {
 	struct nvme_ns *ns, *found, *fallback = NULL;
 
-	if (list_is_singular(&head->list))
+	if (list_is_singular(&head->list)) {
+		if (nvme_path_is_disabled(old))
+			return NULL;
 		return old;
+	}
 
 	for (ns = nvme_next_ns(head, old);
 	     ns != old;
 	     ns = nvme_next_ns(head, ns)) {
-		if (ns->ctrl->state != NVME_CTRL_LIVE ||
-		    test_bit(NVME_NS_ANA_PENDING, &ns->flags))
+		if (nvme_path_is_disabled(ns))
 			continue;
 
 		if (ns->ana_state == NVME_ANA_OPTIMIZED) {
-- 
2.16.4
