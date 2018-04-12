From: keith.busch@intel.com (Keith Busch)
Date: Thu, 12 Apr 2018 09:16:14 -0600
Subject: [PATCH 12/13] nvme: Use admin command effects for admin commands
In-Reply-To: <20180412151615.5176-1-keith.busch@intel.com>
References: <20180412151615.5176-1-keith.busch@intel.com>
Message-ID: <20180412151615.5176-13-keith.busch@intel.com>

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index b09940c556d0..aac3c1d2b2a2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1102,7 +1102,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	}
 
 	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
+		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
 	else
 		effects = nvme_known_admin_effects(opcode);
 
-- 
2.14.3
