From: kernel@jbeekman.nl (Jethro Beekman)
Date: Sun, 19 Jun 2016 16:06:32 -0700
Subject: [PATCH 1/3] nvme: When scanning namespaces,
 make sure the drive is not locked
In-Reply-To: <20160619230634.17229-1-kernel@jbeekman.nl>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
Message-ID: <20160619230634.17229-2-kernel@jbeekman.nl>

Signed-off-by: Jethro Beekman <kernel at jbeekman.nl>
---
 drivers/nvme/host/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 643f457..3a0d48c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1377,6 +1377,12 @@ static void __nvme_scan_namespaces(struct nvme_ctrl *ctrl, unsigned nn)
 	}
 }
 
+static bool nvme_security_is_locked(struct nvme_ctrl *ctrl,
+		struct nvme_id_ctrl *id)
+{
+	return false;
+}
+
 void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -1385,6 +1391,11 @@ void nvme_scan_namespaces(struct nvme_ctrl *ctrl)
 	if (nvme_identify_ctrl(ctrl, &id))
 		return;
 
+	if (nvme_security_is_locked(ctrl, id)) {
+		nvme_remove_namespaces(ctrl);
+		return;
+	}
+
 	mutex_lock(&ctrl->namespaces_mutex);
 	nn = le32_to_cpu(id->nn);
 	if (ctrl->vs >= NVME_VS(1, 1) &&
-- 
2.9.0
