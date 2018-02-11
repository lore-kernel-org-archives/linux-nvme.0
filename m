From: jianchao.w.wang@oracle.com (Jianchao Wang)
Date: Sun, 11 Feb 2018 17:38:33 +0800
Subject: [PATCH 2/9] nvme: fix the deadlock in nvme_update_formats
In-Reply-To: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1518341920-1060-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1518341920-1060-3-git-send-email-jianchao.w.wang@oracle.com>

nvme_update_formats will invoke nvme_ns_remove under namespaces_mutext.
The will cause deadlock because nvme_ns_remove will also require
the namespaces_mutext. Fix it by getting the ns entries which should
be removed under namespaces_mutext and invoke nvme_ns_remove out of
namespaces_mutext.

Signed-off-by: Jianchao Wang <jianchao.w.wang at oracle.com>
---
 drivers/nvme/host/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bc05bc4..7425124 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1117,14 +1117,20 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
-	struct nvme_ns *ns;
+	struct nvme_ns *ns, *next;
+	LIST_HEAD(rm_list);
 
 	mutex_lock(&ctrl->namespaces_mutex);
 	list_for_each_entry(ns, &ctrl->namespaces, list) {
-		if (ns->disk && nvme_revalidate_disk(ns->disk))
-			nvme_ns_remove(ns);
+		if (ns->disk && nvme_revalidate_disk(ns->disk)) {
+			list_del_init(&ns->list);
+			list_add_tail(&ns->list, &rm_list);
+		}
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
+
+	list_for_each_entry_safe(ns, next, &rm_list, list)
+		nvme_ns_remove(ns);
 }
 
 static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
-- 
2.7.4
