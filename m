Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABA3FC4828F
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Feb 2024 22:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=huQPf4lNYMrqeuQE2QV6OYHGExKpYhmvMYr4xZttrr4=; b=JVBeDV83I+xD0fV3DQ+0SP+A8D
	lhl583yVjOgaB0QQXIJbMh3l++xofOumC9Km8y4DliwL1vIaXzeuw2fLB+LntShHTTUD4CfRvC1WR
	wKXPntFSzp0+4DrgxXaMuz0bR+EcFv17uNkBcZfqIkeCSoDSO5nZGOB+MUFQgCUPBkYb9bbQ/yviX
	MZzxy41wE1roEomZlkujnkERqRVXDiIGf3ieVMUTh6J1JwKJy9Vg6M9tbovJJpdSoRMyQPKieM8Tv
	4e/eyUWPBn3YGvgW1CQjGLzQp974qf6QyXyQz0meQ81RBPlOzGy4zaN7Y9yT9trDkJ9SuUTM1+oB3
	JOzTT8uA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXqS4-0000000C6wZ-2imf;
	Wed, 07 Feb 2024 22:31:32 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPX-0000000BrmX-1Wfx
	for linux-nvme@bombadil.infradead.org;
	Wed, 07 Feb 2024 21:24:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=huQPf4lNYMrqeuQE2QV6OYHGExKpYhmvMYr4xZttrr4=; b=dfXO1Q665i7GqViEzOZWR9yqQD
	/mB8Y6Hej9Kd3n6Oou3z5hpSU8YhrAR4KdrGNkgMXk0sf9KK6BfMPUiUjAyFA+oiRPZL6reAT0jzp
	6gFbRQl7gdO6l3kM2ALa2bB9yMHWufOfQ54+ddPIsjEhhw+chRZGMpof7doxaRWTM3DzlY/8ftSUK
	WvUMOEv5zgcp73qX0PivuNciqHBAkA9SmYiRUIJhkirpn5iQ4QfEETUz8XxeraDLne7qAsLYSKZeI
	TzR98efpwzCq9VcBIYWvKLGw0Y8Qf4n23qdPQ7hcFu6ec5RpxkfBL8tX/p1N9gO703jT7o7K+XuWi
	ZXlR7SbQ==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXpPQ-0000000D7uA-0BhQ
	for linux-nvme@lists.infradead.org;
	Wed, 07 Feb 2024 21:24:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AD83ECE1B1E;
	Wed,  7 Feb 2024 21:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF62C43390;
	Wed,  7 Feb 2024 21:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341081;
	bh=0m736HT5x3zxAJ7MsSNWQ+HMziYNADUNf1eL8O+UpdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z3zst+7SEEDcvaPVNaUnCjdJAn1t3vjHPhdKvtQxaXURN8k3N2lfCQ5ja+EEfcq8z
	 pv+ZydOo8gZ2PVVtBwC/jqfvJB4M10kuGQRk0BcLGJqkHPPNWu4+Va5vYANCDwxKst
	 WnTDL96tH//SLZ2ouJCOrc2ddJUyn6l/I1IFmeOT/W1AFFQmQLkzmr8WMsvHPVDAT6
	 EQK41n79A2th4FypkDdKVU+wYqBEBujchJYgbGRBApF6fEKlUqlRxJ2hopBIpbJCnX
	 M5+KocgEHfrzq8ITf9sKdBcXtuQfcsGYxi8eBKKh2Sec4VNhvhTQbspiTeZ0E5FEP0
	 FxRHib3a+nsEw==
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
Subject: [PATCH AUTOSEL 6.6 31/38] nvmet-fc: hold reference on hostport match
Date: Wed,  7 Feb 2024 16:23:17 -0500
Message-ID: <20240207212337.2351-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240207_212444_463646_D1ED279A 
X-CRM114-Status: GOOD (  10.81  )
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
index c9ef642313c8..64c26b703860 100644
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


