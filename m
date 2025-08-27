Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 052E6C8303F
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Aug 2025 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zNR46Q87F/oby8FBEVXcgBeglwbKHFj9LmVU9aEC4CM=; b=OSqqLISsx5OqrDVmj7HF2StfDW
	mz9is2ubw9RH689oaZ2t/+U031OV26F/V+FOxU/byWeo2gOfukBAi2w0/QsaBg7eBgI9l41FePYFc
	MfByalpQwSXHL8n4rg/MhBz+i5bJobZhC/Xjjl/pR0j02gr8J/immV3GuW+hTUZl5jxsyHyZnTBTc
	4ksbuAavSOlPBAEi1q/Mu/vAAdnLCrCuStmNA5GhjIYYpvFtNnsux+KrkOoRG+JsQKnkc+zZoLXOu
	Q+rJr+meuUMwIyEj6vyKYFJs7mOFzG2XI9jfxx3zyqSddsx2XVJgmc1CdApLBfPzp1AFz02/hCasG
	qmuZF44g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAjN-0000000ES90-44iD;
	Wed, 27 Aug 2025 07:38:05 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urAiZ-0000000ERw0-3ruS
	for linux-nvme@lists.infradead.org;
	Wed, 27 Aug 2025 07:37:17 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2DEE268AA6; Wed, 27 Aug 2025 09:37:10 +0200 (CEST)
Date: Wed, 27 Aug 2025 09:37:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Christoph Hellwig <hch@infradead.org>,
	Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	iommu@lists.linux.dev
Subject: Re: [PATCHv3 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250827073709.GA25032@lst.de>
References: <20250821204420.2267923-1-kbusch@meta.com> <20250821204420.2267923-2-kbusch@meta.com> <aKxpSorluMXgOFEI@infradead.org> <aKxu83upEBhf5gT7@kbusch-mbp> <20250826130344.GA32739@lst.de> <aK27AhpcQOWADLO8@kbusch-mbp> <20250826135734.GA4532@lst.de> <aK42K_-gHrOQsNyv@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aK42K_-gHrOQsNyv@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250827_003716_107076_D1DC9181 
X-CRM114-Status: GOOD (  22.43  )
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

On Tue, Aug 26, 2025 at 04:33:15PM -0600, Keith Busch wrote:
> On Tue, Aug 26, 2025 at 03:57:34PM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 26, 2025 at 07:47:46AM -0600, Keith Busch wrote:
> > > Currently, the virtual boundary is always compared to bv_offset, which
> > > is a page offset. If the virtual boundary is larger than a page, then we
> > > need something like "page_to_phys(bv.bv_page) + bv.bv_offset" every
> > > place we need to check against the virt boundary.
> > 
> > bv_offset is only guaranteed to be a page offset if your use
> > bio_for_each_segment(_all) or the low-level helpers implementing
> > it and not bio_for_each_bvec(_all) where it can be much larger
> > than PAGE_SIZE.
> 
> Yes, good point. So we'd have a folio offset when it's not a single
> page, but I don't think we want to special case large folios for every
> virt boundary check. It's looking like replace bvec's "page + offset"
> with phys addrs, yeah?!

Basically everything should be using physical address.  The page + offset
is just a weird and inefficient way to represent that and we really
need to get rid of it.

