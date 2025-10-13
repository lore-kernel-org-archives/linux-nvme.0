Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25E25CCD183
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Oct 2025 21:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RHjksiUuYKUiJo9N5ui9apbtEOs6iXdt/dbs0hHIIMQ=; b=teQMqm71aByncojEo4t28jPuow
	AxLWMYnN0NXOpY2DrFwrkoJK4CbQwL6iVXS+20gkoGroCVJvIQ7JFj1vbP/btBqNalve2eqv+kH7g
	+1MoZCZHgIT+5KoqvrETtZ91WL6kuH/M2L5qC7yuTZ11Qf06rXbmpz+WuqGIT+81WxQOqCGIInWx7
	nbvifQVnrpEsmR60HfI9b9aIW5tgpAit7UAhMkcw9ztC3bVXCsAEyPUXScWDgYUD1dU7LaLyTF4h/
	tAnvLF33b5sPQng5Ew1Ko9jvfyofuN1QLWmf7DAFh4GU5nigbFUb9WeEEh8IOETYnTkCrJadubXFU
	ZrvQnBmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8QBB-0000000EYm0-1gIU;
	Mon, 13 Oct 2025 21:34:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v8QBA-0000000EYla-2zCo
	for linux-nvme@lists.infradead.org;
	Mon, 13 Oct 2025 21:34:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 8D4B0604AF;
	Mon, 13 Oct 2025 21:33:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1989C4CEE7;
	Mon, 13 Oct 2025 21:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760391212;
	bh=fVjAtspCNb2rqf+Y3yjxYHV27MVAQ3+/wEk9FKkdcR0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vQh7sJ5WpoOuXY6jMTLJr9zMVD9AKDpQq702xFMMD9FUym+FU1riSlFON7Pl/JCFP
	 syOzlJZi5yNkPXdqjMrtZKYvG8ZjYfsCI4QCHs51YkC5CjnpICTlEFvpU9BXPnZ4m7
	 kRo5jAKijTSEJulO2Ec3tfehzIlOdmD30cXzytu1GW4+NYLzQlv4YcA0ppiXttJ7DK
	 OW3mOG307fGWfHcTCGtkR9yylve6B0//JL2puObj4FLX/RaDUJx8tOlv/tTOgmcJvq
	 tV/j9UGPCNkePo6I0Xjc8iUyg5sx94zBYSbZO8jAQNl8CnbZqvQe/vZoaMIG77XwhQ
	 c3qbFRxgxKwOg==
Date: Mon, 13 Oct 2025 15:33:30 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk
Subject: Re: [PATCHv4 1/2] block: accumulate memory segment gaps per bio
Message-ID: <aO1wKjAeaOmFySCC@kbusch-mbp>
References: <20251007175245.3898972-1-kbusch@meta.com>
 <20251007175245.3898972-2-kbusch@meta.com>
 <20251010053422.GA16037@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251010053422.GA16037@lst.de>
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

On Fri, Oct 10, 2025 at 07:34:22AM +0200, Christoph Hellwig wrote:
> On Tue, Oct 07, 2025 at 10:52:44AM -0700, Keith Busch wrote:
> > +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> > +					struct bio_vec *bv)
> > +{
> > +	return __bvec_gap(bvprv, bv->bv_offset, U32_MAX);
> > +}
> 
> I find this helper (and the existing __bvec_gap* ones, but I'll send
> patches to clean that up in a bit..) very confusing.  Just open coding
> it in the callers like:
> 
> 	 gaps |= (bvprvp->bv_offset + bvprvp->bv_len);
> 	 gaps |= bv.bv_offset;
> 
> makes the intent clear, and also removes the pointless masking by 
> U32_MAX.

Sounds good, I'll rebase on your cleanup patch.

> > +	/*
> > +	 * A mask that contains bits set for virtual address gaps between
> > +	 * physical segments. This provides information necessary for dma
> > +	 * optimization opprotunities, like for testing if the segments can be
> > +	 * coalesced against the device's iommu granule.
> > +	 */
> > +	unsigned int phys_gap;
> 
> Any reason this is not a mask like in the bio?  Having the representation
> and naming match between the bio and request should make the code a bit
> easier to understand.

I thought it easier for the users to deal with the mask rather than a
set bit value. Not a big deal, I'll just introduce a helper to return a
mask from the value.
 
> > +
> > +	/*
> > +	 * The bvec gap bit indicates the lowest set bit in any address offset
> > +	 * between all bi_io_vecs. This field is initialized only after
> > +	 * splitting to the hardware limits. It may be used to consider DMA
> > +	 * optimization when performing that mapping. The value is compared to
> > +	 * a power of two mask where the result depends on any bit set within
> > +	 * the mask, so saving the lowest bit is sufficient to know if any
> > +	 * segment gap collides with the mask.
> > +	 */
> 
> This should grow a sentence explaining that the field is only set by
> bio_split_io_at, and not valid before as that's very different from the
> other bio fields.

I didn't mention the function by name, but the comment does say it's not
initialized until you split to limits. I'll add a pointer to
bio_split_io_at().

> > +	u8			bi_bvec_gap_bit;
> 
> Aren't we normally calling something like this _mask, i.e., something
> like:
> 
> 		bi_bvec_page_gap_mask;

A "mask" suffix in the name suggests you can AND it directly with
another value to get a useful result, but that's not how this is
encoded. You have to shift it to generate the intended mask.

