Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A69AC3DA7D
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Jan 2023 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/coTbH+21Qw9F4c66qTOL2QSGd0XkYaB1p8vW/wRWyo=; b=r1TfAIXAi0NrouJBvtr9Fvrvto
	SCUjCJhycIEyberLxjfjwzbjTFD+D6iGpeq8KHgKzLZo8e4bbjdXZ8zZ3CF8HXJUKTTh5dEuTCVSJ
	qK+xpRbtl1nwfPAal7xnih8w0PZfVR1Bby6wBdze/asS7T4lYK0TplFNwjvTz3o6hjsXI+sZwoRyu
	uDpfjhSHPSoX8TTENulwkH+qc1aPntJZNPzXjeJen1nLZ3XfBhZyGu7z2bBgGgYf+wEp4TCRraSHx
	jZ/qaUNogLXKP4ck988Osmo6+wqNHXWTjl24ODt6KnJv5SYHIsS6xGtg6E0kQaQ+MNwSyoe42+L6x
	zqDPuvtg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCnRH-004cRj-EY; Tue, 03 Jan 2023 19:59:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pCmCr-003yIP-W8
	for linux-nvme@lists.infradead.org; Tue, 03 Jan 2023 18:40:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ACF4F614E9;
	Tue,  3 Jan 2023 18:40:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CD2C433EF;
	Tue,  3 Jan 2023 18:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1672771212;
	bh=124vP880Sh+1mZ3HL7f14EB8racDxeisiaWDZsM5ejg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JyrT7l4o7X0/HajmWXxGf/HSHevrSbr0nZ1u48KLlyt+FDgWO4uhXBSzlkmNYRHNf
	 zPSAF+pOPrqz5//bPhrlK/9H1Rf1KtETM+9xeANspDJp2qIoWl8HeRSwmYSOUp7Q+S
	 PLcB3l0uS+D2hoFlR1UdzNSlZWEuAZDCY9onxwucuvFxipGv7NWrzMuWrH508SFivO
	 poZH8CoMkg3tqTDohrEXpsJAHWHPCMY16NhatRL46laDcdq1kYomC9mpZSO5IiUFM1
	 0SzsI0BPr8YZxIVrETqk538IFo6tG1hyIHSdZjBtyz0kaJbNeQ9goL1DygNTxH5e5a
	 JTB2VP/++EA1w==
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
Subject: [PATCH AUTOSEL 6.0 4/4] nvme: also return I/O command effects from nvme_command_effects
Date: Tue,  3 Jan 2023 13:39:55 -0500
Message-Id: <20230103183956.2022789-4-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20230103183956.2022789-1-sashal@kernel.org>
References: <20230103183956.2022789-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230103_104014_187111_A460DF48 
X-CRM114-Status: GOOD (  18.51  )
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
index 3582a28a1dce..f06bae83e8ee 100644
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


