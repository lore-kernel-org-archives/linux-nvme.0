Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A466CA1005
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 21:42:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0zobGHCkDHcO/SufZMHuueh6nY5uo5Firfk3YMUDHqQ=; b=gSGsNyJ6n1HuxeQ4fm/McDEPB+
	GQAq6qpEDrTcwLLsIxc5KLPhQPTttBflwcLGuvObwOhR00hAXtWvCjvDSPufwNbzIqUWqe0FshquG
	nW5iYH1agmS2sVZTaGxCDyvRLu9NCExxB+YuSQEHQhFTmByWlnHHbEJgMaWjaSs4rTWzXCe6Lbyx+
	lqgT4Pt25jrj4p91N+18QXqAY03NxPpRgkMnduLRuBxIEOVxG1Ht6MoVckBFZ+0ToUkZHAfG/RPv5
	YUnmqaJD8oyBh52MyqNlyaT6YCWl0F4m/z7zVaw+aK/aLZQ9+rXM/IRLhYaWwImmiEC++UKaMVKyU
	Lw/I3PCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utYmB-00000002AjD-2SPR;
	Tue, 02 Sep 2025 21:42:51 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utS7y-00000000Ops-1bO9
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 14:36:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C5C1043D98;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AA73C4CEED;
	Tue,  2 Sep 2025 14:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756823813;
	bh=cn3LtgfpnA+smc7XsesC+rM3Kfu7yDWpL5KCuGBwqK8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AYGKWjYIcXbhb5YFAXoVsPdyDXuWE3zebzF/XOqN5TGe7KuzAHam4xHRrBqYgHc/c
	 3mFkseja3ogqbQe9zi5lFWtVaRcZArMHbHFLTwU/QMLXYlpFF20++yY3pjYdRiNnSE
	 nKlAqIICTfFDVZ2JfkR++DGoFOMbIGlCsrBC+1wKDOfv84i7KYxM0xqCqovLlL1vjg
	 533sVizehfOpq/hNf7Fw+BDd3O9BqOaChhQ0V1gnaScKtdt4RUBmzEOgzh2YXjDYWW
	 cRrbJchP/EoIELP+VV3GM0BuuX0M+iJvIEXQtf0Z5V4hCaYPTUuOaswdZsZrS5fB09
	 4J199KGIgVMlA==
Date: Tue, 2 Sep 2025 08:36:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com, leon@kernel.org
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
 <20250902053358.GB11204@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902053358.GB11204@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_073654_437160_AA725C03 
X-CRM114-Status: GOOD (  21.11  )
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

On Tue, Sep 02, 2025 at 07:33:58AM +0200, Christoph Hellwig wrote:
> On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > We only need to consider data and metadata dma mapping types separately.
> > The request and bio integrity payload have enough flag bits to
> > internally track the mapping type for each. Add flags for these so the
> > caller doesn't need to track them, and provide separete request and
> > integrity helpers to the common code for unmpaping. This will make it
> > easier to scale as new mappings are added without burdening the caller
> > to track such things.
> 
> We are actually about to run out of REQ_* bits with the current
> encoding.  We could shrink the space for REQ_OP_ a bit to create
> more, or try to move some flags out into BIO_ flags (like
> REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> (REQ_INTEGRITY), or by overlaying flags that can't be used with
> the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> And maybe we can come up with a more coherent scheme for
> REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> another priority scheme in addition to the I/O priorities.
 
Sure, but can we do that effort separately from this? I'm mainly trying
to align with Leon's DMA series that adds REQ_MMIO so that we won't have
flag conflicts.

