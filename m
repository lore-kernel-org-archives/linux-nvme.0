Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D39CBC4167B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Dec 2022 16:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N0ncwjTkexsEw96Q0nCetw8rooUycetekgQM+uWLC2w=; b=Ai8nJnFJyd7i3FcgFExnwLducM
	XTWmBNji/Soc//i4VSQNSLkkTRw2+rRTb5w6LMM1Xh24Iz8oykmHENkJifwfgooHCCcnwr8pEixU9
	qzuL41BWje+CFVAKbWrQ9Y7UlszYDcijLuF6sAll0IaR9CLau79pIex91bBfyKxKLrfPeHhoHRC4i
	BlyiyC2KPY9sI34yUw0jIMoHC7hlyO7JdQpmxdxToK2ilDZhuoTa5psMlztZQmKyz3elU3TUkzaZJ
	7b2rRXuoxgGgpKGfvKynq7nf7VdgtPxvowpBuvDZCki3HSKiQOlEC4p8tFnuJ/Rd8ak8wtj69XoxN
	1505Qi9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585s-002ooH-3P; Tue, 13 Dec 2022 16:25:24 +0000
Received: from [2001:4bb8:192:2f53:30b:ddad:22aa:f9f9] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p585d-002ofv-Fa; Tue, 13 Dec 2022 16:25:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Kanchan Joshi <joshi.k@samsung.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 5/7] nvme: only return actual effects from nvme_command_effects
Date: Tue, 13 Dec 2022 17:24:51 +0100
Message-Id: <20221213162453.584965-6-hch@lst.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221213162453.584965-1-hch@lst.de>
References: <20221213162453.584965-1-hch@lst.de>
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

Only return actual destructive effects from the command, and not misc
information like if the command is supported, the scope and support for
the UUID index.

Note that this causes the nvmet passthrough code to now execute
admin commands asynchronously, which it previously did not due to the
supported by in the returned effects.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 955e960f2d908f..e9b721bbb5f95f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1093,7 +1093,10 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
 	effects |= nvme_known_admin_effects(opcode);
 
-	return effects;
+	/* only return actual command effects and not misc information */
+	return effects & (NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC |
+			  NVME_CMD_EFFECTS_NCC | NVME_CMD_EFFECTS_NIC |
+			  NVME_CMD_EFFECTS_CCC | NVME_CMD_EFFECTS_CSE_MASK);
 }
 EXPORT_SYMBOL_NS_GPL(nvme_command_effects, NVME_TARGET_PASSTHRU);
 
-- 
2.35.1


