From: nitzanc@mellanox.com (Nitzan Carmi)
Date: Mon,  9 Apr 2018 17:50:26 +0300
Subject: [PATCH] nvme: avoid flush dependency in delete controller flow
In-Reply-To: <20180409065007.GA7760@lst.de>
References: <20180409065007.GA7760@lst.de>
Message-ID: <1523285426-26526-1-git-send-email-nitzanc@mellanox.com>

nvme_delete_ctrl queues a work on a MEM_RECLAIM queue
(nvme_delete_wq), which eventually calls cleanup_srcu_struct,
which in turn flushes a delayed work from an !MEM_RECLAIM
queue. This is unsafe as we might trigger deadlocks under
severe memory pressure.

Since we don't ever invoke call_srcu(), it is safe
to use the _quiesced() version of srcu cleanup, and
avoid that flush dependency.

Signed-off-by: Nitzan Carmi <nitzanc at mellanox.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 197a6ba9700f..0ef5c495ca07 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -349,7 +349,7 @@ static void nvme_free_ns_head(struct kref *ref)
 	nvme_mpath_remove_disk(head);
 	ida_simple_remove(&head->subsys->ns_ida, head->instance);
 	list_del_init(&head->entry);
-	cleanup_srcu_struct(&head->srcu);
+	cleanup_srcu_struct_quiesced(&head->srcu);
 	kfree(head);
 }
 
-- 
2.14.1
