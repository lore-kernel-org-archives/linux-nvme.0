From: keith.busch@intel.com (Keith Busch)
Date: Mon, 19 Mar 2018 10:53:50 -0600
Subject: [PATCH] nvme: Skip checking heads without namespaces
Message-ID: <20180319165350.9879-1-keith.busch@intel.com>

If a task is holding a reference to a namespace on a removed controller,
the head will not be released. If the same controller is added again
later, its namespaces may not be successfully added. Instead, the user
will see kernel message "Duplicate IDs for nsid <X>".

This patch fixes that by skipping heads that don't have namespaces when
considering if a new namespace is safe to add.

Reported-by: Alex Gagniuc <Alex_Gagniuc at Dellteam.com>
Cc: stable at vger.kernel.org
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 7aeca5db7916..0b9e60861e53 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2793,6 +2793,7 @@ static int __nvme_check_ids(struct nvme_subsystem *subsys,
 
 	list_for_each_entry(h, &subsys->nsheads, entry) {
 		if (nvme_ns_ids_valid(&new->ids) &&
+		    !list_empty(&h->list) &&
 		    nvme_ns_ids_equal(&new->ids, &h->ids))
 			return -EINVAL;
 	}
-- 
2.14.3
