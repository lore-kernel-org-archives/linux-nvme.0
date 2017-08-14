From: jsmart2021@gmail.com (James Smart)
Date: Mon, 14 Aug 2017 11:20:32 -0700
Subject: [PATCH] nvmet_fc: correct use after free on list teardown
Message-ID: <20170814182032.20755-1-jsmart2021@gmail.com>

Use list_for_each_entry_safe to prevent list handling from referencing
next pointers directly after list_del's

Signed-off-by: James Smart <james.smart at broadcom.com>
---
 drivers/nvme/target/fc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1b7f2520a20d..b200f9aadd52 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -704,7 +704,7 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 {
 	struct nvmet_fc_tgtport *tgtport = queue->assoc->tgtport;
 	struct nvmet_fc_fcp_iod *fod = queue->fod;
-	struct nvmet_fc_defer_fcp_req *deferfcp;
+	struct nvmet_fc_defer_fcp_req *deferfcp, *tempptr;
 	unsigned long flags;
 	int i, writedataactive;
 	bool disconnect;
@@ -735,7 +735,8 @@ nvmet_fc_delete_target_queue(struct nvmet_fc_tgt_queue *queue)
 	}
 
 	/* Cleanup defer'ed IOs in queue */
-	list_for_each_entry(deferfcp, &queue->avail_defer_list, req_list) {
+	list_for_each_entry_safe(deferfcp, tempptr, &queue->avail_defer_list,
+				req_list) {
 		list_del(&deferfcp->req_list);
 		kfree(deferfcp);
 	}
-- 
2.13.1
