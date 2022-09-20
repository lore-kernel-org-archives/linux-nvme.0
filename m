Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA227C6FA8B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Sep 2022 12:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C6zlaLEC6PHlRcCcURDbf5bqoJ8VBsBWsEhvVn2+uH4=; b=PrTwKfOKId2dlSJ58AZEMJsg7p
	dVB5TJWtXUYCgNGgtzu5gAlel0O8WeT9lpVxjm+tJ6K+n7uqMZNfzTVvBJ9I/X6CwlO6c9uPhZxHz
	A383qmf40btOyYnEeNdp0dEJzklJwKs0J7x6QjjYR7dTbMm0cZfCyFwBB0H4qixpJZ+hGfFyOv/CW
	dJ5exuKyY25OnfLOXcbU1UIl4A9sJTCgBlcsXfjtH3PlNXo07MI+SQIr3oh7Pk+sGCF0Syy0I5/zX
	+/RL7vq3N2tVaPW15sjzfP2LX/n6db3B0FGF09meqSsWcpEEmW63kDaozfaTIws/oM/k+VatgC/VC
	aQUwa9ig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oac2t-003aO5-2a; Tue, 20 Sep 2022 12:08:11 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oac2o-003aMs-MC
	for linux-nvme@lists.infradead.org; Tue, 20 Sep 2022 12:08:10 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 03DBD68AA6; Tue, 20 Sep 2022 14:08:02 +0200 (CEST)
Date: Tue, 20 Sep 2022 14:08:02 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
	io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, gost.dev@samsung.com,
	Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v7 4/5] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220920120802.GC2809@lst.de>
References: <20220909102136.3020-1-joshi.k@samsung.com> <CGME20220909103147epcas5p2a83ec151333bcb1d2abb8c7536789bfd@epcas5p2.samsung.com> <20220909102136.3020-5-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909102136.3020-5-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220920_050806_923726_69613931 
X-CRM114-Status: GOOD (  19.92  )
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

> -static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
> +static struct bio *bio_map_get(struct request *rq, unsigned int nr_vecs,
>  		gfp_t gfp_mask)

bio_map_get is a very confusing name.  And I also still think this is
the wrong way to go.  If plain slab allocations don't use proper
per-cpu caches we have a MM problem and need to talk to the slab
maintainers and not use the overkill bio_set here.

> +/* Prepare bio for passthrough IO given an existing bvec iter */
> +int blk_rq_map_user_bvec(struct request *rq, struct iov_iter *iter)

I'm a little confused about the interface we're trying to present from
the block layer to the driver here.

blk_rq_map_user_iov really should be able to detect that it is called
on a bvec iter and just do the right thing rather than needing different
helpers.

> +		/*
> +		 * If the queue doesn't support SG gaps and adding this
> +		 * offset would create a gap, disallow it.
> +		 */
> +		if (bvprvp && bvec_gap_to_prev(lim, bvprvp, bv->bv_offset))
> +			goto out_err;

So now you limit the input that is accepted?  That's not really how
iov_iters are used.   We can either try to reshuffle the bvecs, or
just fall back to the copy data version as blk_rq_map_user_iov does
for 'weird' iters˙

> +
> +		/* check full condition */
> +		if (nsegs >= nr_segs || bytes > UINT_MAX - bv->bv_len)
> +			goto out_err;
> +
> +		if (bytes + bv->bv_len <= nr_iter &&
> +				bv->bv_offset + bv->bv_len <= PAGE_SIZE) {
> +			nsegs++;
> +			bytes += bv->bv_len;
> +		} else
> +			goto out_err;

Nit: This would read much better as:

		if (bytes + bv->bv_len > nr_iter)
			goto out_err;
		if (bv->bv_offset + bv->bv_len > PAGE_SIZE)
			goto out_err;

		bytes += bv->bv_len;
		nsegs++;


