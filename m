From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 18:22:03 +0300
Subject: [PATCH rfc 29/30] nvme: add sed-opal ctrl manipulation in admin
 configuration
In-Reply-To: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
References: <1497799324-19598-1-git-send-email-sagi@grimberg.me>
Message-ID: <1497799324-19598-30-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 476c49c0601f..f4800b8e47a0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2493,6 +2493,7 @@ static void nvme_free_ctrl(struct kref *kref)
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
 	ida_destroy(&ctrl->ns_ida);
+	free_opal_dev(ctrl->opal_dev);
 
 	ctrl->ops->free_ctrl(ctrl);
 }
@@ -2814,6 +2815,7 @@ EXPORT_SYMBOL_GPL(nvme_destroy_admin_queue);
 
 int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
+	bool was_suspend = !!(ctrl->ctrl_config & NVME_CC_SHN_NORMAL);
 	int error;
 
 	error = ctrl->ops->alloc_hw_queue(ctrl, 0, NVME_AQ_DEPTH);
@@ -2868,6 +2870,16 @@ int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_connect_queue;
 
+	if (ctrl->oacs & NVME_CTRL_OACS_SEC_SUPP) {
+		if (!ctrl->opal_dev)
+			ctrl->opal_dev = init_opal_dev(ctrl, &nvme_sec_submit);
+		else if (was_suspend)
+			opal_unlock_from_suspend(ctrl->opal_dev);
+	} else {
+		free_opal_dev(ctrl->opal_dev);
+		ctrl->opal_dev = NULL;
+	}
+
 	nvme_start_keep_alive(ctrl);
 
 	return 0;
-- 
2.7.4
