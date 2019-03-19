From: mlevitsk@redhat.com (Maxim Levitsky)
Date: Tue, 19 Mar 2019 16:41:12 +0200
Subject: [PATCH 5/9] nvme/pci: add known admin effects to augument admin
 effects log page
In-Reply-To: <20190319144116.400-1-mlevitsk@redhat.com>
References: <20190319144116.400-1-mlevitsk@redhat.com>
Message-ID: <20190319144116.400-6-mlevitsk@redhat.com>

Add known admin effects even if hardware has known admin effects page,
since hardware can't be ever trusted to report sane values.
(on my Intel DC P3700, it reports no side effects for namespace format)

Signed-off-by: Maxim Levitsky <mlevitsk at redhat.com>
---
 drivers/nvme/host/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index cf9de026cb93..e1cef428c7e9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1260,8 +1260,8 @@ static u32 nvme_passthru_start(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
 
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
