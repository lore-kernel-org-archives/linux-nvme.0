From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Thu,  2 May 2019 14:31:34 +0300
Subject: [PATCH 2/2] nvme/pci: add known admin effects to augument admin
 effects log page
In-Reply-To: <20190502113134.20835-1-mlevitsk@redhat.com>
References: <20190502113134.20835-1-mlevitsk@redhat.com>
Message-ID: <20190502113134.20835-3-mlevitsk@redhat.com>

Add known admin effects even if hardware has known admin effects page,
since hardware can't be ever trusted to report sane values.
(on my Intel DC P3700, it reports no side effects for namespace format)

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 3dd043aa6d1f..2e11d014d514 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1259,8 +1259,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
 	if (ctrl->effects)
 		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	else
-		effects = nvme_known_admin_effects(opcode);
+
+	effects |= nvme_known_admin_effects(opcode);
 
 	/*
 	 * For simplicity, IO to all namespaces is quiesced even if the command
-- 
2.17.2
