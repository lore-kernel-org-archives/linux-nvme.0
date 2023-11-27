Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 534ECC4167B
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Nov 2023 16:46:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OvZDL5BIO1kvnB26AxlPvgi8sEUk3W+i2ZOWsJVaOjQ=; b=Ukglx9tFJC4QyVhLS5XQJu5NmG
	eiW5NmTxhIvyX6PpT0tryk1LJ0WnldRQiPbgvratDUmfjJrjOZjXLUkWHOb3FrBiQobWdo3ptX/40
	UGNa+P0qA6ardL4nfZ/hRGd9OLeMjBKucL+mklnZO26qD8tZQ+sBbrqeweUlVlSBTPoEAjDwJ09Pb
	VcOvPdwrESf/aLisS7tAmN57LCTzIyUPk1w6ql9Kuyk0X7js9tw4PjWFQsWd9SiC2bjaBctbebTg3
	wowhw2leKj51NcBG2R30vTobMgTaGpccUwITyUg2pXXhHQPDXePznv3IWHVqzFxByCtx4lyzhoJn5
	KXWTmRAQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r7el2-0032dm-1M;
	Mon, 27 Nov 2023 16:46:52 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r7ekz-0032cA-1x
	for linux-nvme@lists.infradead.org;
	Mon, 27 Nov 2023 16:46:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7560961353;
	Mon, 27 Nov 2023 16:46:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E395C433C9;
	Mon, 27 Nov 2023 16:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701103605;
	bh=n0YJy9MtG9wS5bcesamH5c9LR2unSin2xWzNq/0Yo4U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BEMiwoqnqPHfKIey/prxi1QaKY8T63v3GV4yMmaOKw6+Ow9Fp5n4NcB89LKyYsZiO
	 RS7uZjnGEngBxUWC9Lknj0vzG6clJFRSuiMj5R73QjJpDUqboTUCZtTjTORPDveakD
	 YIP7Jy7HjqCjysVz80BBbrg74/JnBEJMMV/KjAeFyX3BbT3NClyXtZh0iaDeo0QUFs
	 mJcuVnVvXgzY+EAx05oT9hppzbF/yD+igPNvt/eGYP9bxjRDnUboB6aR4YE3IgVSEJ
	 DAZlYzPHtxizr5CwGr01yCY3hPMJeoH8AQGGmx3AmKkmidck9gMV7CvzMh0jCrm3H7
	 0p2jueQpkajxQ==
Date: Mon, 27 Nov 2023 09:46:43 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127163333.GA2273@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231127_084649_686386_67C6CC91 
X-CRM114-Status: GOOD (  18.88  )
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

On Mon, Nov 27, 2023 at 05:33:33PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 09:30:14AM -0700, Keith Busch wrote:
> > > > Should this even be an nvme specific attribute? I thought we should have
> > > > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > > > work as long as we're not dealing with extended metadata at least, but
> > > > that's kind of a special format that doesn't have block layer support.
> > > 
> > > Reporting the tuple size is a good idea.  But is that enough for
> > > the existing nvme-cli use case?
> > 
> > nvme-cli currently queries with admin passthrough identify command, so
> > adding a new attribute won't break that. I assume Daniel would have it
> > fallback to that same command for backward compatibilty if a desired
> > sysfs attribute doesn't exist.
> 
> Yes.  But does it care about the tuple size, or the actual size of the
> metadata field even if is bigger than the PI tuple?

tuple_size is the same value as metadata size regardless of PI usage.
See nvme_init_integrity() for how this driver sets it:

	integrity.tuple_size = ns->ms;

