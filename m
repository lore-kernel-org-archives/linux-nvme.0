Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B864EC4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/8fNbY5BcE0b5koE9PhbGvDIwadvx66llJ0awkNunLU=; b=03V0AewXpeqNbkX6KMaQSijJNx
	x59IwrDWSINuMbBUiilDv5hYhvd2W9TqC2/T/hBUAjRgYGkKmCcA2kLOeo91vguVrYMYwDm+CJpRX
	EFSFpNC4ZMldOta+53dqHFjhdJby6KnWPi+l0Oi9IiX6R7KmrCk4f6Lqiel+fDgpUQQ14LDuOLNdm
	lTGuJslXYRSNCzPhedKCCkXdUc7H8MpHADmWgpyqyy8sU/8/4miNV2bdHAfPVysssho7dVaj9+B9B
	MNvV9v2clwEGHHBUoi9b8oFpPNP8M/NoXZTxL6HfY+oj2L+XilWu75AhS5l/oCFKi5IaYrFGq7exs
	/tHB7/zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOr-000Vee-Q9; Wed, 14 Dec 2022 16:14:29 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOX-000VQp-Gv; Wed, 14 Dec 2022 16:14:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 7/9] nvme: assign known effects at controller initialization time
Date: Wed, 14 Dec 2022 17:13:45 +0100
Message-Id: <20221214161347.764071-8-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221214161347.764071-1-hch@lst.de>
References: <20221214161347.764071-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Always allocate an in-memory commands and effects log in
nvme_init_identify, and assign the known effects there to remove branches
that check for the logs presence in the runtime passthrough path.

Note that instead of checking for ctrl->effects this also moves the
initialization in the initialized branch, which has the same effect, but
is a little easier to reason about.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 60 +++++++++++++++++++++++-----------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 945a947f90b757..9529abe22c9cdb 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1061,27 +1061,12 @@ int nvme_submit_sync_cmd(struct request_queue *q, struct nvme_command *cmd,
 }
 EXPORT_SYMBOL_GPL(nvme_submit_sync_cmd);
 
-static u32 nvme_known_admin_effects(u8 opcode)
-{
-	switch (opcode) {
-	case nvme_admin_format_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
-			NVME_CMD_EFFECTS_CSE_MASK;
-	case nvme_admin_sanitize_nvm:
-		return NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK;
-	default:
-		break;
-	}
-	return 0;
-}
-
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
-	u32 effects = 0;
+	u32 effects;
 
 	if (ns) {
-		if (ns->head->effects)
-			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
 				"IO command:%02x has unhandled effects:%08x\n",
@@ -1089,9 +1074,7 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		return 0;
 	}
 
-	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
+	effects = le32_to_cpu(ctrl->effects->acs[opcode]);
 
 	/* only return actual command effects and not misc information */
 	return effects & (NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
@@ -3066,6 +3049,33 @@ static int nvme_init_non_mdts_limits(struct nvme_ctrl *ctrl)
 	return ret;
 }
 
+static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
+{
+	int ret;
+
+	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
+		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
+		if (ret < 0)
+			return ret;
+	} else {
+		ctrl->effects = kzalloc(sizeof(*ctrl->effects), GFP_KERNEL);
+		if (!ctrl->effects)
+			return -ENOMEM;
+	}
+
+	/*
+	 * Initialize known admin command set effects for controllers don't
+	 * provide the log or are buggy enough to not correctly mark the
+	 * usual effects.
+	 */
+	ctrl->effects->acs[nvme_admin_format_nvm] |=
+		cpu_to_le32(NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_NCC |
+			    NVME_CMD_EFFECTS_CSE_MASK);
+	ctrl->effects->acs[nvme_admin_sanitize_nvm] |=
+		cpu_to_le32(NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK);
+	return 0;
+}
+
 static int nvme_init_identify(struct nvme_ctrl *ctrl)
 {
 	struct nvme_id_ctrl *id;
@@ -3079,18 +3089,16 @@ static int nvme_init_identify(struct nvme_ctrl *ctrl)
 		return -EIO;
 	}
 
-	if (id->lpa & NVME_CTRL_LPA_CMD_EFFECTS_LOG) {
-		ret = nvme_get_effects_log(ctrl, NVME_CSI_NVM, &ctrl->effects);
-		if (ret < 0)
-			goto out_free;
-	}
-
 	if (!(ctrl->ops->flags & NVME_F_FABRICS))
 		ctrl->cntlid = le16_to_cpu(id->cntlid);
 
 	if (!ctrl->identified) {
 		unsigned int i;
 
+		ret = nvme_init_effects(ctrl, id);
+		if (ret < 0)
+			goto out_free;
+
 		/*
 		 * Check for quirks.  Quirk can depend on firmware version,
 		 * so, in principle, the set of quirks present can change
-- 
2.35.1


