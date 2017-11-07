From: keith.busch@intel.com (Keith Busch)
Date: Tue,  7 Nov 2017 15:13:14 -0700
Subject: [PATCHv3 5/5] nvme: Send uevent for some asynchronous events
In-Reply-To: <20171107221314.27822-1-keith.busch@intel.com>
References: <20171107221314.27822-1-keith.busch@intel.com>
Message-ID: <20171107221314.27822-6-keith.busch@intel.com>

This will give udev a chance to observe and handle asynchronous event
notifications and clear the log to unmask future events of the same type.
The driver will create a change uevent of the asyncronuos event result
before submitting the next AEN request to the device if a completed AEN
event is of type error, smart, command set or vendor specific,

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 28 ++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  4 ++++
 3 files changed, 33 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f5e059af65cc..486d02204c5d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2678,11 +2678,28 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
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
+	envp[0] = kasprintf(GFP_KERNEL, "NVME_AEN=%#08x", aen);
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
 
@@ -2754,6 +2771,17 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	if (le16_to_cpu(status) >> 1 != NVME_SC_SUCCESS)
 		return;
 
+	switch (result & 0x7) {
+	case NVME_AER_ERROR:
+	case NVME_AER_SMART:
+	case NVME_AER_CSS:
+	case NVME_AER_VS:
+		ctrl->aen = result;
+		break;
+	default:
+		break;
+	}
+
 	switch (result & 0xff07) {
 	case NVME_AER_NOTICE_NS_CHANGED:
 		dev_info(ctrl->device, "rescanning\n");
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 151062573ece..b50ac356c3db 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -168,6 +168,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u32 aen;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
 	bool subsystem;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 89ffa7eed2fd..aea87f0d917b 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -428,6 +428,10 @@ enum {
 };
 
 enum {
+	NVME_AER_ERROR			= 0,
+	NVME_AER_SMART			= 1,
+	NVME_AER_CSS			= 6,
+	NVME_AER_VS			= 7,
 	NVME_AER_NOTICE_NS_CHANGED	= 0x0002,
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x0102,
 };
-- 
2.13.6
