From: keith.busch@intel.com (Keith Busch)
Date: Thu, 28 Feb 2019 08:38:51 -0700
Subject: [PATCH] nvme: Don't warn on block content change effects
Message-ID: <20190228153851.21825-1-keith.busch@intel.com>

A write or flush IO passthrough command is expected to change the
logical block content, so don't warn on these as no additional handling
is necessary.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07bf2bff3a76..e1d3e9c41d84 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1250,7 +1250,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (ns) {
 		if (ctrl->effects)
 			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
-		if (effects & ~NVME_CMD_EFFECTS_CSUPP)
+		if (effects & ~(NVME_CMD_EFFECTS_CSUPP|NVME_CMD_EFFECTS_LBCC))
 			dev_warn(ctrl->device,
 				 "IO command:%02x has unhandled effects:%08x\n",
 				 opcode, effects);
-- 
2.14.4
