From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Aug 2017 12:52:24 +0300
Subject: [PATCH 11/12] nvme: add sed-opal ctrl manipulation in admin
 configuration
In-Reply-To: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
References: <1502790745-12569-1-git-send-email-sagi@grimberg.me>
Message-ID: <1502790745-12569-12-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4344adff7134..19aa68f1fb4a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2743,6 +2743,7 @@ static void nvme_free_ctrl(struct kref *kref)
 	put_device(ctrl->device);
 	nvme_release_instance(ctrl);
 	ida_destroy(&ctrl->ns_ida);
+	free_opal_dev(ctrl->opal_dev);
 
 	ctrl->ops->free_ctrl(ctrl);
 }
@@ -3007,6 +3008,7 @@ EXPORT_SYMBOL_GPL(nvme_destroy_admin_queue);
 
 int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 {
+	bool was_suspend = !!(ctrl->ctrl_config & NVME_CC_SHN_NORMAL);
 	int error;
 
 	error = ctrl->ops->alloc_admin_queue(ctrl);
@@ -3052,6 +3054,16 @@ int nvme_configure_admin_queue(struct nvme_ctrl *ctrl, bool new)
 	if (error)
 		goto out_cleanup_queue;
 
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
 	return 0;
 
 out_cleanup_queue:
-- 
2.7.4
