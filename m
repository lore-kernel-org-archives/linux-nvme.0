Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFFACD4A5F4
	for <linux-nvme@archiver.kernel.org>; Sun, 18 Jan 2026 08:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7fhx1Lr9w/DVxq6MJH40ZTieKkabYUuFq9EMvNqyayc=; b=Ftq8CS3cqrU7Qj5Nc5k8O7xdpt
	oCpbzOyZIpo6AzO+KwwFKJSM9COmoCgSfXWqWZ3brs0IUKMX58FuKn9K88mqciVzwy5NySHQRii0K
	vOeDiTOQvCevJbfon/Kk8lDn9ZONM2tm7xII59aB7cMSlsfrjyTnpkuvB2vzVx+p29uJiRWkDUpoZ
	da3H/2Gn2X7MeCMJ84iqHk5Ew9Oi5uc6n1C4flPrRsKwMiHZ+odMC3nUg3jxcgOFbaY3eD5VRAw/C
	aLB92CfNu3OH2tC7pT7uL6HyPn/uESCr6jD5IGWLNjPwTHa9PjKq86VLN32PGfABWDDI0rUK3HcX0
	755hxSSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhNil-0000000H3nb-36gc;
	Sun, 18 Jan 2026 08:01:15 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vhNik-0000000H3nS-3UIn
	for linux-nvme@lists.infradead.org;
	Sun, 18 Jan 2026 08:01:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D90286000A;
	Sun, 18 Jan 2026 08:01:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114C2C116D0;
	Sun, 18 Jan 2026 08:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768723273;
	bh=ZHXGQGtNa4CtQM5yect8NajKgpW75mjioCPaStMkJEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NYK6FFFMDRn4t8ckgA5LnPZ+9penG4NJrDXajUHue1DxxD7WPIKULGEgyvvcF9axd
	 VMU9xo99te4g112iR6psrqipjQBdLlN285XfeABKgfNPnt1GZdPFc5/HboUmor0y8Q
	 bZst6HVHYufbBu84zijREYz/E7qDzkh0bsauKi4l14NX4zO7q3hidE+CrYkBkBxfPi
	 PGHtVjXXj1A/VkgKbIyjXYfwRlmrdmh6/tMBqevYGtkCiwtw1ScalfFY+K80ecPajp
	 cJb6VAvRkaTvwd1gZA0O/ByI1FArR8Mvk5rak8iz9VUnQF86dDnbOSnT0bB13FOsjs
	 CsT09M/zvIPpg==
Date: Sun, 18 Jan 2026 10:01:09 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Alex Williamson <alex@shazbot.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v3 0/2] block: Generalize physical entry definition
Message-ID: <20260118080109.GA14182@unreal>
References: <20251217-nvme-phys-types-v3-0-f27fd1608f48@nvidia.com>
 <176775184639.14145.18318539882421290236.b4-ty@kernel.dk>
 <20260114133241.5b876b40@shazbot.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114133241.5b876b40@shazbot.org>
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

On Wed, Jan 14, 2026 at 01:32:41PM -0700, Alex Williamson wrote:
> On Tue, 06 Jan 2026 19:10:46 -0700
> Jens Axboe <axboe@kernel.dk> wrote:
> 
> > On Wed, 17 Dec 2025 11:41:22 +0200, Leon Romanovsky wrote:
> > > Jens,
> > > 
> > > I would like to ask you to put these patches on some shared branch based
> > > on v6.19-rcX tag, so I will be able to reuse this general type in VFIO
> > > and DMABUF code.
> > > 
> > > --------------------------------------------------------------------------------
> > > Changelog:
> > > v3:
> > >  * Rebased on top v6.19-rc1
> > >  * Added note that memory size is not changed despite change in the
> > >    variable type.
> > > v2: https://lore.kernel.org/linux-nvme/20251117-nvme-phys-types-v2-0-c75a60a2c468@nvidia.com/
> > >  * Added Chaitanya's Reviewed-by tags.
> > >  * Removed explicit casting from size_t to unsigned int.
> > > v1: https://patch.msgid.link/20251115-nvme-phys-types-v1-0-c0f2e5e9163d@kernel.org
> > > 
> > > [...]  
> > 
> > Applied, thanks!
> > 
> > [1/2] nvme-pci: Use size_t for length fields to handle larger sizes
> >       commit: 073b9bf9af463d32555c5ebaf7e28c3a44c715d0
> > [2/2] types: move phys_vec definition to common header
> >       commit: fcf463b92a08686d1aeb1e66674a72eb7a8bfb9b
> 
> Hi Jens,
> 
> I see this is currently on your for-7.0/blk-pvec branch, thanks for
> splitting it out.  I haven't seen this merged into your for-next branch
> though, which gives me some pause merging it for a dependent series
> from Leon.  Is there anything blocking that merge?  Thanks,

Jens,

Could you please merge the for-7.0/blk-pvec branch into your block/for-next
tree? The VFIO changes depend on the blk-pvec branch, and the RDMA changes
are based on the VFIO updates.

Thanks

> 
> Alex

