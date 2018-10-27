From: jsmart2021@gmail.com (James Smart)
Date: Sat, 27 Oct 2018 12:42:45 -0700
Subject: [PATCH] nvme-fc: allow support for association_id to be zero
Message-ID: <20181027194245.4246-1-jsmart2021@gmail.com>

Current code assumed association_id would be some non-zero value.
But zero isn't prohibited by spec. Add support for the value being zero.

Signed-off-by: James Smart <jsmart2021 at gmail.com>
---
 drivers/nvme/host/fc.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e52b9d3c0bd6..fd6899e9fa2b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -152,6 +152,7 @@ struct nvme_fc_ctrl {
 
 	bool			ioq_live;
 	bool			assoc_active;
+	bool			assoc_id_valid;
 	u64			association_id;
 
 	struct list_head	ctrl_list;	/* rport->ctrl_list */
@@ -1274,6 +1275,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	} else {
 		ctrl->association_id =
 			be64_to_cpu(assoc_acc->associd.association_id);
+		ctrl->assoc_id_valid = true;
 		queue->connection_id =
 			be64_to_cpu(assoc_acc->connectid.connection_id);
 		set_bit(NVME_FC_Q_CONNECTED, &queue->flags);
@@ -1471,6 +1473,7 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 		kfree(lsop);
 
 	/* only meaningful part to terminating the association */
+	ctrl->assoc_id_valid = false;
 	ctrl->association_id = 0;
 }
 
@@ -2787,9 +2790,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 	 * send a Disconnect(association) LS to fc-nvme target
 	 * Note: could have been sent at top of process, but
 	 * cleaner on link traffic if after the aborts complete.
-	 * Note: if association doesn't exist, association_id will be 0
 	 */
-	if (ctrl->association_id)
+	if (ctrl->assoc_id_valid)
 		nvme_fc_xmt_disconnect_assoc(ctrl);
 
 	if (ctrl->ctrl.tagset) {
@@ -3007,6 +3009,7 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->cnum = idx;
 	ctrl->ioq_live = false;
 	ctrl->assoc_active = false;
+	ctrl->assoc_id_valid = false;
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	get_device(ctrl->dev);
-- 
2.13.7
