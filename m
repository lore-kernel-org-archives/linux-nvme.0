Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D980C10F05
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Dec 2023 13:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kqxOzhnoCJ0tWp+5lkVllYuZKOgzyClKXgXO/oH951I=; b=Za55ILvdwxyYUBN5GRo6u4BwIt
	bcFDVcXpaaC72noXvHFxQVCmRBZfBhOwfdSuEbIIeblam8jXbcb7GBjawncTCipXV4o5abhDRDkJ5
	IWKs66DrJUmSK/GEt+4nOo/177YF42sByvKDijOaf9SeJ9mGvS0+u09942lvC4HmHklfhQjzvYrvK
	r+a77nr6X8oHCnCoP0IXpBwXgsIO1333Yyg735cDG+yiSWFA63fjXtCCTyroc34Pb9KlgW6CY59LG
	3f+zkC+9uBWSFGSo68nOF+A04bPvhsE/Vqro05iFMwqfC79se8Lr6ZDBK3jSkGMV1YYib3FbLMeGN
	N6GPep0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgin-0051WQ-31;
	Mon, 11 Dec 2023 13:53:22 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rCgik-0051Uk-2d
	for linux-nvme@lists.infradead.org;
	Mon, 11 Dec 2023 13:53:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by ams.source.kernel.org (Postfix) with ESMTP id EB902B80E65;
	Mon, 11 Dec 2023 13:53:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 778F4C433D9;
	Mon, 11 Dec 2023 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302796;
	bh=1FGXzOaZOzxS1ldc+LzGNkdq2ud1cBYt+XVVjU4funE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pRCc1b2WPQgue2UgbIoR8NQ6YnRdj/VliRRRNP8S/xFAyVG1PEqO84kTrgzov3IAc
	 9dVFLIouJ2GkAUVoD0sB/AGfh/yClZ5Z9xK9evDdpZgwibFcNRnbV69k1kIQ2FQrog
	 uxcmYCxZMGVF0dMhMUQDuorGxeyjXjP3fFVEO1xbrMUTwujvLQkrjGdVv6JruXp4Vj
	 Bfg4VJDk6fD2OfC8UZi2ZGfzwGAIaHgZvlepFfBgNeLsY+MGJKc2U6FzX2bbjeGRYa
	 2TkOfTYk1Rr8H+GLsVBsTf6JObBh3/+FrJMX285iXT+fPd9jntPIgPFbk1bUrzPHuU
	 IS9thvHb7/8GA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 30/47] nvme: introduce helper function to get ctrl state
Date: Mon, 11 Dec 2023 08:50:31 -0500
Message-ID: <20231211135147.380223-30-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit 5c687c287c46fadb14644091823298875a5216aa ]

The controller state is typically written by another CPU, so reading it
should ensure no optimizations are taken. This is a repeated pattern in
the driver, so start with adding a convenience function that returns the
controller state with READ_ONCE().

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f35647c470afa..68313148e6ed5 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -386,6 +386,11 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 };
 
+static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
+{
+	return READ_ONCE(ctrl->state);
+}
+
 enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
-- 
2.42.0


