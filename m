From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 18 Jun 2017 16:15:58 +0300
Subject: [PATCH v2 1/2] nvme-core: change commas to semicolons in
 nvme_get_log_page
Message-ID: <1497791759-5754-1-git-send-email-sagi@grimberg.me>

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 4ff5114f467d..17a10549d688 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -815,11 +815,11 @@ int nvme_get_log_page(struct nvme_ctrl *dev, struct nvme_smart_log **log)
 	struct nvme_command c = { };
 	int error;
 
-	c.common.opcode = nvme_admin_get_log_page,
-	c.common.nsid = cpu_to_le32(0xFFFFFFFF),
+	c.common.opcode = nvme_admin_get_log_page;
+	c.common.nsid = cpu_to_le32(0xFFFFFFFF);
 	c.common.cdw10[0] = cpu_to_le32(
 			(((sizeof(struct nvme_smart_log) / 4) - 1) << 16) |
-			 NVME_LOG_SMART),
+			 NVME_LOG_SMART);
 
 	*log = kmalloc(sizeof(struct nvme_smart_log), GFP_KERNEL);
 	if (!*log)
-- 
2.7.4
