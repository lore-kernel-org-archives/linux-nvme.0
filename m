From: chaitanya.kulkarni@wdc.com (Chaitanya Kulkarni)
Date: Fri, 30 Mar 2018 02:57:43 -0400
Subject: [RFC PATCH 4/8] nvmet: use const values for id-ctrl
In-Reply-To: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
References: <20180330065747.20962-1-chaitanya.kulkarni@wdc.com>
Message-ID: <20180330065747.20962-5-chaitanya.kulkarni@wdc.com>

This patch adds constant values which are used in
target identify ctrl.

These values will be used in implementing
target passthru identify ctrl to mask the passthru
ctrl values with the default target ctrl values.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni at wdc.com>
---
 drivers/nvme/target/admin-cmd.c | 6 +++---
 drivers/nvme/target/nvmet.h     | 4 ++++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 90dcdc40ac71..6b3d20b32187 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -210,7 +210,7 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	 * comands.  But we don't do anything useful for abort either, so
 	 * no point in allowing more abort commands than the spec requires.
 	 */
-	id->acl = 3;
+	id->acl = NVMET_ID_CTRL_ACL;
 
 	id->aerl = NVMET_ASYNC_EVENTS - 1;
 
@@ -223,8 +223,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* We support keep-alive timeout in granularity of seconds */
 	id->kas = cpu_to_le16(NVMET_KAS);
 
-	id->sqes = (0x6 << 4) | 0x6;
-	id->cqes = (0x4 << 4) | 0x4;
+	id->sqes = NVMET_ID_CTRL_SQES;
+	id->cqes = NVMET_ID_CTRL_CQES;
 
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 584f1bcc5e79..35c7bec641bf 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -325,6 +325,10 @@ u32 nvmet_get_log_page_len(struct nvme_command *cmd);
 #define NVMET_MAX_CMD		NVMET_QUEUE_SIZE
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO		120
+#define NVMET_ID_CTRL_SQES     ((0x6 << 4) | 0x6)
+#define NVMET_ID_CTRL_CQES     ((0x4 << 4) | 0x4)
+#define NVMET_ID_CTRL_ACL      3
+
 
 int __init nvmet_init_configfs(void);
 void __exit nvmet_exit_configfs(void);
-- 
2.14.1
