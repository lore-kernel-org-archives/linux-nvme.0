From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:09:55 +0200
Subject: [PATCHv2 02/11] nvme: submit AEN event configuration on startup
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-3-hare@suse.de>

We should register for AEN events; some law-abiding targets might
not be sending us AENs otherwise.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/host/core.c | 19 +++++++++++++++++++
 drivers/nvme/host/nvme.h |  1 +
 include/linux/nvme.h     |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fd71daa92d6a..ae1ebc2c88b3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1029,6 +1029,22 @@ int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count)
 }
 EXPORT_SYMBOL_GPL(nvme_set_queue_count);
 
+void nvme_enable_aen(struct nvme_ctrl *ctrl)
+{
+	u32 aen_cfg = NVME_SMART_CRIT_SPARE | NVME_SMART_CRIT_TEMPERATURE |
+		NVME_SMART_CRIT_RELIABILITY | NVME_SMART_CRIT_MEDIA |
+		NVME_SMART_CRIT_VOLATILE_MEMORY;
+	u32 result;
+	int status;
+
+	aen_cfg |= ctrl->aen_cfg;
+	status = nvme_set_features(ctrl, NVME_FEAT_ASYNC_EVENT,
+				   aen_cfg, NULL, 0, &result);
+	if (status)
+		dev_warn(ctrl->device, "Failed to configure AEN (cfg %x)\n",
+			 aen_cfg);
+}
+
 static int nvme_submit_io(struct nvme_ns *ns, struct nvme_user_io __user *uio)
 {
 	struct nvme_user_io io;
@@ -2345,6 +2361,8 @@ int nvme_init_identify(struct nvme_ctrl *ctrl)
 
 	ctrl->oacs = le16_to_cpu(id->oacs);
 	ctrl->oncs = le16_to_cpup(&id->oncs);
+	ctrl->aen_cfg = le32_to_cpu(id->oaes) &
+		(NVME_AEN_CFG_NS_ATTR | NVME_AEN_CFG_FW_ACT);
 	atomic_set(&ctrl->abort_limit, id->acl + 1);
 	ctrl->vwc = id->vwc;
 	ctrl->cntlid = le16_to_cpup(&id->cntlid);
@@ -3401,6 +3419,7 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl)
 
 	if (ctrl->queue_count > 1) {
 		nvme_queue_scan(ctrl);
+		nvme_enable_aen(ctrl);
 		queue_work(nvme_wq, &ctrl->async_event_work);
 		nvme_start_queues(ctrl);
 	}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2701c36552bf..3ec9b3e37616 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -176,6 +176,7 @@ struct nvme_ctrl {
 	u16 kas;
 	u8 npss;
 	u8 apsta;
+	u32 aen_cfg;
 	u32 aen_result;
 	unsigned int shutdown_timeout;
 	unsigned int kato;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index c37103a4ad38..21457fc25acd 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -446,6 +446,11 @@ enum {
 	NVME_AER_NOTICE_FW_ACT_STARTING = 0x01,
 };
 
+enum {
+	NVME_AEN_CFG_NS_ATTR		= 1 << 8,
+	NVME_AEN_CFG_FW_ACT		= 1 << 9,
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
-- 
2.12.3
