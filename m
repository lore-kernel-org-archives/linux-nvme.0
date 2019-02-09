From: sashal@kernel.org (Sasha Levin)
Date: Sat,  9 Feb 2019 13:47:16 -0500
Subject: [PATCH AUTOSEL 4.20 24/42] nvme: pad fake subsys NQN vid and ssvid
 with zeros
In-Reply-To: <20190209184734.125935-1-sashal@kernel.org>
References: <20190209184734.125935-1-sashal@kernel.org>
Message-ID: <20190209184734.125935-24-sashal@kernel.org>

From: Keith Busch <keith.busch@intel.com>

[ Upstream commit 3da584f57133e51aeb84aaefae5e3d69531a1e4f ]

We need to preserve the leading zeros in the vid and ssvid when generating
a unique NQN. Truncating these may lead to naming collisions.

Signed-off-by: Keith Busch <keith.busch at intel.com>
Signed-off-by: Christoph Hellwig <hch at lst.de>
Signed-off-by: Sasha Levin <sashal at kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 962012135b62..971ca6754959 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2095,7 +2095,7 @@ static void nvme_init_subnqn(struct nvme_subsystem *subsys, struct nvme_ctrl *ct
 
 	/* Generate a "fake" NQN per Figure 254 in NVMe 1.3 + ECN 001 */
 	off = snprintf(subsys->subnqn, NVMF_NQN_SIZE,
-			"nqn.2014.08.org.nvmexpress:%4x%4x",
+			"nqn.2014.08.org.nvmexpress:%04x%04x",
 			le16_to_cpu(id->vid), le16_to_cpu(id->ssvid));
 	memcpy(subsys->subnqn + off, id->sn, sizeof(id->sn));
 	off += sizeof(id->sn);
-- 
2.19.1
