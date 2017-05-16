From: jsmart2021@gmail.com (James Smart)
Date: Mon, 15 May 2017 17:10:22 -0700
Subject: [PATCH v2 08/10] nvme_fc: remove extra controller reference taken on
 reconnect
In-Reply-To: <20170516001024.5281-1-jsmart2021@gmail.com>
References: <20170516001024.5281-1-jsmart2021@gmail.com>
Message-ID: <20170516001024.5281-9-jsmart2021@gmail.com>

fix extra controller reference taken on reconnect by moving
reference to initial controller create

Signed-off-by: James Smart <james.smart at broadcom.com>
Reviewed-by: Hannes Reinecke <hare at suse.com>
---
v2: pre review: moved location of where ref taken
---
 drivers/nvme/host/fc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 8a721aa11387..78973407430a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2398,8 +2398,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 
 	ctrl->ctrl.opts->nr_reconnects = 0;
 
-	kref_get(&ctrl->ctrl.kref);
-
 	if (ctrl->queue_count > 1) {
 		nvme_start_queues(&ctrl->ctrl);
 		nvme_queue_scan(&ctrl->ctrl);
@@ -2800,7 +2798,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		ctrl->ctrl.opts = NULL;
 		/* initiate nvme ctrl ref counting teardown */
 		nvme_uninit_ctrl(&ctrl->ctrl);
-		nvme_put_ctrl(&ctrl->ctrl);
 
 		/* as we're past the point where we transition to the ref
 		 * counting teardown path, if we return a bad pointer here,
@@ -2816,6 +2813,8 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 		return ERR_PTR(ret);
 	}
 
+	kref_get(&ctrl->ctrl.kref);
+
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d}: new ctrl: NQN \"%s\"\n",
 		ctrl->cnum, ctrl->ctrl.opts->subsysnqn);
-- 
2.11.0
