Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C87C4829A
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RH2FZWFPU47O7LXqrJKX3MP8JxYdrhdmnAEk+PNJ0n8=; b=fexAni/B/afI+EYqLOeSBn+98+
	sRm5xt8pLgQhnH6cEsUliSkaa3bqkDnyZ0a65VpqOJbHaAn4Sop+PZ79T5z4qw3VTBY7Z2G6sWY6q
	9HsPbGfsf5KYYNvVslHj/EDWzcqwINiTm5QpsC5mfHYcJLoD4KUM/+D0+l+kP8La4A/aTueX7Ykcb
	kejG0U6e32kBc3WVOJ9o2UlW2ZsQ7a/XyrdPL54TpVZ3ybufYkZLLRWeaosflifwSqOfdUKd7QJ9D
	PNooKYZ/4hOQt60SxHv6zZKaK1MjJuk2KeV1BwhHNckGa/coJIf/XGBKQxNhy3VKoFwC0Mp5PPfgJ
	jNpo64VA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqSC-0000000C71l-3xbO;
	Wed, 07 Feb 2024 22:31:40 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpRP-0000000Bt8j-19JE
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:26:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AA0E561A30;
	Wed,  7 Feb 2024 21:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E1DC43390;
	Wed,  7 Feb 2024 21:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341206;
	bh=hoHS8WJ1bCxJD7223y6b4qAhyH6ShPuiSM0HyRAfLpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HQZwmWRc8+dE0TbLlCyF8fOkXI9CVrdB7puTRVIICaz1Y9/Kg2UnnIgRnrMuWszwE
	 YVeg8t3zvLlwBnZpVMPLd8n+CqgDJQ1UtEEcVtZLfsaCqKOgmcuwrw1+nNFgKD+DaP
	 hJ98ElW/VVp4/KmCnV2MZN9k6XjxXXElIFTqz8eR11TzY+ltZpS/YKDp5uNbqpnIFI
	 JhSaSpdRyXRWbdQiDVLay7E+lrEgx/qg6+WiG5vbBPmGfxntLBptHA0qg7kNH1/kOw
	 k+QKKTYFZdbjp2swKg//1Qsr/VpiXrlBXZpLO3P5Xep0Q0Rx2UwOTAX7U5VbAnCnE1
	 toWjVdpu8nXGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	james.smart@broadcom.com,
	sagi@grimberg.me,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 18/23] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:25:59 -0500
Message-ID: <20240207212611.3793-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_132647_554487_33677764 
X-CRM114-Status: GOOD (  10.86  )
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

From: Daniel Wagner <dwagner@suse.de>

[ Upstream commit ca121a0f7515591dba0eb5532bfa7ace4dc153ce ]

The hostport data structure is shared between the association, this why
we keep track of the users via a refcount. So we should not decrement
the refcount on a match and free the hostport several times.

Reported by KASAN.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Daniel Wagner <dwagner@suse.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/fc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 97f4ec37f36d..06d11bb7b944 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -1069,8 +1069,6 @@ nvmet_fc_alloc_hostport(struct nvmet_fc_tgtport *tgtport, void *hosthandle)
 		/* new allocation not needed */
 		kfree(newhost);
 		newhost = match;
-		/* no new allocation - release reference */
-		nvmet_fc_tgtport_put(tgtport);
 	} else {
 		newhost->tgtport = tgtport;
 		newhost->hosthandle = hosthandle;
-- 
2.43.0


