From: keith.busch@intel.com (Keith Busch)
Date: Fri, 20 Oct 2017 16:19:24 -0600
Subject: [PATCHv2 5/5] nvme: Send uevent for unhandled AEN completions
In-Reply-To: <20171020221924.30659-1-keith.busch@intel.com>
References: <20171020221924.30659-1-keith.busch@intel.com>
Message-ID: <20171020221924.30659-6-keith.busch@intel.com>

This will give udev a chance to handle asynchronous event notification
and clear the log to unmask future events of the same type. Since the
core driver allows only one AEN request at a time, we can only have one
possible oustanding uevent to send. This implementation saves the last
AEN result from the IRQ handler, and sends the uevent change notification
when the AEN work is rescheduled.

AEN events that the kernel handles directly will not create a uevent. Such
events will stop being sent to the user as new handlers are added to
the kernel.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 21 +++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 22 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 74724329f430..d05dcd172ad5 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2574,11 +2574,27 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
+{
+	char *envp[2] = {NULL, NULL};
+	u32 aen = ctrl->aen;
+
+	ctrl->aen = 0;
+	if (!aen)
+		return;
+
+	if (!envp[0])
+		return;
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+	kfree(envp[0]);
+}
+
 static void nvme_async_event_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
+	nvme_aen_uevent(ctrl);
 	ctrl->ops->submit_async_event(ctrl);
 }
 
@@ -2655,6 +2671,10 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	/*
+	 * Set result for udev only for AEN types that the kernel does not
+	 * directly handle.
+	 */
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(ctrl->device, "rescanning\n");
@@ -2664,6 +2684,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 		queue_work(nvme_wq, &ctrl->fw_act_work);
 		break;
 	default:
+		ctrl->aen = result;
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
 	queue_work(nvme_wq, &ctrl->async_event_work);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 4cd4e8f4db19..69366293ce57 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -166,6 +166,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u32 aen;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
-- 
2.13.6
