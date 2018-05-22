From: hare@suse.de (Hannes Reinecke)
Date: Tue, 22 May 2018 11:09:57 +0200
Subject: [PATCHv2 04/11] nvmet: Add AEN configuration support
In-Reply-To: <20180522091004.39620-1-hare@suse.de>
References: <20180522091004.39620-1-hare@suse.de>
Message-ID: <20180522091004.39620-5-hare@suse.de>

From: Hannes Reinecke <hare@suse.com>

AEN configuration via the 'Get Features' and 'Set Features' admin
command is mandatory, so we should be implemeting handling for it.

Signed-off-by: Hannes Reinecke <hare at suse.com>
---
 drivers/nvme/target/admin-cmd.c | 8 +++++++-
 drivers/nvme/target/core.c      | 6 ++++--
 drivers/nvme/target/nvmet.h     | 1 +
 3 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 5e0e9fcc0d4d..58df0e5b3f5a 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -447,6 +447,11 @@ static void nvmet_execute_set_features(struct nvmet_req *req)
 		req->sq->ctrl->kato = DIV_ROUND_UP(val32, 1000);
 		nvmet_set_result(req, req->sq->ctrl->kato);
 		break;
+	case NVME_FEAT_ASYNC_EVENT:
+		val32 = le32_to_cpu(req->cmd->common.cdw10[1]);
+		req->sq->ctrl->aen_cfg = val32 & NVME_AEN_CFG_NS_ATTR;
+		nvmet_set_result(req, req->sq->ctrl->aen_cfg);
+		break;
 	case NVME_FEAT_HOST_ID:
 		status = NVME_SC_CMD_SEQ_ERROR | NVME_SC_DNR;
 		break;
@@ -485,9 +490,10 @@ static void nvmet_execute_get_features(struct nvmet_req *req)
 		break;
 	case NVME_FEAT_WRITE_ATOMIC:
 		break;
+#endif
 	case NVME_FEAT_ASYNC_EVENT:
+		nvmet_set_result(req, req->sq->ctrl->aen_cfg);
 		break;
-#endif
 	case NVME_FEAT_VOLATILE_WC:
 		nvmet_set_result(req, 1);
 		break;
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 505d4267b8f1..a8fc05b1aff8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -146,8 +146,9 @@ static void nvmet_send_ns_changed_event(struct nvmet_subsys *subsys)
 	struct nvmet_ctrl *ctrl;
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
-		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
-				NVME_AER_NOTICE_NS_CHANGED, 0);
+		if (ctrl->aen_cfg & NVME_AEN_CFG_NS_ATTR)
+			nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
+					      NVME_AER_NOTICE_NS_CHANGED, 0);
 }
 
 int nvmet_register_transport(const struct nvmet_fabrics_ops *ops)
@@ -816,6 +817,7 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 
 	kref_init(&ctrl->ref);
 	ctrl->subsys = subsys;
+	ctrl->aen_cfg = NVME_AEN_CFG_NS_ATTR;
 
 	ctrl->cqs = kcalloc(subsys->max_qid + 1,
 			sizeof(struct nvmet_cq *),
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 15fd84ab21f8..3fd6686ad906 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -120,6 +120,7 @@ struct nvmet_ctrl {
 	u16			cntlid;
 	u32			kato;
 
+	u32			aen_cfg;
 	struct nvmet_req	*async_event_cmds[NVMET_ASYNC_EVENTS];
 	unsigned int		nr_async_event_cmds;
 	struct list_head	async_events;
-- 
2.12.3
