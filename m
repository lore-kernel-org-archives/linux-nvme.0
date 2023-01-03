Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D43C3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 19:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=h+uT9h+CPpkqKvDzM5iP6oFcsY8u2CoA+8VNibagRS0=; b=UT22Dq/t6wwFSvFcHIQGNdmiqp
	jL3oK4vNhY2AOqQKVcLQ/tTrLDOVKogIbL2CQoYUyd+vhFB7PzZQI2ITm76NKAA3iKGb3Ej0YTyii
	bRXHKBBkRgaHQmvB2UMnTLVoosAKKFrlg5dDBGGVKGr1XP2unHBmcy3EB3fCXe4zgDuf+5x0v/yz6
	+jos/RAN7OwXOw8w8lbNL6gocwpcvTcIUtkau+/+5fYRxS0CMI84UYdjUAVpPJbUHiK+mLnNCl00I
	m910wuT8Q1WeURMl65VqX0HLoWcaTceCHy7WMM5zx5hez80w6YKBhvzT7TCLa8wDKIDUC8ZWYVnwP
	lOkHaJlQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnQp-004cJ8-Up; Tue, 03 Jan 2023 19:58:43 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCmCc-003y7z-Br
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 18:40:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B35FDB80EBF;
	Tue,  3 Jan 2023 18:39:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A88C433F1;
	Tue,  3 Jan 2023 18:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672771195;
	bh=jktih1V+pEJSNMJGLXpJMhxqZlHX4fppjmcyULYa1Ek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=coPo01GgIzfcYW4dKKFpwZ5V1UdEC/7xd53rxop8aDsOV/gbmwDt8kuCktljidEmh
	 xAzyNozER4wkseAYJV9FetPkDokjUwOWu+6V4T4d01+ueEPapwNGQ78r8nOX5E7lVv
	 Xk9Kde49FTv5iS7RjPJoK6haQbwzNvwPYhZI2dMPnjP+z7OLXhFGH5kRMbrij6l0rG
	 ZtoAijflwMYiStPT98Jf7hq7ZC+MT2FJ2H0jMFLbcPSCtm2uQ/fXQuO3HhZ6KGELB6
	 kR4GtN1dUsB0L1/AfbWCNtXeUzbm5fNJ+1N0lZVDx9LOhe6V1db/Afd289ES0xWZ3j
	 ReFKsmEtqfnHQ==
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
Subject: [PATCH AUTOSEL 6.1 10/10] nvme: also return I/O command effects from nvme_command_effects
Date: Tue,  3 Jan 2023 13:39:34 -0500
Message-Id: <20230103183934.2022663-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230103183934.2022663-1-sashal@kernel.org>
References: <20230103183934.2022663-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_104000_160747_002493E3 
X-CRM114-Status: GOOD (  18.78  )
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
index 108b5022cead..1ded96d1bfd2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1069,6 +1069,18 @@ static u32 nvme_known_admin_effects(u8 opcode)
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
@@ -1076,16 +1088,24 @@ u32 nvme_command_effects(struct nvme_ctrl *ctrl, struct nvme_ns *ns, u8 opcode)
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


