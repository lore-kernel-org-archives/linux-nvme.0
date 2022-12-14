Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1040C4332F
	for <linux-nvme@archiver.kernel.org>; Wed, 14 Dec 2022 16:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QLcpoZsRWHHrX6/ELnLlpx9guejkSisskjPKtk6dbxg=; b=xxAmT2VbD8YUn057XummsHS513
	wlTgqh5s7M5D9h6DQAot3JPYngbSoCiH1XgeTRC3n0xgoKFaM4SGC8mbKB4fm7xPWwS0CtIoevIcv
	N1UjJJeQ7RaEhNudr1peA1TII7f/QwsJ5AIn9XiZKPcyLqDO+XMxjC8BeNfQHfrc+xDw9JpDnloVt
	PN+fieG94PpnA4cI/kc9HCesZ/UbLDc4AXuUTbZr1yyhPtYXsY4CpwjxJi+OEUOtSufWFeXs/+/87
	AxEkQF2VmYfTA+AL66OYYGCYEuxgBMM+XZQU1FTxwOIj6nmmVCAsFjISYODQrn+XNt8hzfhMI4Cpb
	P/KXi73w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UP1-000VnH-B6; Wed, 14 Dec 2022 16:14:39 +0000
Received: from [2001:4bb8:192:2f53:94cc:fc26:a27c:8f96] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5UOa-000VSU-9q; Wed, 14 Dec 2022 16:14:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 8/9] nvme: also return I/O command effects from nvme_command_effects
Date: Wed, 14 Dec 2022 17:13:46 +0100
Message-Id: <20221214161347.764071-9-hch@lst.de>
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

To be able to use the Commands Supported and Effects Log for allowing
unprivileged passtrough, it needs to be corretly reported for I/O
commands as well.  Return the I/O command effects from
nvme_command_effects, and also add a default list of effects for the
NVM command set.  For other command sets we do require the log page
to be present already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9529abe22c9cdb..c50678390def38 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1069,13 +1069,12 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
-				"IO command:%02x has unhandled effects:%08x\n",
+				"IO command:%02x has unusual effects:%08x\n",
 				opcode, effects);
-		return 0;
+	} else {
+		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
 	}
 
-	effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-
 	/* only return actual command effects and not misc information */
 	return effects & (NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
 			  NVME_CMD_EFFECTS_NCC | NVME_CMD_EFFECTS_NIC |
@@ -3064,8 +3063,8 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 	}
 
 	/*
-	 * Initialize known admin command set effects for controllers don't
-	 * provide the log or are buggy enough to not correctly mark the
+	 * Initialize known admin and NVM command set effects for controllers
+	 * don't provide the log or are buggy enough to not correctly mark the
 	 * usual effects.
 	 */
 	ctrl->effects->acs[nvme_admin_format_nvm] |=
@@ -3073,6 +3072,13 @@ static int nvme_init_effects(struct nvme_ctrl *ctrl, struct nvme_id_ctrl *id)
 			    NVME_CMD_EFFECTS_CSE_MASK);
 	ctrl->effects->acs[nvme_admin_sanitize_nvm] |=
 		cpu_to_le32(NVME_CMD_EFFECTS_LBCC | NVME_CMD_EFFECTS_CSE_MASK);
+
+	ctrl->effects->iocs[nvme_cmd_write] |=
+		cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
+	ctrl->effects->iocs[nvme_cmd_write_zeroes] |=
+		cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
+	ctrl->effects->iocs[nvme_cmd_write_uncor] |=
+		cpu_to_le32(NVME_CMD_EFFECTS_LBCC);
 	return 0;
 }
 
-- 
2.35.1


