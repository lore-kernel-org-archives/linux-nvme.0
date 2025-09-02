Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB641CA1007
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Sep 2025 19:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xoDZG0WteDyCYWhvlliF32jnY10AkdbBua6tNrV2RbA=; b=dJiWLGrd9nnH40u9dMwlXJwuYO
	f3ui3nepmT7ok4AnmP8EZPZGISYhm8+YvoAhzxt6GrEXzq4FiKNzw5XHHqXTwPXhOEbDzyuROvqqj
	jJGOVPJMWghK8KOhgw1g25e2kcngq57WHck8LQd8VjsozVQMoj2+ReUiArfuCEaKlZBRXfilAKxYZ
	6u0hPuHRk56acctUz00vu/InrmK8C1sd75pbidmJwAE/AhZO3GpIzrWGlw9iVq2MukdIAisQq9Ltj
	Q83WGlbPVQr+ReRi0GIZ1PdcCe1OZYRpiwyUS3egNTnvt6N5hIygqMuVzsZBEWTuzHzhxasr77BzW
	PQCEmITg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utWQy-00000001eB0-3VlY;
	Tue, 02 Sep 2025 19:12:48 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utSS9-00000000Wuz-0esn
	for linux-nvme@lists.infradead.org;
	Tue, 02 Sep 2025 14:57:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id D5A7440BA2;
	Tue,  2 Sep 2025 14:57:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D35C4CEED;
	Tue,  2 Sep 2025 14:57:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756825064;
	bh=ffW3f6G8GTh9+GY4dZadiSebboE7pBfqZFq/9rOMOMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PYg399Zhxgi3s4CNzOtESV3U4to38XhkK0QmKm+uTDp/cTg0pZIvtYflE/3fM/0sX
	 TUciH2e4vgBVJe0b1YJPJ9+UdtP8+0J+5lhpYVjE1nUIVtAyyN055krDsB2B+gJgqF
	 7S/wjaH0diJbxy2AcZ6zzhQ6it2yWgEMUw0E4aUH5uzqdPOY6pie7cJpKhilmjSxlS
	 koioY5JoYYfpyOUo3SHHZuXzxj67SMSGLQwf5KrRQbtfSv5z6/+bZIofP9QV2Ht7Ps
	 OJ1GJ8sVEQIu0tobCwYaWvvNW0tEAMhygnM+eyFBEz2vmix/gGbxZZNV59LCUgTMwY
	 GsrBkQsA8o/ig==
Date: Tue, 2 Sep 2025 17:57:40 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	martin.petersen@oracle.com, jgg@nvidia.com
Subject: Re: [PATCH 2/2] blk-mq-dma: bring back p2p request flags
Message-ID: <20250902145740.GJ10073@unreal>
References: <20250829142307.3769873-1-kbusch@meta.com>
 <20250829142307.3769873-3-kbusch@meta.com>
 <20250902053358.GB11204@lst.de>
 <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aLcBA-Z8yZ44t4ZK@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250902_075745_215611_420C83F7 
X-CRM114-Status: GOOD (  24.46  )
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

On Tue, Sep 02, 2025 at 08:36:51AM -0600, Keith Busch wrote:
> On Tue, Sep 02, 2025 at 07:33:58AM +0200, Christoph Hellwig wrote:
> > On Fri, Aug 29, 2025 at 07:23:07AM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > We only need to consider data and metadata dma mapping types separately.
> > > The request and bio integrity payload have enough flag bits to
> > > internally track the mapping type for each. Add flags for these so the
> > > caller doesn't need to track them, and provide separete request and
> > > integrity helpers to the common code for unmpaping. This will make it
> > > easier to scale as new mappings are added without burdening the caller
> > > to track such things.
> > 
> > We are actually about to run out of REQ_* bits with the current
> > encoding.  We could shrink the space for REQ_OP_ a bit to create
> > more, or try to move some flags out into BIO_ flags (like
> > REQ_ALLOC_CACHE) or kill them by looking at pointers instead
> > (REQ_INTEGRITY), or by overlaying flags that can't be used with
> > the same of (REQ_FUA vs REQ_RAHEAD vs REQ_UNMAP for example).
> > And maybe we can come up with a more coherent scheme for
> > REQ_PRIO / REQ_BACKGROUND / REQ_SWAP and maybe REQ_IDLE that create
> > another priority scheme in addition to the I/O priorities.
>  
> Sure, but can we do that effort separately from this? I'm mainly trying
> to align with Leon's DMA series that adds REQ_MMIO so that we won't have
> flag conflicts.

Christoph,

In addition, let's make sure that functionality is correct and working right.

REQ_* cleanup can be perfect followup series for someone who understands
semantics around these bits.

Thanks

