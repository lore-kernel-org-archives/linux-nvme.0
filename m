From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Nov 2017 13:36:50 -0700
Subject: [PATCH 2/2] nvme: Suppress static analyis warning
In-Reply-To: <20171116203650.19591-1-keith.busch@intel.com>
References: <20171116203650.19591-1-keith.busch@intel.com>
Message-ID: <20171116203650.19591-2-keith.busch@intel.com>

The ns->head is always valid, so we don't need to check for NULL.

Reported-by: Dan Carpenter <dan.caprenter at oracle.com>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2ab4e440bea..f837d666cbd4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2961,8 +2961,6 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 static void nvme_ns_remove(struct nvme_ns *ns)
 {
-	struct nvme_ns_head *head = ns->head;
-
 	if (test_and_set_bit(NVME_NS_REMOVING, &ns->flags))
 		return;
 
@@ -2980,15 +2978,14 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	mutex_lock(&ns->ctrl->subsys->lock);
 	nvme_mpath_clear_current_path(ns);
-	if (head)
-		list_del_rcu(&ns->siblings);
+	list_del_rcu(&ns->siblings);
 	mutex_unlock(&ns->ctrl->subsys->lock);
 
 	mutex_lock(&ns->ctrl->namespaces_mutex);
 	list_del_init(&ns->list);
 	mutex_unlock(&ns->ctrl->namespaces_mutex);
 
-	synchronize_srcu(&head->srcu);
+	synchronize_srcu(&ns->head->srcu);
 	nvme_put_ns(ns);
 }
 
-- 
2.13.6
