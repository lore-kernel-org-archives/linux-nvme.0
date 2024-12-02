Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33EAEE69E85
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 19:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IrvHfZAnUreEPYsPLZfUB8RPvhNRMihJqcAhVpBTMIg=; b=L9MzE+DBPfjRCxptkhCZ9YxupN
	vvePb1FS3UTx3xKZ64H2seMs4VG7tjRarZEXq0VUV9B0XtYnH2Ntr9GAdKn0tZFp7sXLYtnZFMvpZ
	d1KAc/hYUEtSEsSmOcHULwFkOOtC/1KZGOo1rQ17YnVTcA8Bt14KJU8FyWqcZSoW8Ql4UUa1Iocyx
	S3wUh2Ywq3VAlfxd0XpMxcwv/CW7YxIEXnpptmNwKcgsjKC4IKnvUUzrjEysBUTuA65dQ0DAk9S7m
	aJL91EK+b7mxA48/HiHQZo6g/n5IQdBCL5I1hmzIy2mWEV+/nL3CuN2R+yuoaETd49vtlrUOeRnmk
	CyAiK9RQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBy1-00000007HVo-3trl;
	Mon, 02 Dec 2024 19:20:21 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIBxz-00000007HUs-371F
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 19:20:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 3850EA40442;
	Mon,  2 Dec 2024 19:18:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98181C4CED1;
	Mon,  2 Dec 2024 19:20:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733167217;
	bh=ytkp7VH63cHO25FRtYSM3yRhCdNyUFYNVAkkoDl+EvY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VziX1EJb1FXF7ZWaow4Tlh603jgU4fjUqjPq+YQo5wV4R/5fvc0aSecJ4rQSwEqes
	 5+HOZwVf8U6gJwcjk9MU8lOH8m8okzEck9oYYaauCam3iP76nsILc66zo3A7h9zP4w
	 vydeAyk5sLI7avFJ0a7XnztxTXwT3nxa1H/zQFQsJqnLTCcx4DRz3oD6i9ocmTlsHn
	 iGq5KIDrb4nt9EYKBPCU+F3VdwEmWPrNSViIbTZDNKpwo6MTikOw4yy9aO4wvHmIQ0
	 KqwahNSNnwkPpXrSEdXk0/BH0l/MgR5ocNfTBMyFt42jnws8rlHOfsfBPYWmk5CfA1
	 tUx6xKQgdJV7g==
Date: Mon, 2 Dec 2024 21:20:12 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH 2/2] nvme-pci: use dma_alloc_noncontigous if possible
Message-ID: <20241202192012.GI1245331@unreal>
References: <20241101044016.405265-1-hch@lst.de>
 <20241101044016.405265-3-hch@lst.de>
 <20241202190541.GA2434798@unreal>
 <Z04HZZVLJN8NBiW7@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z04HZZVLJN8NBiW7@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_112019_853211_A37D6D94 
X-CRM114-Status: GOOD (  18.83  )
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

On Mon, Dec 02, 2024 at 12:15:49PM -0700, Keith Busch wrote:
> On Mon, Dec 02, 2024 at 09:05:41PM +0200, Leon Romanovsky wrote:
> > I see at least two possible solutions, add GFP_NOWARN in nvme_alloc_host_mem_single()
> > or the following patch:
> > 
> > diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> > index 4c644bb7f069..baed4059d8a5 100644
> > --- a/drivers/nvme/host/pci.c
> > +++ b/drivers/nvme/host/pci.c
> > @@ -2172,7 +2172,8 @@ static int nvme_alloc_host_mem_multi(struct nvme_dev *dev, u64 preferred,
> > 
> >  static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
> >  {
> > -       u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
> > +       u64 max_chunk = PAGE_SIZE * MAX_ORDER_NR_PAGES;
> > +       u64 min_chunk = min_t(u64, preferred, max_chunk);
> >         u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
> >         u64 chunk_size;
> > 
> > @@ -2180,7 +2181,7 @@ static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
> >          * If there is an IOMMU that can merge pages, try a virtually
> >          * non-contiguous allocation for a single segment first.
> >          */
> > -       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev))) {
> > +       if (!(PAGE_SIZE & dma_get_merge_boundary(dev->dev)) && preferred < max_chunk) {
> >                 if (!nvme_alloc_host_mem_single(dev, preferred))
> >                         return 0;
> >         }
> > (END)
> > 
> > What is the preferred way to overcome the warning?
> 
> I think your max_chunk check suggestion looks pretty good.

Awesome, will send proper patch tomorrow.

Thanks

