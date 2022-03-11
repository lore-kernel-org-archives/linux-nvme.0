Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 897FCC433F5
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Mar 2022 06:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GDu7i/GdH8+BsZbPTb72Mbn9ekYteslD9kIjD/Uk+/o=; b=dfPah1PVF0I2I8SG5EjZFVB00X
	fziZ2epVmlkZyMq/L7tERd/RXdeVinRT5bf3Wb1qwREbs9ET9VPt5KK2mtBh+CiTnFc0m7HyoSusi
	2+o0ufQCtbwUCEndb/L2XOOafWJUo4nwLuxLIVYGjEA4H0rNt1Nbj4EExMMjp2ed84A/rAT++vGFI
	HweY8kBzsRP1i8GhYGYJMzy3kXNSDlv9eea0704dxe9mQxFvIG1YzEsEB/6Avi777KBYtwDzoCmsd
	tpwrlBNKwnTO7XbkzgaDm6YAMdtRZKs3MGA9UBjflCpQ1w81YJi1suxLOGJr3I07p5fPjRkRkIbmO
	xb2Hpa0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSYzp-00FGDj-7W; Fri, 11 Mar 2022 06:43:29 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSYzm-00FGDJ-Ja
 for linux-nvme@lists.infradead.org; Fri, 11 Mar 2022 06:43:27 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id BC9A568AFE; Fri, 11 Mar 2022 07:43:21 +0100 (CET)
Date: Fri, 11 Mar 2022 07:43:21 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 08/17] nvme: enable passthrough with fixed-buffer
Message-ID: <20220311064321.GC17232@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152709epcas5p1f9d274a0214dc462c22c278a72d8697c@epcas5p1.samsung.com>
 <20220308152105.309618-9-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-9-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_224326_817015_61F76EEF 
X-CRM114-Status: GOOD (  18.15  )
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

> +int blk_rq_map_user_fixedb(struct request_queue *q, struct request *rq,
> +		     u64 ubuf, unsigned long len, gfp_t gfp_mask,
> +		     struct io_uring_cmd *ioucmd)

Looking at this a bit more, I don't think this is a good interface or
works at all for that matter.

> +{
> +	struct iov_iter iter;
> +	size_t iter_count, nr_segs;
> +	struct bio *bio;
> +	int ret;
> +
> +	/*
> +	 * Talk to io_uring to obtain BVEC iterator for the buffer.
> +	 * And use that iterator to form bio/request.
> +	 */
> +	ret = io_uring_cmd_import_fixed(ubuf, len, rq_data_dir(rq), &iter,
> +			ioucmd);

Instead of pulling the io-uring dependency into blk-map.c we could just
pass the iter to a helper function and have that as the block layer
abstraction if we really want one.  But:

> +	if (unlikely(ret < 0))
> +		return ret;
> +	iter_count = iov_iter_count(&iter);
> +	nr_segs = iter.nr_segs;
> +
> +	if (!iter_count || (iter_count >> 9) > queue_max_hw_sectors(q))
> +		return -EINVAL;
> +	if (nr_segs > queue_max_segments(q))
> +		return -EINVAL;
> +	/* no iovecs to alloc, as we already have a BVEC iterator */
> +	bio = bio_alloc(gfp_mask, 0);
> +	if (!bio)
> +		return -ENOMEM;
> +
> +	ret = bio_iov_iter_get_pages(bio, &iter);

I can't see how this works at all.   block drivers have a lot more
requirements than just total size and number of segments.  Very typical
is a limit on the size of each sector, and for nvme we also have the
weird virtual boundary for the PRPs.  None of that is being checked here.
You really need to use bio_add_pc_page or open code the equivalent checks
for passthrough I/O.

> +		if (likely(nvme_is_fixedb_passthru(ioucmd)))
> +			ret = blk_rq_map_user_fixedb(q, req, ubuffer, bufflen,
> +					GFP_KERNEL, ioucmd);

And I'm also really worried about only supporting fixed buffers.  Fixed
buffers are a really nice benchmarketing feature, but without supporting
arbitrary buffers this is rather useless in real life.

