From: hch@lst.de (Christoph Hellwig)
Date: Sat,  7 Nov 2015 18:00:41 +0100
Subject: [PATCH 6/8] nvme: export symbols needed for nvme-loop
In-Reply-To: <1446915643-21175-1-git-send-email-hch@lst.de>
References: <1446915643-21175-1-git-send-email-hch@lst.de>
Message-ID: <1446915643-21175-7-git-send-email-hch@lst.de>

Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 14ee152..400b1ea 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -36,10 +36,12 @@
 unsigned char admin_timeout = 60;
 module_param(admin_timeout, byte, 0644);
 MODULE_PARM_DESC(admin_timeout, "timeout in seconds for admin commands");
+EXPORT_SYMBOL_GPL(admin_timeout);
 
 unsigned char nvme_io_timeout = 30;
 module_param_named(io_timeout, nvme_io_timeout, byte, 0644);
 MODULE_PARM_DESC(io_timeout, "timeout in seconds for I/O");
+EXPORT_SYMBOL_GPL(nvme_io_timeout);
 
 static unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
@@ -97,6 +99,7 @@ void nvme_requeue_req(struct request *req)
 		blk_mq_kick_requeue_list(req->q);
 	spin_unlock_irqrestore(req->q->queue_lock, flags);
 }
+EXPORT_SYMBOL_GPL(nvme_requeue_req);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, bool nowait)
@@ -324,6 +327,7 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 
 	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
 }
+EXPORT_SYMBOL_GPL(nvme_set_features);
 
 int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
 {
@@ -363,6 +367,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int count)
 	}
 	return min(result & 0xffff, result >> 16) + 1;
 }
+EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 static int nvme_update_ctrl_config(struct nvme_ctrl *ctrl, u64 cap,
 		bool enabled)
@@ -407,6 +412,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 
 	return nvme_update_ctrl_config(ctrl, cap, false);
 }
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap, unsigned page_shift)
 {
@@ -418,6 +424,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap, unsigned page_shift)
 
 	return nvme_update_ctrl_config(ctrl, cap, true);
 }
+EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -448,6 +455,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 
 	return error;
 }
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
@@ -851,6 +859,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	kfree(id);
 	return 0;
 }
+EXPORT_SYMBOL(nvme_init_identify);
 
 static int nvme_dev_open(struct inode *inode, struct file *file)
 {
@@ -1071,6 +1080,7 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 	__nvme_scan_namespaces(ctrl, le32_to_cpup(&id->nn));
 	kfree(id);
 }
+EXPORT_SYMBOL_GPL(nvme_scan_namespaces);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
@@ -1079,6 +1089,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 	list_for_each_entry_safe(ns, next, &ctrl->namespaces, list)
 		nvme_ns_remove(ns);
 }
+EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
 static DEFINE_IDA(nvme_instance_ida);
 
@@ -1118,6 +1129,7 @@ void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
 }
+EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
 static void nvme_free_ctrl(struct kref *kref)
 {
@@ -1133,6 +1145,7 @@ void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 {
 	kref_put(&ctrl->kref, nvme_free_ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_put_ctrl);
 
 /*
  * Initialize a NVMe controller structures.  This needs to be called during
@@ -1184,6 +1197,7 @@ out_release_instance:
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
 int __init nvme_core_init(void)
 {
-- 
1.9.1
