From: keith.busch@intel.com (Keith Busch)
Date: Thu, 18 Feb 2016 16:21:16 -0700
Subject: [PATCH-4.6 2/3] NVMe: Code naming cleanup
In-Reply-To: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
References: <1455837677-23248-1-git-send-email-keith.busch@intel.com>
Message-ID: <1455837677-23248-2-git-send-email-keith.busch@intel.com>

Consistency help readability. This renames all instances of struct
nvme_ctrl to "ctrl" that weren't already named that.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 04443b2..33ad10d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -248,7 +248,7 @@ int nvme_submit_user_cmd(struct request_queue *q, struct nvme_command *cmd,
 			result, timeout);
 }
 
-int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
+int nvme_identify_ctrl(struct nvme_ctrl *ctrl, struct nvme_id_ctrl **id)
 {
 	struct nvme_command c = { };
 	int error;
@@ -261,24 +261,24 @@ int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 	if (!*id)
 		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id,
 			sizeof(struct nvme_id_ctrl));
 	if (error)
 		kfree(*id);
 	return error;
 }
 
-static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
+static int nvme_identify_ns_list(struct nvme_ctrl *ctrl, unsigned nsid, __le32 *ns_list)
 {
 	struct nvme_command c = { };
 
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = cpu_to_le32(2);
 	c.identify.nsid = cpu_to_le32(nsid);
-	return nvme_submit_sync_cmd(dev->admin_q, &c, ns_list, 0x1000);
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, ns_list, 0x1000);
 }
 
-int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
+int nvme_identify_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_id_ns **id)
 {
 	struct nvme_command c = { };
@@ -292,14 +292,14 @@ int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 	if (!*id)
 		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *id,
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *id,
 			sizeof(struct nvme_id_ns));
 	if (error)
 		kfree(*id);
 	return error;
 }
 
-int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
+int nvme_get_features(struct nvme_ctrl *ctrl, unsigned fid, unsigned nsid,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
@@ -310,10 +310,10 @@ int nvme_get_features(struct nvme_ctrl *dev, unsigned fid, unsigned nsid,
 	c.features.prp1 = cpu_to_le64(dma_addr);
 	c.features.fid = cpu_to_le32(fid);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0, result, 0);
 }
 
-int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
+int nvme_set_features(struct nvme_ctrl *ctrl, unsigned fid, unsigned dword11,
 					dma_addr_t dma_addr, u32 *result)
 {
 	struct nvme_command c;
@@ -324,10 +324,10 @@ int nvme_set_features(struct nvme_ctrl *dev, unsigned fid, unsigned dword11,
 	c.features.fid = cpu_to_le32(fid);
 	c.features.dword11 = cpu_to_le32(dword11);
 
-	return __nvme_submit_sync_cmd(dev->admin_q, &c, NULL, 0, result, 0);
+	return __nvme_submit_sync_cmd(ctrl->admin_q, &c, NULL, 0, result, 0);
 }
 
-int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
+int nvme_get_log_page(struct nvme_ctrl *ctrl, struct nvme_smart_log **log)
 {
 	struct nvme_command c = { };
 	int error;
@@ -342,7 +342,7 @@ int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
 	if (!*log)
 		return -ENOMEM;
 
-	error = nvme_submit_sync_cmd(dev->admin_q, &c, *log,
+	error = nvme_submit_sync_cmd(ctrl->admin_q, &c, *log,
 			sizeof(struct nvme_smart_log));
 	if (error)
 		kfree(*log);
-- 
2.6.2.307.g37023ba
