From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Wed, 29 May 2019 02:03:38 +0900
Subject: [PATCH 2/2] nvme: enable to inject errors into admin commands
In-Reply-To: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
References: <1559063018-3682-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1559063018-3682-3-git-send-email-akinobu.mita@gmail.com>

This enables to inject errors into the commands submitted to the admin
queue.

It is useful to test error handling in the controller initialization.

	# echo 100 > /sys/kernel/debug/nvme0/fault_inject/probability
	# echo 1 > /sys/kernel/debug/nvme0/fault_inject/times
	# echo 10 > /sys/kernel/debug/nvme0/fault_inject/space
	# nvme reset /dev/nvme0
	# dmesg
	...
	nvme nvme0: Could not set queue count (16385)
	nvme nvme0: IO queues not created

Cc: Thomas Tai <thomas.tai at oracle.com>
Cc: Keith Busch <kbusch at kernel.org>
Cc: Jens Axboe <axboe at fb.com>
Cc: Christoph Hellwig <hch at lst.de>
Cc: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
---
 drivers/nvme/host/core.c         |  3 +++
 drivers/nvme/host/fault_inject.c |  5 ++---
 drivers/nvme/host/nvme.h         | 20 +++++++++++---------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9fca8457..66d8199 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4093,6 +4093,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
@@ -4188,6 +4189,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
+	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+
 	return 0;
 out_free_name:
 	kfree_const(ctrl->device->kobj.name);
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index e8d8da9..2f038e7 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -60,14 +60,13 @@ void nvme_should_fail(struct request *req)
 	struct nvme_fault_inject *fault_inject = NULL;
 	u16 status;
 
-	/*
-	 * make sure this request is coming from a valid namespace
-	 */
 	if (disk) {
 		struct nvme_ns *ns = disk->private_data;
 
 		if (ns)
 			fault_inject = &ns->fault_inject;
+	} else {
+		fault_inject = &nvme_req(req)->ctrl->fault_inject;
 	}
 
 	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3a48b94..6535fd8 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -147,6 +147,15 @@ enum nvme_ctrl_state {
 	NVME_CTRL_DEAD,
 };
 
+struct nvme_fault_inject {
+#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
+	struct fault_attr attr;
+	struct dentry *parent;
+	bool dont_retry;	/* DNR, do not retry */
+	u16 status;		/* status code */
+#endif
+};
+
 struct nvme_ctrl {
 	bool comp_seen;
 	enum nvme_ctrl_state state;
@@ -257,6 +266,8 @@ struct nvme_ctrl {
 	 */
 	struct thermal_zone_device *tzdev[9];
 #endif
+
+	struct nvme_fault_inject fault_inject;
 };
 
 enum nvme_iopolicy {
@@ -323,15 +334,6 @@ struct nvme_ns_head {
 #endif
 };
 
-struct nvme_fault_inject {
-#ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
-	struct fault_attr attr;
-	struct dentry *parent;
-	bool dont_retry;	/* DNR, do not retry */
-	u16 status;		/* status code */
-#endif
-};
-
 struct nvme_ns {
 	struct list_head list;
 
-- 
2.7.4
