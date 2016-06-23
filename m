From: keith.busch@intel.com (Keith Busch)
Date: Thu, 23 Jun 2016 11:29:06 -0600
Subject: [PATCH 3/3] nvme: Put invalid namespaces on removal list
In-Reply-To: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
References: <1466702946-13065-1-git-send-email-keith.busch@intel.com>
Message-ID: <1466702946-13065-4-git-send-email-keith.busch@intel.com>

This patch puts invalid namespaces on a temporary removal list so they
are not part of the controller's namespace list during their remova tol
allow locked list traversal when scanning for invalid namespaces. This
addresses one of the last unlocked namespace list iterations.

The actual namespace removal runs unlocked on the local removal list. The
invalid namespaces do not need to be on the controller list since removing
them disables the queues from doing IO.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 43d6947..a56b394 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1571,11 +1571,19 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
-		if (ns->ns_id > nsid)
-			nvme_remove_dead_ns(ns);
+		if (ns->ns_id > nsid) {
+			list_del_init(&ns->list);
+			list_add_tail(&ns->list, &rm_list);
+		}
 	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_remove_dead_ns(ns);
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
-- 
2.7.2
