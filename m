From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 12 Jul 2019 11:02:11 -0700
Subject: [PATCH v2 3/3] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190712180211.26333-1-sagi@grimberg.me>
References: <20190712180211.26333-1-sagi@grimberg.me>
Message-ID: <20190712180211.26333-4-sagi@grimberg.me>

Provide userspace with nvme discovery controller device instance,
controller traddr and trsvcid. We'd expect userspace to handle
this event by issuing a discovery + connect.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 116c210826c2..76cd3dd8736a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1180,7 +1180,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -3612,6 +3613,30 @@ static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 	kfree(envp[0]);
 }
 
+static void nvme_disc_aen_uevent(struct nvme_ctrl *ctrl)
+{
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *envp[16];
+	int i, envloc = 0;
+
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_EVENT=discovery");
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_CTRL_NAME=%s",
+			dev_name(ctrl->device));
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRTYPE=%s", opts->transport);
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRADDR=%s", opts->traddr);
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRSVCID=%s",
+			opts->trsvcid ?: "none");
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_HOST_TRADDR=%s",
+			opts->host_traddr ?: "none");
+	envp[envloc] = NULL;
+
+	for (i = 0; i < envloc; i++)
+		dev_dbg(ctrl->device, "%s\n", envp[i]);
+	kobject_uevent_env(&ctrl->device->kobj, KOBJ_CHANGE, envp);
+	for (i = 0; i < envloc; i++)
+		kfree(envp[i]);
+}
+
 static void nvme_async_event_work(struct work_struct *work)
 {
 	struct nvme_ctrl *ctrl =
@@ -3702,6 +3727,9 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
 		queue_work(nvme_wq, &ctrl->ana_work);
 		break;
 #endif
+	case NVME_AER_NOTICE_DISC_CHANGED:
+		nvme_disc_aen_uevent(ctrl);
+		break;
 	default:
 		dev_warn(ctrl->device, "async event result %08x\n", result);
 	}
-- 
2.17.1
