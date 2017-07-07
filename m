From: keith.busch@intel.com (Keith Busch)
Date: Fri,  7 Jul 2017 12:23:01 -0400
Subject: [PATCH 7/7] nvme: Send change uevent when AEN completes
In-Reply-To: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
References: <1499444581-28268-1-git-send-email-keith.busch@intel.com>
Message-ID: <1499444581-28268-8-git-send-email-keith.busch@intel.com>

This will give udev a chance to handle asynchronous event notification
and clear the log to unmask future events of the same type. Since the
core driver allows only one AEN request at a time, we can only have one
possible oustanding uevent to send. This implementation saves the last
AEN result from the IRQ handler, and sends the uevent change notification
when the AEN work is rescheduled.

The udev rule used to test this was the following:

  ACTION=="change", SUBSYSTEM=="nvme", ENV{NVME_AEN}=="*", \
        RUN+="/bin/sh -c '/usr/local/sbin/nvme get-log $env{DEVNAME} --log-id=$(( ($env{NVME_AEN} >> 16) & 0xff )) --log-len=4096 >> /tmp/nvme-log'"

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 16 ++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 783db84..4abde2da 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2507,11 +2507,26 @@ void nvme_remove_namespaces(struct nvme_ctrl *ctrl)
 }
 EXPORT_SYMBOL_GPL(nvme_remove_namespaces);
 
+void nvme_aen_uevent(struct nvme_ctrl *ctrl)
+{
+	char buffer[20]; /* NVME_AEN=0xffffffff\0 */
+	char *envp[2] = {buffer, NULL};
+	u32 aen = ctrl->aen;
+
+	ctrl->aen = 0;
+	if (!aen)
+		return;
+
+	snprintf(buffer, sizeof(buffer), "NVME_AEN=%#08x", aen);
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+}
+
 static void nvme_async_event_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
 		container_of(work, struct nvme_ctrl, async_event_work);
 
+	nvme_aen_uevent(ctrl);
 	ctrl->ops->submit_async_event(ctrl);
 }
 
@@ -2531,6 +2546,7 @@ void nvme_complete_async_event(struct nvme_ctrl *ctrl, __le16 status,
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
+	ctrl->aen = result;
 	queue_work(nvme_wq, &ctrl->async_event_work);
 }
 EXPORT_SYMBOL_GPL(nvme_complete_async_event);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index b65c22f..898815f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -159,6 +159,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u32 aen;
 	unsigned int kato;
 	bool subsystem;
 	unsigned long quirks;
-- 
2.5.5
