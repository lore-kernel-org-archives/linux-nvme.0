Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4291BC021A6
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 11:35:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Cki0tty7VOWm8UOzmV7zWNSntw2k3+EauO/5KMAxJuk=; b=Prg5K3URvv5XfjxDI3EiBGuEUp
	aWqy7UjoPnu2l5CjWeIVV+DEHQ/yo9IjPDpndySqdcNodl2m3bupyvbFiwS7nBJDspy5pfAFJx5CL
	AqAw1YuK9NA/Ai3Dfp07mmtQFAdSSZekipIUlqGnFfv8FhpBetSNDDF6qtviXhug+XyXmg7RG0D6g
	WyZwlT2mjnqMGLk76KHm5AcpIEkIkGuNrI8MrCSSBdEPjwIAaP+NPDHXRxyPLEZJijpKN/5+gnO0G
	mLFte1YeT4U30wwzNYl1JCf1YQADJGG9bRuOqT6qFf9NElNcY238XowrSWCXOwABCfAfg4aWYApz6
	umRTvDmw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWjv-0000000DQkz-21o8;
	Mon, 24 Feb 2025 11:35:11 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmWWO-0000000DKlS-3C3l
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 11:21:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3742C5C678E;
	Mon, 24 Feb 2025 11:20:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1182EC4CEE6;
	Mon, 24 Feb 2025 11:21:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740396071;
	bh=UPus0+ZeUvqXhZx/PdDail0k2XtlufLXZJTSFurCQD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=P/ro2FgAPF4T2r+0MKudRtmMjzJ/0z9E3/0To1KEhBMBqpq0E2MJhb26811NGEvIP
	 MZBHwH709ovoUzxVnjyZpzF/56TTOdusmBWBOCSOt5FLFH4dB8hGoPonhJFKUrwFNd
	 c4QLN9Jh/2YEJg25/KjP1eHrqxOTEKCfhPE2GVp4VhubV7XBCfmSVn8Uqzm8TO1Oys
	 bE4IqTp0Sdj7pDzUjheuqGVEfYt9UKpqFj54t9Xso1DIXUINUXymMjYFfUoBiOVDly
	 OyVpnqbHXaEpwCQWxTZp7K5L8zH/mE8hPgql8LBRKp9ME2XueJ4fLxmW3oI4S/972F
	 kMPS6TOG47otA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <wagi@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 7/7] nvme: only allow entering LIVE from CONNECTING state
Date: Mon, 24 Feb 2025 06:20:50 -0500
Message-Id: <20250224112051.2215017-7-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250224112051.2215017-1-sashal@kernel.org>
References: <20250224112051.2215017-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.234
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250224_032112_859251_586F1E8B 
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
index c739ac1761ba6..975d8ef514e80 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -384,8 +384,6 @@ bool nvme_change_ctrl_state(struct nvme_ctrl *ctrl,
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


