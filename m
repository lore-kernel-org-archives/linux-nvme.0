From: maxg@mellanox.com (Max Gurtovoy)
Date: Mon,  2 Apr 2018 15:46:45 +0300
Subject: [PATCH 1/1] nvme: check return value of init_srcu_struct function
Message-ID: <1522673205-18575-1-git-send-email-maxg@mellanox.com>

Also add error flow in case srcu initialization function fails.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 666e509..38b450e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2830,7 +2830,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 		goto out_free_head;
 	head->instance = ret;
 	INIT_LIST_HEAD(&head->list);
-	init_srcu_struct(&head->srcu);
+	ret = init_srcu_struct(&head->srcu);
+	if (ret)
+		goto out_ida_remove;
 	head->subsys = ctrl->subsys;
 	head->ns_id = nsid;
 	kref_init(&head->ref);
@@ -2852,6 +2854,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	return head;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
+out_ida_remove:
 	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
-- 
1.8.3.1
