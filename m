From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 22 Feb 2019 18:31:15 -0800
Subject: [PATCH 3/3 rfc] nvme: fire discovery log page change events to
 userspace
In-Reply-To: <20190223023117.20517-1-sagi@grimberg.me>
References: <20190223023117.20517-1-sagi@grimberg.me>
Message-ID: <20190223023117.20517-4-sagi@grimberg.me>

Provide userspace with nvme discovery controller device instance,
controller traddr and trsvcid. We'd expect userspace to handle
this event by issuing a discovery + connect.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 348af75583e5..d29ff9b910d9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1168,7 +1168,8 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
 #define NVME_AEN_SUPPORTED \
-	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE)
+	(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT | NVME_AEN_CFG_ANA_CHANGE | \
+	 NVME_AEN_CFG_DISC_CHANGE)
 
 static void nvme_enable_aen(struct nvme_ctrl *ctrl)
 {
@@ -3527,6 +3528,28 @@ static void nvme_aen_uevent(struct nvme_ctrl *ctrl)
 	kfree(envp[0]);
 }
 
+static void nvme_disc_aen_uevent(struct nvme_ctrl *ctrl)
+{
+	struct nvmf_ctrl_options *opts = ctrl->opts;
+	char *envp[16];
+	int i, envloc = 0;
+
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_EVENT=discovery");
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_INSTANCE=%d", ctrl->instance);
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRTYPE=%s", opts->transport);
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRADDR=%s", opts->traddr);
+	envp[envloc++] = kasprintf(GFP_KERNEL, "NVME_TRSVCID=%s", opts->trsvcid);
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
@@ -3618,6 +3641,9 @@ static void nvme_handle_aen_notice(struct nvme_ctrl *ctrl, u32 result)
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
