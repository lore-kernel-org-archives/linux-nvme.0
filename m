Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA35CCA476
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Oct 2025 05:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UaQ+/A0JhZpcy7i0kpM4sGs3klq9yDlb1Iejhw4AqYY=; b=u16X1RFCHqecu4qIdHETgus0wS
	YDi9EMH8JLVcTMMs8OSAY6MsIPVyqS/nmCYVlyCR7yUYYTRi7q/wPMn9/WuImaiI5FxzUpsr9vHc1
	2X8oWhnUnwhAKU+jb+v/a22diC/QNRXUqhSe2uWfpPuvMutynPPPkk+eZLXJ++HLW9tXLD3j4M+yk
	clbkxCB2g26yCX5lAwtA3Op4e1R33USFz4cYRsYhzinaNlKrUzl0H9sXIWWMiDL03ltpRTkrM3+jt
	OMm4gZaoQxAhqywJXJDfd2wn5NRib9YdfmpFDeMGPWXh7T1VLT5hLidTvW+j0o4uFwVHHLrm/dKVF
	30QpFgdg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75m0-00000007iXU-33qs;
	Fri, 10 Oct 2025 05:34:36 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v75ly-00000007iX1-0hj9
	for linux-nvme@lists.infradead.org;
	Fri, 10 Oct 2025 05:34:35 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 3B16D227AAD; Fri, 10 Oct 2025 07:34:23 +0200 (CEST)
Date: Fri, 10 Oct 2025 07:34:22 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 1/2] block: accumulate memory segment gaps per bio
Message-ID: <20251010053422.GA16037@lst.de>
References: <20251007175245.3898972-1-kbusch@meta.com> <20251007175245.3898972-2-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251007175245.3898972-2-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_223434_348781_69A5D512 
X-CRM114-Status: GOOD (  21.37  )
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

On Tue, Oct 07, 2025 at 10:52:44AM -0700, Keith Busch wrote:
> +static inline unsigned int bvec_seg_gap(struct bio_vec *bvprv,
> +					struct bio_vec *bv)
> +{
> +	return __bvec_gap(bvprv, bv->bv_offset, U32_MAX);
> +}

I find this helper (and the existing __bvec_gap* ones, but I'll send
patches to clean that up in a bit..) very confusing.  Just open coding
it in the callers like:

	 gaps |= (bvprvp->bv_offset + bvprvp->bv_len);
	 gaps |= bv.bv_offset;

makes the intent clear, and also removes the pointless masking by 
U32_MAX.

> +	/*
> +	 * A mask that contains bits set for virtual address gaps between
> +	 * physical segments. This provides information necessary for dma
> +	 * optimization opprotunities, like for testing if the segments can be
> +	 * coalesced against the device's iommu granule.
> +	 */
> +	unsigned int phys_gap;

Any reason this is not a mask like in the bio?  Having the representation
and naming match between the bio and request should make the code a bit
easier to understand.

> +
> +	/*
> +	 * The bvec gap bit indicates the lowest set bit in any address offset
> +	 * between all bi_io_vecs. This field is initialized only after
> +	 * splitting to the hardware limits. It may be used to consider DMA
> +	 * optimization when performing that mapping. The value is compared to
> +	 * a power of two mask where the result depends on any bit set within
> +	 * the mask, so saving the lowest bit is sufficient to know if any
> +	 * segment gap collides with the mask.
> +	 */

This should grow a sentence explaining that the field is only set by
bio_split_io_at, and not valid before as that's very different from the
other bio fields.

> +	u8			bi_bvec_gap_bit;

Aren't we normally calling something like this _mask, i.e., something
like:

		bi_bvec_page_gap_mask;


