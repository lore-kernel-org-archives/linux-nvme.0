Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE86CECAAD2
	for <linux-nvme@archiver.kernel.org>; Mon, 29 Aug 2022 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yn+Q2JUYV0tj6l3dYBorscdD+XiI9UMJVe9ukb7HUwE=; b=pivClDakbxGf+yz+51NCtefCvd
	iRBt7CamNHs3GuSLPjHqdmXw0KZUmpuqywGaNIaTHyeAP/8+Lcx8UcdWfMG3R9DojgqwJgR/yH9sq
	oujF5c5BRC+8Sev8R4jhF4QXHWQlKFJ+fRhvYlRfNhZ0imzWXYyKlykUUJkQlCGVFBEX4sg6zZYq7
	/NiPEt+hazPkTbKWofy4PSYOoGNu9C/Un1YqXjrds0g3CdJI+iXtUBJl8J4Sd/YDyGhNoyOGVWsED
	wSIh+0ds3VVjvJQlmwBtby7ia20wPHNNVTOZ5IEcSRW0cLbSLb4TmQgdt+LGOpkCJBLwmRvqypgvT
	OzjgUcNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oShpm-00BqDU-2T; Mon, 29 Aug 2022 16:41:58 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oShdj-00BkiD-Cc
	for linux-nvme@lists.infradead.org; Mon, 29 Aug 2022 16:29:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BB94F61216;
	Mon, 29 Aug 2022 16:29:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B308CC433D6;
	Mon, 29 Aug 2022 16:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1661790569;
	bh=ETuaT/8fwD32DuXL1Z5VAZuIwL5iYZAIwh8cJ5wbTbo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=inlH0wuM6qThE7nZ6ek33AT6cswQd93XgSi+0mJn+LGOGeTtjiSqqTz6bIK956+/r
	 yus5kCwrhsiEGD3NgRKl4+mgGE5bMi/GmMzOLq5sEfiFOVKFoJwkofq4mFidxqht2I
	 dGuuFUSji52JBXUW/iDqrrJBZxzspPCcQfxQco0pUbDDWW7pZdriL6OJLxO0fIkB86
	 Ow7fshsBzOsi/gWQu0CC5hVpTJ3+qDWcEQpZ31b39TD3CQt0/3wZjCmaMgYyF8wN3+
	 jxMCOdkfKPS30l+unFJ6LoQSkeNhA+XE72IRutUcRUJLbtpkJKE/8YCK3OfqVj2Nwh
	 dsrt9NwJhdhjQ==
Date: Mon, 29 Aug 2022 10:29:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Christoph Hellwig <hch@lst.de>, lixingyuan@inspur.com,
	linux-nvme@lists.infradead.org
Subject: Re: [Regression] Bug 216400 - Firmware activation starting AEN
 processing prevents further AER commands sent to the NVMe controller.
Message-ID: <YwzpZpBgXM/U9GEP@kbusch-mbp.dhcp.thefacebook.com>
References: <5e8c01cb-2dc1-e460-6bb2-c9861080154f@leemhuis.info>
 <dfe23fad-671f-f3fc-4a99-52690b2c1bf2@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfe23fad-671f-f3fc-4a99-52690b2c1bf2@grimberg.me>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220829_092931_548222_84F703E6 
X-CRM114-Status: GOOD (  25.29  )
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

On Mon, Aug 29, 2022 at 12:14:21PM +0300, Sagi Grimberg wrote:
> 
> 
> On 8/26/22 15:19, Thorsten Leemhuis wrote:
> > Hi, this is your Linux kernel regression tracker.
> > 
> > I noticed a regression report in bugzilla.kernel.org that afaics nobody
> > acted upon since it was reported. That's why I decided to forward it by
> > mail to those that afaics should handle this.
> > 
> > To quote from https://bugzilla.kernel.org/show_bug.cgi?id=216400 :
> > 
> > >   lixingyuan 2022-08-23 01:14:50 UTC
> > > 
> > > This bug is related to these two commits:
> > > 
> > > 1. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=4c75f877853cfa81b12374a07208e07b077f39b8
> > > 
> > > These codes will set the controller state to NVME_CTRL_RESETTING while handling the firmware activation staring AEN
> > > 
> > > 2. https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?h=v6.0-rc2&id=0fa0f99fc84e41057cbdd2efbfe91c6b2f47dd9d
> > > 
> > > When submitting a new AER command to the controller, this code checks if the controller state is NVME_CTRL_LIVE. This caused the problem. When the firmware activation staring AEN was processed before, the controller state was already set to NVME_CTRL_RESETTING, which resulted in no new AER commands being sent to the controller.
> 
> I see.
> 
> I can modify this code to check in the drivers instead of the core.
> 
> Keith, pci does not risk submitting an async event on a freed admin
> queue? if not, I can add a proper check there as well...

I don't think we'd attempt to issue an admin command while the queue is down,
at least not in pci driver.

I think it should be sufficient to requeue the ctrl->async_event_work after the
activation work complete, no?

