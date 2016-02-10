From: mlin@kernel.org (Ming Lin)
Date: Wed, 10 Feb 2016 10:03:32 -0800
Subject: [PATCH v3 4/4] nvme: split pci module out of core module
In-Reply-To: <1455127412-23940-1-git-send-email-mlin@kernel.org>
References: <1455127412-23940-1-git-send-email-mlin@kernel.org>
Message-ID: <1455127412-23940-5-git-send-email-mlin@kernel.org>

From: Ming Lin <ming.l@ssi.samsung.com>

NVMe over Fabrics drivers are going to reuse the core,
so splits nvme.ko into 2 modules:

nvme-core.ko: the core part
nvme.ko: the PCI driver

Export symbols from nvme-core.ko.

Reviewed-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>
---
 drivers/nvme/host/Kconfig  |  6 +++++-
 drivers/nvme/host/Makefile | 10 ++++++----
 drivers/nvme/host/core.c   | 24 +++++++++++++++++++++++-
 drivers/nvme/host/pci.c    | 13 +------------
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 5d62373..2ed30f0 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -1,6 +1,10 @@
+config NVME_CORE
+	tristate
+
 config BLK_DEV_NVME
 	tristate "NVM Express block device"
 	depends on PCI && BLOCK
+	select NVME_CORE
 	---help---
 	  The NVM Express driver is for solid state drives directly
 	  connected to the PCI or PCI Express bus.  If you know you
@@ -11,7 +15,7 @@ config BLK_DEV_NVME
 
 config BLK_DEV_NVME_SCSI
 	bool "SCSI emulation for NVMe device nodes"
-	depends on BLK_DEV_NVME
+	depends on NVME_CORE
 	---help---
 	  This adds support for the SG_IO ioctl on the NVMe character
 	  and block devices nodes, as well a a translation for a small
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 51bf908..9a3ca89 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -1,6 +1,8 @@
+obj-$(CONFIG_NVME_CORE)			+= nvme-core.o
+obj-$(CONFIG_BLK_DEV_NVME)		+= nvme.o
 
-obj-$(CONFIG_BLK_DEV_NVME)     += nvme.o
+nvme-core-y				:= core.o
+nvme-core-$(CONFIG_BLK_DEV_NVME_SCSI)	+= scsi.o
+nvme-core-$(CONFIG_NVM)			+= lightnvm.o
 
-lightnvm-$(CONFIG_NVM)			:= lightnvm.o
-nvme-y					+= core.o pci.o $(lightnvm-y)
-nvme-$(CONFIG_BLK_DEV_NVME_SCSI)        += scsi.o
+nvme-y					+= pci.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 38db08d..c7df0ab 100644
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
 
 unsigned char shutdown_timeout = 5;
 module_param(shutdown_timeout, byte, 0644);
@@ -110,6 +112,7 @@ void nvme_requeue_req(struct request *req)
 		blk_mq_kick_requeue_list(req->q);
 	spin_unlock_irqrestore(req->q->queue_lock, flags);
 }
+EXPORT_SYMBOL_GPL(nvme_requeue_req);
 
 struct request *nvme_alloc_request(struct request_queue *q,
 		struct nvme_command *cmd, unsigned int flags)
@@ -133,6 +136,7 @@ struct request *nvme_alloc_request(struct request_queue *q,
 
 	return req;
 }
+EXPORT_SYMBOL_GPL(nvme_alloc_request);
 
 /*
  * Returns 0 on success.  If the result is negative, it's a Linux error code;
@@ -170,6 +174,7 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 {
 	return __nvme_submit_sync_cmd(q, cmd, buffer, bufflen, NULL, 0);
 }
+EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
 int __nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 		void __user *ubuffer, unsigned bufflen,
@@ -385,6 +390,7 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 	*count = min(*count, nr_io_queues);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
@@ -794,6 +800,7 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 		return ret;
 	return nvme_wait_ready(ctrl, cap, false);
 }
+EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 {
@@ -825,6 +832,7 @@ int nvme_enable_ctrl(struct nvme_ctrl *ctrl, u64 cap)
 		return ret;
 	return nvme_wait_ready(ctrl, cap, true);
 }
+EXPORT_SYMBOL_GPL(nvme_enable_ctrl);
 
 int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 {
@@ -855,6 +863,7 @@ int nvme_shutdown_ctrl(struct nvme_ctrl *ctrl)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_shutdown_ctrl);
 
 /*
  * Initialize the cached copies of the Identify data and various controller
@@ -916,6 +925,7 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 	kfree(id);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(nvme_init_identify);
 
 static int nvme_dev_open(struct inode *inode, struct file *file)
 {
@@ -1321,6 +1331,7 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 	mutex_unlock(&ctrl->namespaces_mutex);
 	kfree(id);
 }
+EXPORT_SYMBOL_GPL(nvme_scan_namespaces);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 {
@@ -1331,6 +1342,7 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 		nvme_ns_remove(ns);
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
+EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
 static DEFINE_IDA(nvme_instance_ida);
 
@@ -1362,13 +1374,14 @@ static void nvme_release_instance(struct nvme_ctrl *ctrl)
 }
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
- {
+{
 	device_destroy(nvme_class, MKDEV(nvme_char_major, ctrl->instance));
 
 	spin_lock(&dev_list_lock);
 	list_del(&ctrl->node);
 	spin_unlock(&dev_list_lock);
 }
+EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
 
 static void nvme_free_ctrl(struct kref *kref)
 {
@@ -1384,6 +1397,7 @@ void nvme_put_ctrl(struct nvme_ctrl *ctrl)
 {
 	kref_put(&ctrl->kref, nvme_free_ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_put_ctrl);
 
 /*
  * Initialize a NVMe controller structures.  This needs to be called during
@@ -1427,6 +1441,7 @@ out_release_instance:
 out:
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_init_ctrl);
 
 void nvme_stop_queues(struct nvme_ctrl *ctrl)
 {
@@ -1443,6 +1458,7 @@ void nvme_stop_queues(struct nvme_ctrl *ctrl)
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
+EXPORT_SYMBOL_GPL(nvme_stop_queues);
 
 void nvme_start_queues(struct nvme_ctrl *ctrl)
 {
@@ -1456,6 +1472,7 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 	}
 	mutex_unlock(&ctrl->namespaces_mutex);
 }
+EXPORT_SYMBOL_GPL(nvme_start_queues);
 
 int __init nvme_core_init(void)
 {
@@ -1495,3 +1512,8 @@ void nvme_core_exit(void)
 	class_destroy(nvme_class);
 	__unregister_chrdev(nvme_char_major, 0, NVME_MINORS, "nvme");
 }
+
+MODULE_LICENSE("GPL");
+MODULE_VERSION("1.0");
+module_init(nvme_core_init);
+module_exit(nvme_core_exit);
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index f7266cc..a5a4567 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2221,26 +2221,15 @@ static int __init nvme_init(void)
 	if (!nvme_workq)
 		return -ENOMEM;
 
-	result = nvme_core_init();
-	if (result < 0)
-		goto kill_workq;
-
 	result = pci_register_driver(&nvme_driver);
 	if (result)
-		goto core_exit;
-	return 0;
-
- core_exit:
-	nvme_core_exit();
- kill_workq:
-	destroy_workqueue(nvme_workq);
+		destroy_workqueue(nvme_workq);
 	return result;
 }
 
 static void __exit nvme_exit(void)
 {
 	pci_unregister_driver(&nvme_driver);
-	nvme_core_exit();
 	destroy_workqueue(nvme_workq);
 	BUG_ON(nvme_thread && !IS_ERR(nvme_thread));
 	_nvme_check_size();
-- 
1.9.1
