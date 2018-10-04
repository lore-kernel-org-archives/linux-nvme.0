From: jay.e.sternberg@intel.com (Jay Sternberg)
Date: Thu,  4 Oct 2018 08:49:21 -0700
Subject: [PATCH 01/11] nvmet: Provide aen bit functions for multiple
 controller types
In-Reply-To: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
References: <1538668171-232344-1-git-send-email-jay.e.sternberg@intel.com>
Message-ID: <1538668171-232344-2-git-send-email-jay.e.sternberg@intel.com>

Move nvmet_aen_disabled and nvmet_clear_aen in preparation for other types
of controllers to use, initially the discovery controller.

Signed-off-by: Jay Sternberg <jay.e.sternberg at intel.com>
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/target/admin-cmd.c | 13 -------------
 drivers/nvme/target/core.c      |  7 -------
 drivers/nvme/target/nvmet.h     | 15 +++++++++++++++
 3 files changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index a21caea..4f32de0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -19,19 +19,6 @@
 #include <asm/unaligned.h>
 #include "nvmet.h"
 
-/*
- * This helper allows us to clear the AEN based on the RAE bit,
- * Please use this helper when processing the log pages which are
- * associated with the AEN.
- */
-static inline void nvmet_clear_aen(struct nvmet_req *req, u32 aen_bit)
-{
-	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
-
-	if (!rae)
-		clear_bit(aen_bit, &req->sq->ctrl->aen_masked);
-}
-
 u32 nvmet_get_log_page_len(struct nvme_command *cmd)
 {
 	u32 len = le16_to_cpu(cmd->get_log_page.numdu);
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ebf3e7a..967e624 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -149,13 +149,6 @@ static void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 	schedule_work(&ctrl->async_event_work);
 }
 
-static bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
-{
-	if (!(READ_ONCE(ctrl->aen_enabled) & aen))
-		return true;
-	return test_and_set_bit(aen, &ctrl->aen_masked);
-}
-
 static void nvmet_add_to_changed_ns_log(struct nvmet_ctrl *ctrl, __le32 nsid)
 {
 	u32 i;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index ec9af4e..01703b1 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -324,6 +324,21 @@ struct nvmet_async_event {
 	u8			log_page;
 };
 
+static inline void nvmet_clear_aen(struct nvmet_req *req, u32 aen_bit)
+{
+	int rae = le32_to_cpu(req->cmd->common.cdw10[0]) & 1 << 15;
+
+	if (!rae)
+		clear_bit(aen_bit, &req->sq->ctrl->aen_masked);
+}
+
+static inline bool nvmet_aen_disabled(struct nvmet_ctrl *ctrl, u32 aen)
+{
+	if (!(READ_ONCE(ctrl->aen_enabled) & aen))
+		return true;
+	return test_and_set_bit(aen, &ctrl->aen_masked);
+}
+
 u16 nvmet_parse_connect_cmd(struct nvmet_req *req);
 u16 nvmet_bdev_parse_io_cmd(struct nvmet_req *req);
 u16 nvmet_file_parse_io_cmd(struct nvmet_req *req);
-- 
1.8.3.1
