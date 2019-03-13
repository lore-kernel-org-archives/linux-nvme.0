From: hch@lst.de (Christoph Hellwig)
Date: Wed, 13 Mar 2019 18:54:55 +0100
Subject: [PATCH 02/17] nvme: don't warn on block content change effects
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
References: <20190313175510.20725-1-hch@lst.de>
Message-ID: <20190313175510.20725-3-hch@lst.de>

From: Keith Busch <keith.busch@intel.com>

A write or flush IO passthrough command is expected to change the
logical block content, so don't warn on these as no additional handling
is necessary.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Reviewed-by: Sagi Grimberg <sagi at grimberg.me>
Signed-off-by: Christoph Hellwig <hch at lst.de>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 07bf2bff3a76..dc1641247b17 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1250,7 +1250,7 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 	if (ns) {
 		if (ctrl->effects)
 			effects = le32_to_cpu(ctrl->effects->iocs[opcode]);
-		if (effects & ~NVME_CMD_EFFECTS_CSUPP)
+		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn(ctrl->device,
 				 "IO command:%02x has unhandled effects:%08x\n",
 				 opcode, effects);
-- 
2.20.1
