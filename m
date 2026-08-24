Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE459C5DF81
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Aug 2026 14:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T71NLirH3jm6znHdMrOBeJ29wllbXsTfJ6mU2Kw+zNw=; b=EGLFqNZboEDtwojMNClMmeRvh8
	EJ5f9rHAyNosFIw9pke9Vz497OSLHB7bxjqTQmbRLfcyvfZs/Uw1LcYRQ1SpsPACPqurTtlXYtp3A
	3HjS2SPkq7jrBijhZ6GTLS+Qpvy9NacPuuk6OeFzxhV/PmR6OE4tZT/LrMopxoaKwC6myHLxMnPC5
	BANpVAVLB+oe6stJoEGNr+6cHfw5OLYLXQUkMlrmsL32sklpG+1fKitkLZLG2q15S/P8nIshRiFH6
	iAA0xErwzIALI5+2D3u9Dj94g/D6VJuhNypVgVTn8IXjqZ0ztnEs6SA/JwxWZMlzQ3pZOQb4XQlff
	mIJ9UrHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVak-0000000GlnO-2Mu5;
	Mon, 24 Aug 2026 14:24:02 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVaj-0000000Gln0-24lf
	for linux-nvme@bombadil.infradead.org;
	Mon, 24 Aug 2026 14:24:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T71NLirH3jm6znHdMrOBeJ29wllbXsTfJ6mU2Kw+zNw=; b=rFI8iiVTimTRlQNvitqLvVDsRl
	F2rjwcCSzmLvzKvoutMkxwvqtUCKc1pYazQ5YpWWz7CL+Q2BzWLiyKU0HrjZGyAaU/rVDZfhhz2Px
	XLVTAAzjun5QRcugTD1L9MRRBo0Fa6VSZDLFcqxP6ypZAglGWKzE86HtqX9gd7dDY13+gNecRUuzc
	RlWSnBl3OxSXKTszNim/eeJtwbzyDTP8yyD4SLhlq6ai9mh3cmozZHAb6KlCjcNJ62eNhYBPSJWBR
	+4+vsPyx6UwXDOWzSUhj31ZRz0fqbmVjOkDqC4/WJqwndRA84/vYY+5I0yJ6wiNyVLk1t+DZD+iAN
	+9J4hZBg==;
Received: from sagi by casper.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wyVah-00000007LQY-0Y4r;
	Mon, 24 Aug 2026 14:23:59 +0000
Date: Mon, 24 Aug 2026 15:23:59 +0100
From: Sagi Grimberg <sagi@grimberg.me>
To: Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Daniel Wagner <dwagner@suse.de>,
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [PATCH 4/6] nvme-mpath: support controller crd when failing over
 request
Message-ID: <aoxT_wwbT93Cv5F5@casper.infradead.org>
References: <20260823084903.193188-1-sagi@grimberg.me>
 <20260823084903.193188-5-sagi@grimberg.me>
 <c3ca9481-8eaa-496b-bdde-38cd911d8f96@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3ca9481-8eaa-496b-bdde-38cd911d8f96@suse.de>
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


> > +	/* no CRD or timer allocation failed, fallback to immediate failover */
> > +	if (!fot) {
> > +		spin_lock_irqsave(&ns->head->requeue_lock, flags);
> > +		blk_steal_bios(&ns->head->requeue_list, req);
> > +		spin_unlock_irqrestore(&ns->head->requeue_lock, flags);
> > +		kblockd_schedule_work(&ns->head->requeue_work);
> > +	}
> 
> Yikes. Allocation during failover is not going to make you friends.

Well, it is a fairly rare event, and the fallback is exactly what we
do today...

> 
> And this whole mechanism looks pretty similar what we did over at
> implementing CCR. Can you use the mechanism from there?

How is this similar? It is effectively creating a container for
bio_list and timer to requeue them when the timer expires...
 

