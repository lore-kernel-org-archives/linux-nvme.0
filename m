From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 15 Aug 2017 12:24:05 +0300
Subject: [PATCH] nvme: fix identify namespace logging
Message-ID: <1502789045-10260-1-git-send-email-sagi@grimberg.me>

Use ctrl->device and lose the func name.

Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 25a12998a498..a2ac892f470e 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1174,7 +1174,7 @@ static void nvme_config_discard(struct nvme_ns *ns)
 static int nvme_revalidate_ns(struct nvme_ns *ns, struct nvme_id_ns **id)
 {
 	if (nvme_identify_ns(ns->ctrl, ns->ns_id, id)) {
-		dev_warn(ns->ctrl->dev, "%s: Identify failure\n", __func__);
+		dev_warn(ns->ctrl->device, "Identify namespace failed\n");
 		return -ENODEV;
 	}
 
-- 
2.7.4
