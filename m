From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 19 Jun 2016 16:06:33 -0700
Subject: [PATCH 2/3] nvme: Add function for NVMe security receive command
In-Reply-To: <20160619230634.17229-1-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
Message-ID: <20160619230634.17229-3-kernel@jbeekman.nl>

Signed-off-by: Jethro Beekman <kernel at jbeekman.nl>
---
 drivers/nvme/host/core.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3a0d48c..da027ed 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1377,6 +1377,18 @@ static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 	}
 }
 
+int nvme_security_recv(struct nvme_ctrl *dev, u8 protocol, void *buf,
+		unsigned int len)
+{
+	struct nvme_command c = { };
+
+	c.common.opcode = nvme_admin_security_recv;
+	c.common.cdw10[0] = cpu_to_le32(((u32)protocol)<<24);
+	c.common.cdw10[1] = cpu_to_le32(len);
+
+	return nvme_submit_sync_cmd(dev->admin_q, &c, buf, len);
+}
+
 static bool nvme_security_is_locked(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
-- 
2.9.0
