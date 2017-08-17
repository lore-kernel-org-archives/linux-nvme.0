From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Thu, 17 Aug 2017 09:41:53 +0300
Subject: [PATCH] nvmet_fc: use list_for_each_safe()
Message-ID: <20170817064023.daho5p5dncqhqdar@mwanda>

We are freeing the list and the current code dereferences "deferfcp"
after it's freed.  Let's use list_for_each_entry_safe() instead.

Fixes: 0fb228d30b8d ("nvmet_fc: add defer_req callback for deferment of cmd buffer return")
Signed-off-by: Dan Carpenter <dan.carpenter at oracle.com>

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b7f2520a20d..a42158c83f25 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -704,7 +704,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 {
 	struct nvmet_fc_tgtport *tgtport = queue->assoc->tgtport;
 	struct nvmet_fc_fcp_iod *fod = queue->fod;
-	struct nvmet_fc_defer_fcp_req *deferfcp;
+	struct nvmet_fc_defer_fcp_req *deferfcp, *next;
 	unsigned long flags;
 	int i, writedataactive;
 	bool disconnect;
@@ -735,7 +735,8 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	}
 
 	/* Cleanup defer'ed IOs in queue */
-	list_for_each_entry(deferfcp, &queue->avail_defer_list, req_list) {
+	list_for_each_entry_safe(deferfcp, next, &queue->avail_defer_list,
+				 req_list) {
 		list_del(&deferfcp->req_list);
 		kfree(deferfcp);
 	}
