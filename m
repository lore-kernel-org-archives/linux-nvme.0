From: mb@lightnvm.io (=?UTF-8?q?Matias=20Bj=C3=B8rling?=)
Date: Mon, 26 Feb 2018 13:55:40 +0100
Subject: [PATCH v2 1/1] nvme: implement log page low/high offset and dwords
In-Reply-To: <20180226125540.9513-1-mb@lightnvm.io>
References: <20180226125540.9513-1-mb@lightnvm.io>
Message-ID: <20180226125540.9513-2-mb@lightnvm.io>

NVMe 1.2.1 extends the get log page interface to include 64 bit
offset and increases the number of dwords to 32 bits. Implement
for future use.

Signed-off-by: Matias Bj?rling <mb at lightnvm.io>
---
 drivers/nvme/host/core.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 740ceb28067c..2e9e9f973a75 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -80,11 +80,6 @@ static struct class *nvme_subsys_class;
 static void nvme_ns_remove(struct nvme_ns *ns);
 static int nvme_revalidate_disk(struct gendisk *disk);
 
-static __le32 nvme_get_log_dw10(u8 lid, size_t size)
-{
-	return cpu_to_le32((((size / 4) - 1) << 16) | lid);
-}
-
 int nvme_reset_ctrl(struct nvme_ctrl *ctrl)
 {
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
@@ -2132,16 +2127,33 @@ static int nvme_init_subsystem(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	return ret;
 }
 
+static int nvme_get_log_ext(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
+			    u8 log_page, void *log,
+			    size_t size, size_t offset)
+{
+	struct nvme_command c = { };
+	unsigned long dwlen = size / 4 - 1;
+
+	c.get_log_page.opcode = nvme_admin_get_log_page;
+
+	if (ns)
+		c.get_log_page.nsid = cpu_to_le32(ns->head->ns_id);
+	else
+		c.get_log_page.nsid = cpu_to_le32(NVME_NSID_ALL);
+
+	c.get_log_page.lid = log_page;
+	c.get_log_page.numdl = cpu_to_le16(dwlen & ((1 << 16) - 1));
+	c.get_log_page.numdu = cpu_to_le16(dwlen >> 16);
+	c.get_log_page.lpol = cpu_to_le32(offset & ((1ULL << 32) - 1));
+	c.get_log_page.lpou = cpu_to_le32(offset >> 32ULL);
+
+	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+}
+
 static int nvme_get_log(struct nvme_ctrl *ctrl, u8 log_page, void *log,
 			size_t size)
 {
-	struct nvme_command c = { };
-
-	c.common.opcode = nvme_admin_get_log_page;
-	c.common.nsid = cpu_to_le32(NVME_NSID_ALL);
-	c.common.cdw10[0] = nvme_get_log_dw10(log_page, size);
-
-	return nvme_submit_sync_cmd(ctrl->admin_q, &c, log, size);
+	return nvme_get_log_ext(ctrl, NULL, log_page, log, size, 0);
 }
 
 static int nvme_get_effects_log(struct nvme_ctrl *ctrl)
-- 
2.11.0
