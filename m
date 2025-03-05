Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52C72C19F32
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Mar 2025 23:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/5YN040gs3EG0en6fHi47dTm+UikR8TnkdUyJNfrloA=; b=Iedo87Ev9DqDIqbAiYVxhf+JpS
	zl93er8vTdg5LPeELLHnB9KTxoBX85O3/HdmMDg/CPsAVOxwD9Tnz+3Kmh63s1WpHS02TK4zwtfcO
	/74c/1lpkdVV+6R6W3k15Dck1Z8A36TigB8AHcl3f9d5mMl2IW/6pJ0HLMtaef9X/Rd5tyL89frau
	1LbQyolyNF5/m172GaVM/z8u09JBnky+AEuU/Eh6rloC/rwkZga2IKZSfmqnDgRTtVH/0Rhv6JZEt
	srqyVym2WBbYqRb4kr5m5jdDvgLkBudzmhvFMGyTBY1IBhl18NKsnxdIbZ73ps1aTzFtQnnH24wxw
	ohOuG9+w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tpycZ-00000009egE-2B1b;
	Wed, 05 Mar 2025 23:57:51 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tpycX-00000009efm-17ei
	for linux-nvme@lists.infradead.org;
	Wed, 05 Mar 2025 23:57:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id B2E3AA467A1;
	Wed,  5 Mar 2025 23:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 568FFC4CEE0;
	Wed,  5 Mar 2025 23:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741219068;
	bh=sjr6OGckziQ9YjoNnbDRgjPZEbhWstKtXIcNkou+a8A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TkfXpqyFDo5zQ9MZZ5agzkXVt7qI+0luk5+RfNUOj7cYm0Tyb3jnfo6gMD0Ut9eve
	 ErclBYH7EOOELDoWJU0y7CoCtWIWoIta9RbmEBX6ZI1fQPzhwGcHeiazzjAu6AsBWw
	 b5/pxh32zLr+0bJwvrrWDwtAFyZxjUdMkTOIr6awWiHiCgr+gKuMFTaAOOS/JiZJRS
	 e7htLB10fGt1tLIFDyDQDbN+nIwMRVOV3YuYwHB4cs52aP0tLwsllPxxTIcq1xEwnp
	 NJLejuBwEelzbGH3FpGxMNjQ8Yu58WTEdkXSsVuuY/4mcYz75kYA893hIvaW1mVvXr
	 J+alAQyfCea2A==
Date: Wed, 5 Mar 2025 16:57:44 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>, Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	John Meneghini <jmeneghi@redhat.com>, bmarzins@redhat.com,
	Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Marco Patalano <mpatalan@redhat.com>,
	axboe@kernel.dk
Subject: Re: [PATCH] nvme: remove multipath module parameter
Message-ID: <Z8jk-D3EjEdyBIU5@kbusch-mbp>
References: <Z7Sh-3yHbXVmRbNL@kbusch-mbp>
 <8a1730a1-1faf-4722-99e1-c3a85257b6f4@redhat.com>
 <Z7TARX-tFY3mnuU7@kbusch-mbp>
 <2ff87386-c6db-4f2e-be91-213504d99a78@linux.ibm.com>
 <0656b66c-dd9c-495d-b1fc-4f09e763fa66@grimberg.me>
 <Z7dct_AbaSO7uZ2h@kbusch-mbp>
 <91ae613a-7b56-4ca0-b91c-6bc1eee798b8@suse.de>
 <20250305141554.GA18065@lst.de>
 <Z8hrJ5JVqi7TgFCn@kbusch-mbp>
 <20250305235119.GB896@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250305235119.GB896@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_155749_369420_36C526B1 
X-CRM114-Status: GOOD (  21.71  )
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

On Thu, Mar 06, 2025 at 12:51:19AM +0100, Christoph Hellwig wrote:
> On Wed, Mar 05, 2025 at 08:17:59AM -0700, Keith Busch wrote:
> > > > Plus there are some NVMe devices out there which _despite_ being PCIe do 
> > > > report NMIC and CMIC set (I won't name names, if you came across them 
> > > > you'll know)
> > > 
> > > ?????
> > > 
> > > NMIC and CMIC is perfectly normal and expected for multiported PCIe.
> > > WTF are you talking about?
> > 
> > Obviously he's not talking about multiported PCIe.
> 
> Why is that obvious?  

No one here would think a multiported device *wouldn't* report CMIC. The
fact Hannes thinks that's a questionable feature for his device gives
away that it is single ported.

> At least based on the stated works he talks about
> PCIe and not about multi-port.  The only not multiported devices I've
> seen that report NMIC and CMIC are a specific firmware so that the
> customer would get multipath behavior, which is a great workaround for
> instable heavily switched fabrics.  Note that multiported isn't always
> obvious as there are quite a few hacks using lane splitting around that
> a normal host can't really see.

In my experience, it's left enabled because of SRIOV, which many of
these devices end up shipping without supporting in PCI space anyway.

> > And he's right, the
> > behavior of a PCIe hot plug is very different and often undesirable when
> > it's under native multipath.
> 
> If you do actual hotplug and expect the device to go away it's indeed
> not desirable.  If you want the same device to come back after switched
> fabric issues it is so desirable that people hack to devices to get it.
> People talked about adding a queue_if_no_path-like parameter to control
> keeping the multipath node alive a lot, but no one has ever invested
> work into actually implementing it.

Not quite the same thing, but kind of related: I proposed this device
missing debounce thing about a year ago:

https://lore.kernel.org/linux-nvme/Y+1aKcQgbskA2tra@kbusch-mbp.dhcp.thefacebook.com/

