From: keith.busch@intel.com (Keith Busch)
Date: Tue,  8 Jan 2019 09:37:43 -0700
Subject: [PATCH] nvme: Pad fake subsys NQN vid and ssvid with zeros
Message-ID: <20190108163743.18214-1-keith.busch@intel.com>

We need to preserve the leading zeros in the vid and ssvid when generating
a unique NQN. Truncating these may lead to naming collisions.

Signed-off-by: Keith Busch <keith.busch at intel.com>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8daa13dd5c63..d8a5a6b377fd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2186,7 +2186,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%4x%4x",
+			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.14.4
