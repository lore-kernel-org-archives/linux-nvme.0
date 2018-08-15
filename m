From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Wed, 15 Aug 2018 15:58:47 -0400
Subject: [PATCH V4 2/9] nvme-core: export existing ctrl and ns interfaces
In-Reply-To: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
References: <20180815195854.15449-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180815195854.15449-3-chaitanya.kulkarni@wdc.com>

We export existing nvme ctrl and ns management APIs so that
target passthru code can manage the nvme ctrl.

This is a preparation patch for implementing NVMe Over Fabric
target passthru feature.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 18 +++++++++++-------
 drivers/nvme/host/nvme.h |  8 ++++++++
 2 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index efc24d441d79..efca1e0b7f8f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -453,10 +453,11 @@ static void nvme_free_ns(struct kref *kref)
 	kfree(ns);
 }
 
-static void nvme_put_ns(struct nvme_ns *ns)
+void nvme_put_ns(struct nvme_ns *ns)
 {
 	kref_put(&ns->kref, nvme_free_ns);
 }
+EXPORT_SYMBOL_GPL(nvme_put_ns);
 
 static inline void nvme_clear_nvme_request(struct request *req)
 {
@@ -1050,8 +1051,7 @@ static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *n
 				    NVME_IDENTIFY_DATA_SIZE);
 }
 
-static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
-		unsigned nsid)
+struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_id_ns *id;
 	struct nvme_command c = { };
@@ -1075,6 +1075,7 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 
 	return id;
 }
+EXPORT_SYMBOL_GPL(nvme_identify_ns);
 
 static int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 		      void *buffer, size_t buflen, u32 *result)
@@ -1205,8 +1206,8 @@ static u32 nvme_known_admin_effects(u8 opcode)
 	return 0;
 }
 
-static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
-								u8 opcode)
+u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+		u8 opcode)
 {
 	u32 effects = 0;
 
@@ -1235,6 +1236,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 	return effects;
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_start);
 
 static void nvme_update_formats(struct nvme_ctrl *ctrl)
 {
@@ -1249,7 +1251,7 @@ static void nvme_update_formats(struct nvme_ctrl *ctrl)
 	nvme_remove_invalid_namespaces(ctrl, NVME_NSID_ALL);
 }
 
-static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
+void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 {
 	/*
 	 * Revalidate LBA changes prior to unfreezing. This is necessary to
@@ -1265,6 +1267,7 @@ static void nvme_passthru_end(struct nvme_ctrl *ctrl, u32 effects)
 	if (effects & (NVME_CMD_EFFECTS_NIC | NVME_CMD_EFFECTS_NCC))
 		nvme_queue_scan(ctrl);
 }
+EXPORT_SYMBOL_GPL(nvme_passthru_end);
 
 static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 			struct nvme_passthru_cmd __user *ucmd)
@@ -3054,7 +3057,7 @@ static int ns_cmp(void *priv, struct list_head *a, struct list_head *b)
 	return nsa->head->ns_id - nsb->head->ns_id;
 }
 
-static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 {
 	struct nvme_ns *ns, *ret = NULL;
 
@@ -3072,6 +3075,7 @@ static struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 	up_read(&ctrl->namespaces_rwsem);
 	return ret;
 }
+EXPORT_SYMBOL_GPL(nvme_find_get_ns);
 
 static int nvme_setup_streams_ns(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 495eafcb9e9d..9dcb1ca24126 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -420,6 +420,8 @@ void nvme_start_ctrl(struct nvme_ctrl *ctrl);
 void nvme_stop_ctrl(struct nvme_ctrl *ctrl);
 void nvme_put_ctrl(struct nvme_ctrl *ctrl);
 int nvme_init_identify(struct nvme_ctrl *ctrl);
+struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid);
+void nvme_put_ns(struct nvme_ns *ns);
 
 void nvme_remove_namespaces(struct nvme_ctrl *ctrl);
 
@@ -449,8 +451,14 @@ int __nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 		union nvme_result *result, void *buffer, unsigned bufflen,
 		unsigned timeout, int qid, int at_head,
 		blk_mq_req_flags_t flags);
+
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
2.14.1
