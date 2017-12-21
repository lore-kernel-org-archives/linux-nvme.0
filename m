From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 21 Dec 2017 15:07:27 +0200
Subject: [PATCH 4.15] nvme-mpath: fix last path removal during traffic
Message-ID: <20171221130727.1023-1-sagi@grimberg.me>

In case our last path is removed during traffic, we
can end up requeueing the bio(s) but never schedule
the actual requeue work as upper layers still have
open handles on the mpath device node.

Fix this by scheduling requeue work if the namespace
being removed is last path in ns_head path list.

Fixes: 32acab3181c7 ("nvme: implement multipath access to nvme subsystems")
Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c |  1 +
 drivers/nvme/host/nvme.h | 12 ++++++++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 12fe1704437b..2e9a3889074e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3002,6 +3002,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
 
 	synchronize_srcu(&ns->head->srcu);
+	nvme_mpath_check_last_path(ns);
 	nvme_put_ns(ns);
 }
 
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4361b71891e9..28d1f586619d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -422,6 +422,15 @@ static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 		rcu_assign_pointer(head->current_path, NULL);
 }
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+
+static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+
+	if (head->disk && list_empty(&head->list))
+		kblockd_schedule_work(&head->requeue_work);
+}
+
 #else
 static inline void nvme_failover_req(struct request *req)
 {
@@ -453,6 +462,9 @@ static inline void nvme_mpath_remove_disk_links(struct nvme_ns *ns)
 static inline void nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 }
+static inline void nvme_mpath_check_last_path(struct nvme_ns *ns)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 #ifdef CONFIG_NVM
-- 
2.14.1
