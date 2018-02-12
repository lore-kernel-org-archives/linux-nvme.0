From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Mon, 12 Feb 2018 20:54:44 +0800
Subject: [PATCH 1/3] nvme: fix the dangerous reference of namespaces list
Message-ID: <1518440086-583-1-git-send-email-jianchao.w.wang@oracle.com>

nvme_remove_namespaces and nvme_remove_invalid_namespaces reference
the ctrl->namespaces list w/o holding namespaces_mutext. It is ok
to invoke nvme_ns_remove there, but what if there is others.

To be safer, reference the ctrl->namespaces list under
namespaces_mutext.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2fd8688..d05855b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3094,11 +3094,18 @@ static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					unsigned nsid)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
+	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list) {
 		if (ns->head->ns_id > nsid)
-			nvme_ns_remove(ns);
+			list_move_tail(&ns->list, &rm_list);
 	}
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_ns_remove(ns);
+
 }
 
 static int nvme_scan_ns_list(struct nvme_ctrl *ctrl, unsigned nn)
@@ -3198,6 +3205,7 @@ EXPORT_SYMBOL_GPL(nvme_queue_scan);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_ns *ns, *next;
+	LIST_HEAD(ns_list);
 
 	/*
 	 * The dead states indicates the controller was not gracefully
@@ -3208,7 +3216,11 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	if (ctrl->state == NVME_CTRL_DEAD)
 		nvme_kill_queues(ctrl);
 
-	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
+	mutex_lock(&ctrl->namespaces_mutex);
+	list_splice_init(&ctrl->namespaces, &ns_list);
+	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &ns_list, list)
 		nvme_ns_remove(ns);
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
-- 
2.7.4
