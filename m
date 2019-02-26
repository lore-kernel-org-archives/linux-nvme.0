From: jsmart2021@gmail.com (James Smart)
Date: Tue, 26 Feb 2019 13:51:57 -0800
Subject: [PATCH v2] nvmet-fc: fix issues with targetport assoc_list list
 walking
Message-ID: <20190226215157.5887-1-jsmart2021@gmail.com>

There are two changes:

1) The logic in the __nvmet_fc_free_assoc() routine is bad. It uses
"safe" routines assuming pointers will come back valid. However,
the intervening next structure being linked can be removed from the
list and the resulting safe pointers are bad, resulting in NULL ptrs
being hit.

Correct by scheduling a work element to perform the association
delete, which can be done while under lock.

2) Prior patch that added the work element scheduling left a
possible reference on the object if the work element couldn't
be scheduled

Correct by doing the put on a failing schedule_work() call.

Signed-off-by: Nigel Kirkland <nigel.kirkland at broadcom.com>
Signed-off-by: James Smart <jsmart2021 at gmail.com>

---
v2: correct missing "!" not in scheduling work in ctrl_delete
---
 drivers/nvme/target/fc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1e9654f04c60..6b7bbf39fa06 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1143,10 +1143,8 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 				&tgtport->assoc_list, a_list) {
 		if (!nvmet_fc_tgt_a_get(assoc))
 			continue;
-		spin_unlock_irqrestore(&tgtport->lock, flags);
-		nvmet_fc_delete_target_assoc(assoc);
-		nvmet_fc_tgt_a_put(assoc);
-		spin_lock_irqsave(&tgtport->lock, flags);
+		if (!schedule_work(&assoc->del_work))
+			nvmet_fc_tgt_a_put(assoc);
 	}
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
@@ -1185,7 +1183,8 @@ nvmet_fc_delete_ctrl(struct nvmet_ctrl *ctrl)
 		nvmet_fc_tgtport_put(tgtport);
 
 		if (found_ctrl) {
-			schedule_work(&assoc->del_work);
+			if (!schedule_work(&assoc->del_work))
+				nvmet_fc_tgt_a_put(assoc);
 			return;
 		}
 
-- 
2.13.7
