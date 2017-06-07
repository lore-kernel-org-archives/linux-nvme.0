From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Wed,  7 Jun 2017 11:51:18 +0200
Subject: [PATCH v6 10/10] nvme: use ctrl->device consistently for logging
Message-ID: <20170607095118.32557-1-jthumshirn@suse.de>

Change the few left over users of ctrl->dev over to using ctrl->device
for logging purposes, so we consistently use the same device.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
---
 drivers/nvme/host/core.c | 10 +++++-----
 drivers/nvme/host/fc.c   | 12 ++++++------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 462187a4047b..c427a7fc31ae 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -823,7 +823,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 	 * access to the admin queue, as that might be only way to fix them up.
 	 */
 	if (status > 0) {
-		dev_err(ctrl->dev, "Could not set queue count (%d)\n", status);
+		dev_err(ctrl->device, "Could not set queue count (%d)\n", status);
 		*count = 0;
 	} else {
 		nr_io_queues = min(result & 0xffff, result >> 16) + 1;
@@ -1658,7 +1658,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	}
 
 	if (force_apst && (ctrl->quirks & NVME_QUIRK_NO_DEEPEST_PS)) {
-		dev_warn(ctrl->dev, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
+		dev_warn(ctrl->device, "forcibly allowing all power states due to nvme_core.force_apst -- use at your own risk\n");
 		ctrl->quirks &= ~NVME_QUIRK_NO_DEEPEST_PS;
 	}
 
@@ -1686,7 +1686,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	prev_apsta = ctrl->apsta;
 	if (ctrl->quirks & NVME_QUIRK_NO_APST) {
 		if (force_apst && id->apsta) {
-			dev_warn(ctrl->dev, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
+			dev_warn(ctrl->device, "forcibly allowing APST due to nvme_core.force_apst -- use at your own risk\n");
 			ctrl->apsta = 1;
 		} else {
 			ctrl->apsta = 0;
@@ -1710,7 +1710,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 			ret = -EINVAL;
 
 		if (!ctrl->opts->discovery_nqn && !ctrl->kas) {
-			dev_err(ctrl->dev,
+			dev_err(ctrl->device,
 				"keep-alive support is mandatory for fabrics\n");
 			ret = -EINVAL;
 		}
@@ -2155,7 +2155,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 
 	if (nvme_nvm_ns_supported(ns, id) &&
 				nvme_nvm_register(ns, disk_name, node)) {
-		dev_warn(ctrl->dev, "%s: LightNVM init failure\n", __func__);
+		dev_warn(ctrl->device, "%s: LightNVM init failure\n", __func__);
 		goto out_free_id;
 	}
 
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 96b983bb44bd..cab459d63df5 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -928,7 +928,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 
 	if (fcret) {
 		ret = -EBADF;
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"q %d connect failed: %s\n",
 			queue->qnum, validation_errors[fcret]);
 	} else {
@@ -943,7 +943,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
 	kfree(lsop);
 out_no_memory:
 	if (ret)
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"queue %d connect admin queue failed (%d).\n",
 			queue->qnum, ret);
 	return ret;
@@ -1027,7 +1027,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 
 	if (fcret) {
 		ret = -EBADF;
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"q %d connect failed: %s\n",
 			queue->qnum, validation_errors[fcret]);
 	} else {
@@ -1040,7 +1040,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	kfree(lsop);
 out_no_memory:
 	if (ret)
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"queue %d connect command failed (%d).\n",
 			queue->qnum, ret);
 	return ret;
@@ -1408,7 +1408,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 	op->fcp_req.cmddma = fc_dma_map_single(ctrl->lport->dev,
 				&op->cmd_iu, sizeof(op->cmd_iu), DMA_TO_DEVICE);
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.cmddma)) {
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"FCP Op failed - cmdiu dma mapping failed.\n");
 		ret = EFAULT;
 		goto out_on_error;
@@ -1418,7 +1418,7 @@ __nvme_fc_init_request(struct nvme_fc_ctrl *ctrl,
 				&op->rsp_iu, sizeof(op->rsp_iu),
 				DMA_FROM_DEVICE);
 	if (fc_dma_mapping_error(ctrl->lport->dev, op->fcp_req.rspdma)) {
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"FCP Op failed - rspiu dma mapping failed.\n");
 		ret = EFAULT;
 	}
-- 
2.12.3
