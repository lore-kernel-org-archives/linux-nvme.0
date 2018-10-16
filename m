From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Tue, 16 Oct 2018 10:11:14 -0700
Subject: [PATCH v2 02/11] nvmet: Change aen mask functions to use bit numbers
In-Reply-To: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
References: <1539709883-12424-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1539709883-12424-3-git-send-email-jay.e.sternberg@intel.com>

Functions nvmet_aen_disabled and nvmet_clear_aen were using
values not bit numbers ie 1 << 9 not 9 for bit function clear_bit
and test_and_set_bit.

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Phil Cayton <phil.cayton at intel.com>
---
v2 - unchanged

 drivers/nvme/target/admin-cmd.c |  4 ++--
 drivers/nvme/target/core.c      |  4 ++--
 drivers/nvme/target/nvmet.h     | 10 +++++-----
 include/linux/nvme.h            | 12 +++++++++---
 4 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 4f32de0..e50f88c 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,7 +176,7 @@ static void nvmet_execute_get_log_changed_ns(struct nvmet_req *req)
 	if (!status)
 		status = nvmet_zero_sgl(req, len, req->data_len - len);
 	ctrl->nr_changed_ns = 0;
-	nvmet_clear_aen(req, NVME_AEN_CFG_NS_ATTR);
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_NS_ATTR);
 	mutex_unlock(&ctrl->lock);
 out:
 	nvmet_req_complete(req, status);
@@ -235,7 +235,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 
 	hdr.chgcnt = cpu_to_le64(nvmet_ana_chgcnt);
 	hdr.ngrps = cpu_to_le16(ngrps);
-	nvmet_clear_aen(req, NVME_AEN_CFG_ANA_CHANGE);
+	nvmet_clear_aen_bit(req, NVME_AEN_BIT_ANA_CHANGE);
 	up_read(&nvmet_ana_sem);
 
 	kfree(desc);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 967e624..5773b74 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -179,7 +179,7 @@ void nvmet_ns_changed(struct nvmet_subsys *subsys, u32 nsid)
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		nvmet_add_to_changed_ns_log(ctrl, cpu_to_le32(nsid));
-		if (nvmet_aen_disabled(ctrl, NVME_AEN_CFG_NS_ATTR))
+		if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_NS_ATTR))
 			continue;
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
 				NVME_AER_NOTICE_NS_CHANGED,
@@ -196,7 +196,7 @@ void nvmet_send_ana_event(struct nvmet_subsys *subsys,
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
 		if (port && ctrl->port != port)
 			continue;
-		if (nvmet_aen_disabled(ctrl, NVME_AEN_CFG_ANA_CHANGE))
+		if (nvmet_aen_bit_disabled(ctrl, NVME_AEN_BIT_ANA_CHANGE))
 			continue;
 		nvmet_add_async_event(ctrl, NVME_AER_TYPE_NOTICE,
 				NVME_AER_NOTICE_ANA, NVME_LOG_ANA);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 01703b1..5a56849 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -324,19 +324,19 @@ struct nvmet_async_event {
 	u8			log_page;
 };
 
-static inline void nvmet_clear_aen(struct nvmet_req *req, u32 aen_bit)
+static inline void nvmet_clear_aen_bit(struct nvmet_req *req, u32 bn)
 {
 	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
 
 	if (!rae)
-		clear_bit(aen_bit, &req->sq->ctrl->aen_masked);
+		clear_bit(bn, &req->sq->ctrl->aen_masked);
 }
 
-static inline bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
+static inline bool nvmet_aen_bit_disabled(struct nvmet_ctrl *ctrl, u32 bn)
 {
-	if (!(READ_ONCE(ctrl->aen_enabled) & aen))
+	if (!(READ_ONCE(ctrl->aen_enabled) & BIT(bn)))
 		return true;
-	return test_and_set_bit(aen, &ctrl->aen_masked);
+	return test_and_set_bit(bn, &ctrl->aen_masked);
 }
 
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 68e91ef..47b69d5 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -484,9 +484,15 @@ enum {
 };
 
 enum {
-	NVME_AEN_CFG_NS_ATTR		= 1 << 8,
-	NVME_AEN_CFG_FW_ACT		= 1 << 9,
-	NVME_AEN_CFG_ANA_CHANGE		= 1 << 11,
+	NVME_AEN_BIT_NS_ATTR		= 8,
+	NVME_AEN_BIT_FW_ACT		= 9,
+	NVME_AEN_BIT_ANA_CHANGE		= 11,
+};
+
+enum {
+	NVME_AEN_CFG_NS_ATTR		= BIT(NVME_AEN_BIT_NS_ATTR),
+	NVME_AEN_CFG_FW_ACT		= BIT(NVME_AEN_BIT_FW_ACT),
+	NVME_AEN_CFG_ANA_CHANGE		= BIT(NVME_AEN_BIT_ANA_CHANGE),
 };
 
 struct nvme_lba_range_type {
-- 
1.8.3.1
