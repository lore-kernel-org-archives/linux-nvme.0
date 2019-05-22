From: keith.busch@intel.com (Keith Busch)
Date: Wed, 22 May 2019 11:48:12 -0600
Subject: [PATCH 2/2] nvme: reset request timeouts during fw activation
In-Reply-To: <20190522174812.5597-1-keith.busch@intel.com>
References: <20190522174812.5597-1-keith.busch@intel.com>
Message-ID: <20190522174812.5597-3-keith.busch@intel.com>

The nvme controller may pause command processing during firmware
activation. The driver will quiesce queues during this time, but commands
dispatched prior to the notification will not be processed until the
hardware completes this activation.

We do not want those requests to time out while the hardware is in
this paused state as we don't expect those commands to complete during
this time, and that handling will interfere with the firmware activation
process.

In addition to quiescing the queues, halt timeout detection during the
paused state and reset the dispatched request deadlines when the hardware
exists that state. This action applies to IO and admin queues.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1b7c2afd84cb..37a9a66ada22 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -89,6 +89,7 @@ static dev_t nvme_chr_devt;
 static struct class *nvme_class;
 static struct class *nvme_subsys_class;
 
+static void nvme_reset_queues(struct nvme_ctrl *ctrl);
 static int nvme_revalidate_disk(struct gendisk *disk);
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
@@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
 				msecs_to_jiffies(admin_timeout * 1000);
 
 	nvme_stop_queues(ctrl);
+	nvme_sync_queues(ctrl);
+
+	blk_mq_quiesce_queue(ctrl->admin_q);
+	blk_sync_queue(ctrl->admin_q);
+
 	while (nvme_ctrl_pp_status(ctrl)) {
 		if (time_after(jiffies, fw_act_timeout)) {
 			dev_warn(ctrl->device,
@@ -3618,7 +3624,12 @@ static void nvme_fw_act_work(struct work_struct *work)
 	if (ctrl->state != NVME_CTRL_LIVE)
 		return;
 
+	blk_mq_reset_rqs(ctrl->admin_q);
+	blk_mq_unquiesce_queue(ctrl->admin_q);
+
+	nvme_reset_queues(ctrl);
 	nvme_start_queues(ctrl);
+
 	/* read FW slot information to clear the AER */
 	nvme_get_fw_slot_info(ctrl);
 }
@@ -3901,6 +3912,15 @@ void nvme_start_queues(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_start_queues);
 
+static void nvme_reset_queues(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list)
+		blk_mq_reset_rqs(ns->queue);
+	up_read(&ctrl->namespaces_rwsem);
+}
 
 void nvme_sync_queues(struct nvme_ctrl *ctrl)
 {
-- 
2.14.4
