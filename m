Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E455EC021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:29:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zzdk5eaT/4BGYAIi+RhzvPhH6bH3rINsLM7biNfmRo=; b=BzgclYVPOrg8ygh7V2ZcC80wsJ
	AL/meftJH1NQPMjT4xJgdoa1GDLAYW9DBCJZVVqNk5wshmKSgdGSwAjDwqbWJW2hqupDyPMawTBF4
	TUf6CX1LZA956cUH4xTRpmgFiCfuCGDPIKxQEx1qcJgjHBPpIkpFm6ALM1ScjKZEBA88I49hsRSfA
	6hcU1a1O5NG75LTUVuPMVcsM7C9v4h2RwMwj/YkCVbKsHDnTCntCdYyTZ3MBM07ZPu4YuZQHPGfxY
	gMzDqwmcdsFdpMg3vmzgzgSDN7cbSd6VgSNWwy4+kDXObhh1lHNEJPfDiBFYEdi1wrBvvbviaMc3I
	+u5J1N3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWeo-0000000DOgh-0lI9;
	Mon, 24 Feb 2025 11:29:54 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWUS-0000000DJpK-3Ld0
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:19:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 508F55C678E;
	Mon, 24 Feb 2025 11:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27566C4CED6;
	Mon, 24 Feb 2025 11:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395952;
	bh=5BLqzVlb9eFt0vtMm48SFNFPZzl7igeCN/Q8L6MB0E4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uXbbKFXBhUQ28QNOH9K8lUnEWjhLfntoZ/nyHoKEjzQe7h2rweUHAvvTQyaY2oYW/
	 XT2R5XlAwiYY3+VoMymX9PO6Bxe1dTFbmykuPm4TI6xsyx+ioUNySypdrWAdhLHDFO
	 LpxbntwhHoFFAvTxH/RkyRrohSmSj/RQdWWxXYXuhQg/3+RrL9osp8HFkKaSwb+UWM
	 lFeVQNOpb5oIyY1sSD9tgb1BkFYK91xPzRI/Qt1kgLRqv2Si4bg6xMUtEr0f9ObaOK
	 w6Im3592R0kb/NRsARpUcujd1PEiS0PxMiAluzPcKI0dRAggGo9vL1aBTPpAed6CbS
	 hqRzbeqFtix3w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 27/28] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:17:58 -0500
Message-Id: <20250224111759.2213772-27-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111759.2213772-1-sashal@kernel.org>
References: <20250224111759.2213772-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_031912_889529_FFCB9CA2 
X-CRM114-Status: UNSURE (   8.95  )
X-CRM114-Notice: Please train this message.
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

From: Daniel Wagner <wagi@kernel.org>

[ Upstream commit d2fe192348f93fe3a0cb1e33e4aba58e646397f4 ]

The fabric transports and also the PCI transport are not entering the
LIVE state from NEW or RESETTING. This makes the state machine more
restrictive and allows to catch not supported state transitions, e.g.
directly switching from RESETTING to LIVE.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 8da50df56b079..a950aa780d1f6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -562,8 +562,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
 	switch (new_state) {
 	case NVME_CTRL_LIVE:
 		switch (old_state) {
-		case NVME_CTRL_NEW:
-		case NVME_CTRL_RESETTING:
 		case NVME_CTRL_CONNECTING:
 			changed = true;
 			fallthrough;
-- 
2.39.5


