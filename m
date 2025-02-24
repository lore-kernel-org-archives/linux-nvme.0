Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C53C0C021B5
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4UCovF4ehuHVvESWjWH9Jzzmm6FTysIvoc1H2tQNHl8=; b=tGwAh5kvjIojzdzibEa005cyfd
	ObmkK+7nS72gZOEonEfq4I9Ci9H1TEnE4DTJKPJlu/vca/PKcDo3JAB/3JTd70Vo1Ql0CcEVa7LkB
	k8KXjVx9LPVQ+AA2gfbZFTJPZjHxkGfbV5ITuZqVz6V13r8GroehicVa1WG1Mvo7oEOYA8z0dznPI
	DFRmx9G4A3LMbCXCFn4Vod7zP6L6Aw6bcl15gAs9jgT2Gys8hwPzC1Wc47U41snWRBuyDYJuneKfm
	/xq30HD4Gnl36g4h7XtkbO5NiYtuWDJAAOwDaQ1wsb/NtwLxySv/ea6hPNFUBSZ/XBHaTsXAB6fXH
	E6IL5EqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWgK-0000000DPa8-1SCp;
	Mon, 24 Feb 2025 11:31:28 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWVD-0000000DKAV-2RDE
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:20:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 098F45C6A26;
	Mon, 24 Feb 2025 11:19:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7B72C4CED6;
	Mon, 24 Feb 2025 11:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740395998;
	bh=RHx50UWp9P4Yws0Mg6XUcmjMYIw2REcQXVpiCmQ0bv4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L2DPlssdew+TRWmyAgFHY6pMkZ5FG25lAGDt/LgdwQF7Ot+yeGUlEIj1kMLIypPne
	 6TEolfuyYEskoWxOa46kBUhEAeoCWB7ltLjmlkZCEu1CHvVHnaRmmtP/a9Id3ps8JL
	 RiYynPGnTuQLNUfBvzAR8yDKGP7NcD5zGnEjkvPW5wpiZMb2VahmMBggqbxh/hFLKV
	 Phj7MH2DHSVUtqabMorDrgeEroXJQxfWVc50rLIKOGdUCVZqtPnX9i7T04i6Z9rXwv
	 /4qII2bChAX+Urmxve84Jkn+z3chcMHFmW4O/JL7an0u+hm6HIt5tHYSEZ5XQGj+mU
	 ny9CvK26irchg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 19/20] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:19:12 -0500
Message-Id: <20250224111914.2214326-19-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224111914.2214326-1-sashal@kernel.org>
References: <20250224111914.2214326-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.79
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_031959_673647_4B653A78 
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
index 8a200931bc297..f00665ad0c11a 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -503,8 +503,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


