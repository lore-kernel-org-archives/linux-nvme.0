Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADEDDC54E58
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Mar 2024 21:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wUk9RfMti3L/WIICw770V2ffnpyPjp3cglUL9hfQfeA=; b=yntT/JyyUe9i5LF1xqdLW70Wbt
	hLRbJarAxbR1atBpqMLr0K64mF893dnHgFIiyCEOA8ftDSuphGRJFWcqByEheCv56Cy9YSqIPzGsO
	e67s69iiJp1G6W3f4JD0tj4xaME+8zKpRMJxd21oXIwvMegm8fqIG+tS23GnsQ3B8twkotChK+frf
	OppkcEc9eqJ/lzxom7tVbaELgiS8ThuQskH2qx/Rfn1A0d0qIuCEVFdn/+TT0oTWcBQ4WKp/Cc2aC
	13PR1DdYx0Xw8f0znG1SzDLSj0IFIswEo5xIfuxraDcC40ZV4o/tZU8wdrDbg3LmQdssz3CEH/8eO
	33VVV1mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9KB-00000007Xjy-3ubv;
	Tue, 12 Mar 2024 21:06:15 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rk9K9-00000007XjJ-0PFf
	for linux-nvme@lists.infradead.org;
	Tue, 12 Mar 2024 21:06:14 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9551768BFE; Tue, 12 Mar 2024 22:06:05 +0100 (CET)
Date: Tue, 12 Mar 2024 22:06:05 +0100
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Chandan Babu R <chandanbabu@kernel.org>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/5] block: add a bio_chain_and_submit helper
Message-ID: <20240312210605.GA1500@lst.de>
References: <20240312144532.1044427-1-hch@lst.de> <20240312144532.1044427-3-hch@lst.de> <ZfBr91m4oQS_VYFg@kbusch-mbp.mynextlight.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZfBr91m4oQS_VYFg@kbusch-mbp.mynextlight.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240312_140613_301042_6AD7BD23 
X-CRM114-Status: GOOD (  16.00  )
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

On Tue, Mar 12, 2024 at 08:51:35AM -0600, Keith Busch wrote:
> > +
> > +struct bio *blk_next_bio(struct bio *bio, struct block_device *bdev,
> > +		unsigned int nr_pages, blk_opf_t opf, gfp_t gfp)
> > +{
> > +	return bio_chain_and_submit(bio, bio_alloc(bdev, nr_pages, opf, gfp));
> > +}
> 
> I realize you're not changing any behavior here, but I want to ask, is
> bio_alloc() always guaranteed to return a valid bio? It sure looks like
> it can return NULL under some uncommon conditions, but I can't find
> anyone checking the result. So I guess it's safe?

bio_alloc can only fail if we don't wait for allocations, that is if
__GFP_DIRECT_RECLAIM isn't set.

We could an assert here.  Or work on killing the gfp_flags argument
and just add a bio_alloc_nowait for the few cases that need it.

