Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94422C87FCF
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X5raUAq1bYsvmNpgZ1I3w8raIl3QJv0qP0GMJbQfh+w=; b=e7XbFJSFyuk8yInFUjiFWVin5p
	9n+/XSttD5k+IhkxygW15uKYwlET9iwj+A2hPfsrki6LrKv0AVVH/eRm2xiY4Fm8sd40W/H5PXhDM
	J6wdOYYe6PNmkxPnr7I///hZF71sEOcwgzBEF9vgIt8P+eWAaF7ZVlr/3hMwZPGP+nn7GEQRQSI0Y
	qCVj1AZdjmG5F4jBGNEUwaAM4sgd/TEUcRD3t9zZEBRJff7Gh+/oCTyNBZhc86EsAaJEYs50oCK75
	vkXPGLKANfL0hTu9mcGqwIexuAP71RkvQvfxaCIWVbV5QxzRjLwr1gqQB3xYnBcKZFxo+3YCuNWhB
	3cKXpqUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7SC-00000005ihz-12XT;
	Sun, 10 Aug 2025 14:55:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7SA-00000005ihK-1kem
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:55:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5BF5E227A87; Sun, 10 Aug 2025 16:55:09 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:55:09 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv2 1/2] block: accumulate segment page gaps per bio
Message-ID: <20250810145509.GA5444@lst.de>
References: <20250806145136.3573196-1-kbusch@meta.com> <20250806145136.3573196-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806145136.3573196-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_075518_599991_C892CBA5 
X-CRM114-Status: GOOD (  16.83  )
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

On Wed, Aug 06, 2025 at 07:51:35AM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec bv, struct bio_vec bp)
> +{
> +	return bv.bv_offset | ((bp.bv_offset + bp.bv_len) & (PAGE_SIZE - 1));
> +}

Can you just pass a pointer to the bio_vec even if the compiler
is probably optimizing away the function either way?

Also bp is a bit of an odd name for a bio_vec.  Note that bvprv flows
well, but it is what the caller uses, so mahybe stick to it?

>  	/* the following two fields are internal, NEVER access directly */
>  	unsigned int __data_len;	/* total data len */
> +	unsigned int __page_gaps;	/* a mask of all the segment gaps */
>  	sector_t __sector;		/* sector cursor */
>  
>  	struct bio *bio;
> @@ -1080,6 +1081,11 @@ static inline sector_t blk_rq_pos(const struct request *rq)
>  	return rq->__sector;
>  }
>  
> +static inline unsigned int blk_rq_page_gaps(const struct request *rq)
> +{
> +	return rq->__page_gaps;
> +}

I don't think we really need the __ and the access helper here.  This was
mostly done for fields where historically drivers accessed the field
directly, but it subtly changed semantics making these direct accesses
unsafe.  


