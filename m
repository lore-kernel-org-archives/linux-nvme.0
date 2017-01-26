From: maxg@mellanox.com (Max Gurtovoy)
Date: Thu, 26 Jan 2017 17:17:27 +0200
Subject: [PATCH 1/2] nvme: add semicolon in nvme_command setting
Message-ID: <1485443848-29478-1-git-send-email-maxg@mellanox.com>

Reviewed-by: Parav Pandit <parav at mellanox.com>
Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
---
 drivers/nvme/host/core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8a3c3e3..4300f88 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -568,8 +568,8 @@ int nvme_identify_ns(struct nvme_ctrl *dev, unsigned nsid,
 	int error;
 
 	/* gcc-4.4.4 (at least) has issues with initializers and anon unions */
-	c.identify.opcode = nvme_admin_identify,
-	c.identify.nsid = cpu_to_le32(nsid),
+	c.identify.opcode = nvme_admin_identify;
+	c.identify.nsid = cpu_to_le32(nsid);
 
 	*id = kmalloc(sizeof(struct nvme_id_ns), GFP_KERNEL);
 	if (!*id)
-- 
1.7.1
