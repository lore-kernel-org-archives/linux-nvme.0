From: sagig@mellanox.com (Sagi Grimberg)
Date: Sun, 10 Jan 2016 11:00:44 +0200
Subject: [PATCH RFC] nvme-core: Log the ctrl device instance name
Message-ID: <1452416444-22714-1-git-send-email-sagig@mellanox.com>

Having the ctrl instance name "nvmeX" seems much more friendly than
the underlying device name. Also, with other nvme transports
such as the soon to come nvme-loop we don't have an underlying
device and it doesn't makes sense to make up one.

Signed-off-by: Sagi Grimberg <sagig at mellanox.com>
---
 drivers/nvme/host/core.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e31a256127f7..f7214261b5da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -557,7 +557,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	unsigned short bs;
 
 	if (nvme_identify_ns(ns->ctrl, ns->ns_id, &id)) {
-		dev_warn(ns->ctrl->dev, "%s: Identify failure nvme%dn%d\n",
+		dev_warn(ns->ctrl->device, "%s: Identify failure nvme%dn%d\n",
 				__func__, ns->ctrl->instance, ns->ns_id);
 		return -ENODEV;
 	}
@@ -568,7 +568,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 
 	if (nvme_nvm_ns_supported(ns, id) && ns->type != NVME_NS_LIGHTNVM) {
 		if (nvme_nvm_register(ns->queue, disk->disk_name)) {
-			dev_warn(ns->ctrl->dev,
+			dev_warn(ns->ctrl->device,
 				"%s: LightNVM init failure\n", __func__);
 			kfree(id);
 			return -ENODEV;
@@ -741,7 +741,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->dev,
+			dev_err(ctrl->device,
 				"Device not ready; aborting %s\n", enabled ?
 						"initialisation" : "reset");
 			return -ENODEV;
@@ -781,7 +781,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 	int ret;
 
 	if (page_shift < dev_page_min) {
-		dev_err(ctrl->dev,
+		dev_err(ctrl->device,
 			"Minimum device page size %u too large for host (%u)\n",
 			1 << dev_page_min, 1 << page_shift);
 		return -ENODEV;
@@ -822,7 +822,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-			dev_err(ctrl->dev,
+			dev_err(ctrl->device,
 				"Device shutdown incomplete; abort shutdown\n");
 			return -ENODEV;
 		}
@@ -844,13 +844,13 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ret = ctrl->ops->reg_read32(ctrl, NVME_REG_VS, &ctrl->vs);
 	if (ret) {
-		dev_err(ctrl->dev, "Reading VS failed (%d)\n", ret);
+		dev_err(ctrl->device, "Reading VS failed (%d)\n", ret);
 		return ret;
 	}
 
 	ret = ctrl->ops->reg_read64(ctrl, NVME_REG_CAP, &cap);
 	if (ret) {
-		dev_err(ctrl->dev, "Reading CAP failed (%d)\n", ret);
+		dev_err(ctrl->device, "Reading CAP failed (%d)\n", ret);
 		return ret;
 	}
 	page_shift = NVME_CAP_MPSMIN(cap) + 12;
@@ -860,7 +860,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ret = nvme_identify_ctrl(ctrl, &id);
 	if (ret) {
-		dev_err(ctrl->dev, "Identify Controller failed (%d)\n", ret);
+		dev_err(ctrl->device, "Identify Controller failed (%d)\n", ret);
 		return -EIO;
 	}
 
@@ -969,7 +969,7 @@ static long nvme_dev_ioctl(struct file *file, unsigned int cmd,
 	case NVME_IOCTL_IO_CMD:
 		return nvme_dev_user_cmd(ctrl, argp);
 	case NVME_IOCTL_RESET:
-		dev_warn(ctrl->dev, "resetting controller\n");
+		dev_warn(ctrl->device, "resetting controller\n");
 		return ctrl->ops->reset_ctrl(ctrl);
 	case NVME_IOCTL_SUBSYS_RESET:
 		return nvme_reset_subsystem(ctrl);
-- 
1.8.4.3
