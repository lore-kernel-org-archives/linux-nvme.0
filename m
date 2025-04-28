Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95723C369DC
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Apr 2025 15:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cuAXcpbNwTgS2iDlnDZv3PoErAWbPS8J39IupsxBu+g=; b=u0K440V2Rmozw4MZoGDfJ+Ylue
	bes8UbYzIV2ZCc3meOjSikFxTjTEiBsZTceJV36TZ2yMFPcLBYbfHEXue6rKg9XGwdCfI0V5st+U8
	xJMBy92QAfVQdsR9dScD6m30NZZWzvhr1nEIHGpitwsi5G0Q3upa2dH7eVp1teLLSdFhHD+r50wXf
	cT2RHO0qImivNeEO+/uKtm9d0EkHzhz7htjNl5mu0xj1+nEuB3usNxLYSEbCal+q41OlYtxVv+Khr
	gozKTxa9AxmrskW6OjnxexhAV5rU7xnyMTWnGuajBd7owrNQOF087HjnFxGPoA7zrLvHVNhcER4ev
	npUCZO8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9Q0g-00000006i2t-1s5R;
	Mon, 28 Apr 2025 15:03:06 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u9PzD-00000006htG-0VLz
	for linux-nvme@lists.infradead.org;
	Mon, 28 Apr 2025 15:01:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 6547A61160;
	Mon, 28 Apr 2025 15:01:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD34C4CEE4;
	Mon, 28 Apr 2025 15:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745852494;
	bh=L6ftK1YtwSLWu98J7GlkvJulgQ+u3Pn+RMrpNruh2uE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKomr+ICxOawI2rdS0SCrvtRMfjWOcjyj8hcN9Uofmfmil44KIDpcxgbY8A2d+7L6
	 rRe/4m3GpyptKvl8EXKhKcuHo2ixiN6BruOJ4eII5btvDX05tka4qMe7SOiJgJhabY
	 JBg4ACLLwa84UreJSXs98zBiqUo6CoNGYq+pMdJ0hmmpXq3B/a0WU21ZHvvzMH4Nmz
	 RfRnyNK3uM892O8OIenalsk9zLHcpv4B/7UdBOGT5UoYLT8qWvhWkTsJ9rJwwvkXYh
	 PmyQRnOt1o16VtOr/Nx0GqRwXCsn3Fru7pXFiCnaOnxnWfkcRnnan4zXdebn4KJD+d
	 mMPrCSOViY5MA==
Date: Mon, 28 Apr 2025 09:01:31 -0600
From: Keith Busch <kbusch@kernel.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kanchan Joshi <joshi.k@samsung.com>, linux-nvme@lists.infradead.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/3] dmapool: add NUMA affinity support
Message-ID: <aA-YS8Bv0kO75jdk@kbusch-mbp.dhcp.thefacebook.com>
References: <20250426020636.34355-1-csander@purestorage.com>
 <20250426020636.34355-2-csander@purestorage.com>
 <cb443e86-2639-4ed5-8d9c-00aa5e200f7e@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb443e86-2639-4ed5-8d9c-00aa5e200f7e@oracle.com>
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

On Mon, Apr 28, 2025 at 11:35:12AM +0100, John Garry wrote:
> >   static struct dma_page *pool_alloc_page(struct dma_pool *pool, gfp_t mem_flags)
> >   {
> >   	struct dma_page *page;
> > -	page = kmalloc(sizeof(*page), mem_flags);
> > +	page = kmalloc_node(sizeof(*page), mem_flags, pool->node);
> >   	if (!page)
> >   		return NULL;
> 
> For pool->node != NUMA_NO_NODE, pool->node == numa_node_id(), right? I
> mean, aren't we on a CPU in pool->node here?

Not necessarily. blk-mq hctx's could span numa nodes. We just want to
register the dma pool with whichever one is the first node.

