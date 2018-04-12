From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:12 -0600
Subject: [PATCH 10/13] nvme: check return value of init_srcu_struct function
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-11-keith.busch@intel.com>

From: Max Gurtovoy <maxg@mellanox.com>

Also add error flow in case srcu initialization function fails.

Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 695e52ae22fd..b09940c556d0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2832,7 +2832,9 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
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
@@ -2854,6 +2856,7 @@ static struct nvme_ns_head *nvme_alloc_ns_head(struct nvme_ctrl *ctrl,
 	return head;
 out_cleanup_srcu:
 	cleanup_srcu_struct(&head->srcu);
+out_ida_remove:
 	ida_simple_remove(&ctrl->subsys->ns_ida, head->instance);
 out_free_head:
 	kfree(head);
-- 
2.14.3
