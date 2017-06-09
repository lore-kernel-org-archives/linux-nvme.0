From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Fri,  9 Jun 2017 16:17:21 +0200
Subject: [PATCH v2] nvme: use ctrl->device consistently for logging
Message-ID: <20170609141721.10199-1-jthumshirn@suse.de>

Change the few left over users of ctrl->dev over to using ctrl->device
for logging purposes, so we consistently use the same device.

Signed-off-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---

Changes to v1:
* Fix build 

 drivers/nvme/host/core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

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
 
-- 
2.12.3
