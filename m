From: akinobu.mita@gmail.com (Akinobu Mita)
Date: Sun,  9 Jun 2019 23:17:01 +0900
Subject: [PATCH v3 2/3] nvme: enable to inject errors into admin commands
In-Reply-To: <1560089822-11462-1-git-send-email-akinobu.mita@gmail.com>
References: <1560089822-11462-1-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1560089822-11462-3-git-send-email-akinobu.mita@gmail.com>

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
Cc: Minwoo Im <minwoo.im.dev at gmail.com>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
Reviewed-by: Minwoo Im <minwoo.im.dev at gmail.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
Reviewed-by: Christoph Hellwig <hch at lst.de>
---
* v3
- add Reviewed-by tags
- remove thermal zone series dependency

 drivers/nvme/host/core.c         | 3 +++
 drivers/nvme/host/fault_inject.c | 5 ++---
 drivers/nvme/host/nvme.h         | 2 ++
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a66e7d8..80960e4 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3701,6 +3701,7 @@ EXPORT_SYMBOL_GPL(nvme_start_ctrl);
 
 void nvme_uninit_ctrl(struct nvme_ctrl *ctrl)
 {
+	nvme_fault_inject_fini(&ctrl->fault_inject);
 	dev_pm_qos_hide_latency_tolerance(ctrl->device);
 	cdev_device_del(&ctrl->cdev, ctrl->device);
 }
@@ -3796,6 +3797,8 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	dev_pm_qos_update_user_latency_tolerance(ctrl->device,
 		min(default_ps_max_latency_us, (unsigned long)S32_MAX));
 
+	nvme_fault_inject_init(&ctrl->fault_inject, dev_name(ctrl->device));
+
 	return 0;
 out_free_name:
 	kfree_const(ctrl->device->kobj.name);
diff --git a/drivers/nvme/host/fault_inject.c b/drivers/nvme/host/fault_inject.c
index e37b8c2..1352159 100644
--- a/drivers/nvme/host/fault_inject.c
+++ b/drivers/nvme/host/fault_inject.c
@@ -60,9 +60,6 @@ void nvme_should_fail(struct request *req)
 	struct nvme_fault_inject *fault_inject = NULL;
 	u16 status;
 
-	/*
-	 * make sure this request is coming from a valid namespace
-	 */
 	if (disk) {
 		struct nvme_ns *ns = disk->private_data;
 
@@ -70,6 +67,8 @@ void nvme_should_fail(struct request *req)
 			fault_inject = &ns->fault_inject;
 		else
 			WARN_ONCE(1, "No namespace found for request\n");
+	} else {
+		fault_inject = &nvme_req(req)->ctrl->fault_inject;
 	}
 
 	if (fault_inject && should_fail(&fault_inject->attr, 1)) {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f00c596..1b2624c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -256,6 +256,8 @@ struct nvme_ctrl {
 
 	struct page *discard_page;
 	unsigned long discard_page_busy;
+
+	struct nvme_fault_inject fault_inject;
 };
 
 enum nvme_iopolicy {
-- 
2.7.4
