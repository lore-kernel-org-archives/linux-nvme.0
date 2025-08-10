Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F7CBC87FCF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EL9kEi69QHxpB3ksSBWGD8/IySvvNybj+2VasF4UT4M=; b=W9UA7po20lHiM9qh2RZpLoKetT
	XIVlT4GyQCeZnYhchA60MksydgY95hmKu858UPE+Wii6tOK6vaDqjOykVmH3kKgkLwlLx+N05dxmk
	Pmd+gSci/UAJYiOG8ySnHvb+gCCEI9lf1k5nvPmPrRDx1s9dMqOW/L7Je0GFdzy01EwiNMXPZFNmW
	Ao31UhjrvuIDuLu282e2b+oCgw2/UHD4u/djxfbrHaXM6nO16WCI9GbHk/1qZbJu0A6YB3PTfLLkG
	36GF1xf+cLuW+/gFfNtivPz026FGdKHBTV/sI4HGV++NRlk4ZBvPnyGZGIjU/FTKgo3Xy099D2JQX
	0+jfzwuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul74x-00000005hIj-3mp4;
	Sun, 10 Aug 2025 14:31:19 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul74v-00000005hII-1CCl
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:31:18 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F0A0968BEB; Sun, 10 Aug 2025 16:31:12 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:31:12 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk
Subject: Re: [PATCH 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250810143112.GA4860@lst.de>
References: <20250805195608.2379107-1-kbusch@meta.com> <20250806145621.GC20102@lst.de> <aJN4b6GS30eJdQLd@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJN4b6GS30eJdQLd@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_073117_466024_C062E392 
X-CRM114-Status: GOOD (  20.27  )
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

On Wed, Aug 06, 2025 at 09:44:47AM -0600, Keith Busch wrote:
> On Wed, Aug 06, 2025 at 04:56:21PM +0200, Christoph Hellwig wrote:
> > > index 0a29b20939d17..d0ed28d40fe02 100644
> > > --- a/include/linux/blk_types.h
> > > +++ b/include/linux/blk_types.h
> > > @@ -264,6 +264,8 @@ struct bio {
> > >  
> > >  	unsigned short		bi_max_vecs;	/* max bvl_vecs we can hold */
> > >  
> > > +	unsigned int		page_gaps;	/* a mask of all the vector gaps */
> > 
> > Bloating the bio for the gaps, especially as the bio is otherwise not
> > built to hardware limits at all seems like an odd tradeoff.
> 
> Maybe, but I don't have anywhere else to put this. We split the bio to
> its hardware limits at some point, which is where this field gets
> initially set.

What we do for nr_segs is to just do it on stack while splitting,
and then only record it in the request.  I think you could do the same
here, i.e. replace the nr_segs output parameter to __bio_split_to_limits
and it's helpers with a new struct bio_split_info that in the first
version just contains nr_segs, but can be extended to other easily
derived information like the page gaps.


