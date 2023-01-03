Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 702D7C4708E
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 19:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7vW3XqW214Y2LZHRfXJ2joc1ch208BwTV3LoOjQZHrc=; b=qolVbXrVSH1irnB3mxdqyjsfU8
	hq6zc8wXBaMLqk+PyEJUEk8bqo9iBuiXjRURDIi4lPQm9k6arV3md9dK5moFKpW5MrdjPZIQ7E4t4
	pmaauzdyVBSn6GJjXgNaJ6kyt2vBmifUJEM9qZuxA9n1uS4SjqRUEtU5zHdM9M7yQ7lyjYNmgZ6n0
	TD/USygblZiFMIOjtC7q1Mt00cAt5PH/DGDjqgYzXvGQW4puOxw/98oVh/1W7WSrI99wTLYvJU85J
	R131lce3vJ/klBKDKIucRmewgSH7BeuThI5VdMTC85WZiHxFyDavCtngLPWipRAAFydyAdB00L2tG
	V6K/EX4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnRq-004cf5-1L; Tue, 03 Jan 2023 19:59:46 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCmCz-003yN7-AS
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 18:40:23 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 8C853B810A6;
	Tue,  3 Jan 2023 18:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B09C43392;
	Tue,  3 Jan 2023 18:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672771219;
	bh=PUvFWrT9DlCbVEwFrGsscLlqDiFiyTjq461Sr9f4JQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JoQ/AM3zd0PTQZPuKEdC/ie208muKnSeZ+FeWar5gPu5TUYnTxTm7AmF7+pa4zLoq
	 Hs9KH8V5jch9jy41O+REK0Qu8dkEolKD6hklUnXTKqcQx05BghZepTehG+n6H9Dise
	 KKEzxvAOtwGvPjZp/H7YdRKvrKBHWu3Vnt4BBdPnAgD3Q+VHBJ/LFLdaTZSrhSEqFg
	 NGGGpxkgyagqPcOxRaxwvGI+GouLqpuJexwASq9oJ5f3wPiP5Rp80WbFHLRKVhYFAa
	 Q4diNroEiw4x+kpNNftpaYHGHhdQIRNmGhY8B4agTYuLrqxWWLE6Nk3mHsOZbNgBJV
	 dcZoNqqmv5wyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 4/4] nvme: also return I/O command effects from nvme_command_effects
Date: Tue,  3 Jan 2023 13:40:12 -0500
Message-Id: <20230103184013.2022849-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230103184013.2022849-1-sashal@kernel.org>
References: <20230103184013.2022849-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_104021_742729_E49FA74B 
X-CRM114-Status: GOOD (  18.89  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit 831ed60c2aca2d7c517b2da22897a90224a97d27 ]

To be able to use the Commands Supported and Effects Log for allowing
unprivileged passtrough, it needs to be corretly reported for I/O
commands as well.  Return the I/O command effects from
nvme_command_effects, and also add a default list of effects for the
NVM command set.  For other command sets, the Commands Supported and
Effects log is required to be present already.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 2d5b5e0fb66a..672f53d5651a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1113,6 +1113,18 @@ static u32 nvme_known_admin_effects(u8 opcode)
 	return 0;
 }
 
+static u32 nvme_known_nvm_effects(u8 opcode)
+{
+	switch (opcode) {
+	case nvme_cmd_write:
+	case nvme_cmd_write_zeroes:
+	case nvme_cmd_write_uncor:
+		 return NVME_CMD_EFFECTS_LBCC;
+	default:
+		return 0;
+	}
+}
+
 u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 {
 	u32 effects = 0;
@@ -1120,16 +1132,24 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
 	if (ns) {
 		if (ns->head->effects)
 			effects = le32_to_cpu(ns->head->effects->iocs[opcode]);
+		if (ns->head->ids.csi == NVME_CAP_CSS_NVM)
+			effects |= nvme_known_nvm_effects(opcode);
 		if (effects & ~(NVME_CMD_EFFECTS_CSUPP | NVME_CMD_EFFECTS_LBCC))
 			dev_warn_once(ctrl->device,
-				"IO command:%02x has unhandled effects:%08x\n",
+				"IO command:%02x has unusual effects:%08x\n",
 				opcode, effects);
-		return 0;
-	}
 
-	if (ctrl->effects)
-		effects = le32_to_cpu(ctrl->effects->acs[opcode]);
-	effects |= nvme_known_admin_effects(opcode);
+		/*
+		 * NVME_CMD_EFFECTS_CSE_MASK causes a freeze all I/O queues,
+		 * which would deadlock when done on an I/O command.  Note that
+		 * We already warn about an unusual effect above.
+		 */
+		effects &= ~NVME_CMD_EFFECTS_CSE_MASK;
+	} else {
+		if (ctrl->effects)
+			effects = le32_to_cpu(ctrl->effects->acs[opcode]);
+		effects |= nvme_known_admin_effects(opcode);
+	}
 
 	return effects;
 }
-- 
2.35.1


