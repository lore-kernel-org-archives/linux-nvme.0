From: yuyufen@huawei.com (Yufen Yu)
Date: Thu, 16 May 2019 11:05:21 +0800
Subject: [PATCH] nvme: fix memory leak for power latency tolerance req
Message-ID: <20190516030521.40374-1-yuyufen@huawei.com>

nvme_init_ctrl() initialize latency tolerance controls and
kzalloc structdev_pm_qos_request 'req' in nvme_init_ctrl().
The only way to free the 'req' is nvme_init_identify(), when
apst is disable and prev_apst is enable.

But, prev_apst is disable when device probe, and we will
miss to free it when the device does't support APST.

To fix the problem, we call dev_pm_qos_update_user_latency_tolerance()
to nvme_init_identify() only when the device actually supports APST.
And it needs to be hidden when remove nvme ctrl.

Fixes: c5552fde102fc("nvme: Enable autonomous power state transitions")

Signed-off-by: Yufen Yu <yuyufen at huawei.com>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 15d114787d6a..e10756b7c13f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2485,6 +2485,21 @@ static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static void nvme_expose_latency_tolerance(struct nvme_ctrl *ctrl)
+{
+	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
+	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
+		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
+
+	dev_pm_qos_expose_latency_tolerance(ctrl->device);
+}
+
+static void nvme_hide_latency_tolerance(struct nvme_ctrl *ctrl)
+{
+	ctrl->device->power.set_latency_tolerance = NULL;
+	dev_pm_qos_hide_latency_tolerance(ctrl->device);
+}
+
 /*
  * Initialize the cached copies of the Identify data and various controller
  * register in our nvme_ctrl structure.  This should be called as soon as
@@ -2643,9 +2658,9 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return ret;
 
 	if (ctrl->apst_enabled && !prev_apst_enabled)
-		dev_pm_qos_expose_latency_tolerance(ctrl->device);
+		nvme_expose_latency_tolerance(ctrl);
 	else if (!ctrl->apst_enabled && prev_apst_enabled)
-		dev_pm_qos_hide_latency_tolerance(ctrl->device);
+		nvme_hide_latency_tolerance(ctrl);
 
 	ret = nvme_configure_apst(ctrl);
 	if (ret < 0)
@@ -3687,6 +3702,13 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	/*
+	 * If userspace latency tolerance have been exposed,
+	 * we need to hide it.
+	 */
+	if (ctrl->device->power.set_latency_tolerance)
+		nvme_hide_latency_tolerance(ctrl);
+
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
 EXPORT_SYMBOL_GPL(nvme_uninit_ctrl);
@@ -3773,14 +3795,6 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	if (ret)
 		goto out_free_name;
 
-	/*
-	 * Initialize latency tolerance controls.  The sysfs files won't
-	 * be visible to userspace unless the device actually supports APST.
-	 */
-	ctrl->device->power.set_latency_tolerance = nvme_set_latency_tolerance;
-	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
-		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
-
 	return 0;
 out_free_name:
 	kfree_const(ctrl->device->kobj.name);
-- 
2.16.2.dirty
