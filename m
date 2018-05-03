From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed,  2 May 2018 21:00:45 -0400
Subject: [PATCH V2 2/6] nvme-core: export existing ctrl and ns interfaces
In-Reply-To: <20180503010049.3010-1-chaitanya.kulkarni@wdc.com>
References: <20180503010049.3010-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180503010049.3010-3-chaitanya.kulkarni@wdc.com>

We export existing nvme ctrl and ns management APIs so that
target passthru code can manage the nvme ctrl.

This is a preparation patch for implementing NVMe Over Fabric
target passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 15 ++++++++++-----
 drivers/nvme/host/nvme.h |  7 +++++++
 2 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ebc75c5..ecdb701 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -429,10 +429,11 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
+EXPORT_SYMBOL(nvme_put_ns);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
@@ -1014,7 +1015,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
+struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 		unsigned nsid)
 {
 	struct nvme_id_ns *id;
@@ -1039,6 +1040,7 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	return id;
 }
+EXPORT_SYMBOL(nvme_identify_ns);
 
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
@@ -1151,7 +1153,7 @@ static u32 nvme_known_admin_effects(u8 opcode)
 	return 0;
 }
 
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 								u8 opcode)
 {
 	u32 effects = 0;
@@ -1181,6 +1183,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	return effects;
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_start);
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
@@ -1199,7 +1202,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 		nvme_ns_remove(ns);
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 {
 	/*
 	 * Revalidate LBA changes prior to unfreezing. This is necessary to
@@ -1215,6 +1218,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
 		nvme_queue_scan(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_end);
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
@@ -2982,7 +2986,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -3000,6 +3004,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ee609d2..695e836 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -392,6 +392,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
+void nvme_put_ns(struct nvme_ns *ns);
 
 void nvme_queue_scan(struct nvme_ctrl *ctrl);
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
@@ -422,8 +424,13 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags);
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 opcode);
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects);
 int nvme_set_queue_count(struct nvme_ctrl *ctrl, int *count);
 void nvme_stop_keep_alive(struct nvme_ctrl *ctrl);
+struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
+		unsigned nsid);
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl);
 int nvme_reset_ctrl_sync(struct nvme_ctrl *ctrl);
 int nvme_delete_ctrl(struct nvme_ctrl *ctrl);
-- 
2.9.5
