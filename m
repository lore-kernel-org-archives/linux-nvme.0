From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 19 Jun 2016 16:06:34 -0700
Subject: [PATCH 3/3] nvme: Check if drive is locked using ATA Security
In-Reply-To: <20160619230634.17229-1-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
Message-ID: <20160619230634.17229-4-kernel@jbeekman.nl>

Signed-off-by: Jethro Beekman <kernel at jbeekman.nl>
---
 drivers/nvme/host/core.c | 49 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 48 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index da027ed..0164122 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1389,10 +1389,57 @@ int nvme_security_recv(struct nvme_ctrl *dev, u8 protocol, void *buf,
 	return nvme_submit_sync_cmd(dev->admin_q, &c, buf, len);
 }
 
+#define OACS_SECURITY (1<<0)
+#define SCSI_SECURITY_PROTOCOL_ATA_SECURITY 0xef
+#define ATA_SECURITY_LOCKED 0x4
+
 static bool nvme_security_is_locked(struct nvme_ctrl *ctrl,
 		struct nvme_id_ctrl *id)
 {
-	return false;
+	int err;
+	unsigned int i;
+	bool found;
+	u8 protocols[256+8]; /* 8 byte hdr + max number of possible protocols */
+	u8 ata_security[16];
+	u16 n;
+
+	/* security commands supported? */
+	if (!(le16_to_cpu(id->oacs) & OACS_SECURITY))
+		return false;
+
+	/* list security protocols */
+	err = nvme_security_recv(ctrl, 0, protocols, sizeof(protocols));
+	if (err) {
+		dev_warn(ctrl->device, "nvme_security_recv returned error %xh\n",
+					err);
+		return false;
+	}
+
+	/* find ata security protocol */
+	n = be16_to_cpup((__be16 *)(protocols+6));
+	if (n >= 256) {
+		dev_warn(ctrl->device, "security info protocol returned more than 256 protocols\n");
+		return false;
+	}
+	found = false;
+	for (i = 0; i <= n; i++) {
+		if (protocols[8+i] == SCSI_SECURITY_PROTOCOL_ATA_SECURITY) {
+			found = true;
+			break;
+		}
+	}
+	if (!found)
+		return false;
+
+	/* do ata security identify */
+	err = nvme_security_recv(ctrl, SCSI_SECURITY_PROTOCOL_ATA_SECURITY,
+			ata_security, sizeof(ata_security))
+	if (err) {
+		dev_warn(ctrl->device, "nvme_security_recv returned error %xh\n",
+					err);
+		return false;
+	}
+	return ata_security[1] == 0xe && (ata_security[9]&ATA_SECURITY_LOCKED);
 }
 
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
-- 
2.9.0
