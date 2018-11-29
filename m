From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Thu, 29 Nov 2018 09:18:04 -0800
Subject: [PATCH] nvme-core: small cleanups
Message-ID: <20181129171804.5241-1-chaitanya.kulkarni@wdc.com>

This is a small cleanup, patch which removes the extra lines,
inconsistent initialization of the struct nvme_command variables,
extra initialization. We don't change any functionality in this patch. 

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/host/core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 81d4514b9d06..0e845b702fe1 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -179,7 +179,7 @@ EXPORT_SYMBOL_GPL(nvme_delete_ctrl);
 
 int nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl)
 {
-	int ret = 0;
+	int ret;
 
 	/*
 	 * Keep a reference until the work is flushed since ->delete_ctrl
@@ -918,9 +918,10 @@ EXPORT_SYMBOL_GPL(nvme_stop_keep_alive);
 
 static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 {
-	struct nvme_command c = { };
+	struct nvme_command c;
 	int error;
 
+	memset(&c, 0, sizeof(c));
 	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_CTRL;
@@ -939,12 +940,13 @@ static int nvme_identify_ctrl(struct nvme_ctrl *dev, struct nvme_id_ctrl **id)
 static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
-	struct nvme_command c = { };
+	struct nvme_command c;
 	int status;
 	void *data;
 	int pos;
 	int len;
 
+	memset(&c, 0, sizeof(c));
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
 	c.identify.cns = NVME_ID_CNS_NS_DESC_LIST;
@@ -1010,8 +1012,9 @@ static int nvme_identify_ns_descs(struct nvme_ctrl *ctrl, unsigned nsid,
 
 static int nvme_identify_ns_list(struct nvme_ctrl *dev, unsigned nsid, __le32 *ns_list)
 {
-	struct nvme_command c = { };
+	struct nvme_command c;
 
+	memset(&c, 0, sizeof(c));
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.cns = NVME_ID_CNS_NS_ACTIVE_LIST;
 	c.identify.nsid = cpu_to_le32(nsid);
@@ -1023,9 +1026,10 @@ static struct nvme_id_ns *nvme_identify_ns(struct nvme_ctrl *ctrl,
 		unsigned nsid)
 {
 	struct nvme_id_ns *id;
-	struct nvme_command c = { };
+	struct nvme_command c};
 	int error;
 
+	memset(&c, 0, sizeof(c));
 	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
 	c.identify.opcode = nvme_admin_identify;
 	c.identify.nsid = cpu_to_le32(nsid);
@@ -1565,10 +1569,7 @@ static int nvme_revalidate_disk(struct gendisk *disk)
 	}
 
 	id = nvme_identify_ns(ctrl, ns->head->ns_id);
-	if (!id)
-		return -ENODEV;
-
-	if (id->ncap == 0) {
+	if (!id || id->ncap == 0) {
 		ret = -ENODEV;
 		goto out;
 	}
@@ -2051,7 +2052,6 @@ static void nvme_set_latency_tolerance(struct device *dev, s32 val)
 	case PM_QOS_LATENCY_ANY:
 		latency = U64_MAX;
 		break;
-
 	default:
 		latency = val;
 	}
@@ -2338,9 +2338,10 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 int nvme_get_log(struct nvme_ctrl *ctrl, u32 nsid, u8 log_page, u8 lsp,
 		void *log, size_t size, u64 offset)
 {
-	struct nvme_command c = { };
+	struct nvme_command c;
 	unsigned long dwlen = size / 4 - 1;
 
+	memset(&c, 0, sizeof(c));
 	c.get_log_page.opcode = nvme_admin_get_log_page;
 	c.get_log_page.nsid = cpu_to_le32(nsid);
 	c.get_log_page.lid = log_page;
@@ -3415,7 +3416,6 @@ static void nvme_async_event_work(struct work_struct *work)
 
 static bool nvme_ctrl_pp_status(struct nvme_ctrl *ctrl)
 {
-
 	u32 csts;
 
 	if (ctrl->ops->reg_read32(ctrl, NVME_REG_CSTS, &csts))
-- 
2.17.0
