Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A176CA0EDB
	for <linux-nvme@archiver.kernel.org>; Mon, 11 Aug 2025 22:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TFWV7ZjE125LVVdLltnqVF9reghkiBLlSe0UbbQ9EGk=; b=sjIE2ExhNQff0yQp2PRhMZcU/a
	GLYLPenIafPGaZq8RSHslDD4HOWswnP+xOToktVXHHL7lxdFXpyXd0Wrz4/sarJxpC+ObG7CEOp9T
	kEabOBVoAVSsISJNtsA9hPKTAFvOXWZzGVV9d1uRH1sMFYw0TeUSIDr9qwQfc9wF8dY3ysdFvcplh
	pxTAs5QQvTJkSdcQDCjpLLUaTQ7cFBkX6J115hgw4JnW3cvmyXG0sRcF6sipSNkSWCAh8uVqgPCQ1
	SuEGVoYHpVxJwUvHcMuVg+kvjvA4FozawF35tnkySyWqWI4uRBAWo/rB3jJNw2B2OPZxlCX5/wklr
	2Wespr/w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulabd-00000009Axv-4BrP;
	Mon, 11 Aug 2025 22:03:02 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ulVwk-00000008V5H-1aUM
	for linux-nvme@lists.infradead.org;
	Mon, 11 Aug 2025 17:04:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 28C35A573C3;
	Mon, 11 Aug 2025 17:04:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81F4EC4CEED;
	Mon, 11 Aug 2025 17:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754931868;
	bh=Ecj87zoz6oG5gEz5gvHsxO9dOS+oW9Yi3vJa1BWXwkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xchs4eKmNggSJdqfNvpFpse1O/4VGIDeVv5P7Yr470BhGmhcnvDGlrwOJEaMwHjd0
	 sNOIv3+i2eHmnALzkCJ6+E/Fbpyd2sRW9gkPasFvOH6h2KXfA/jv1z3o89ip6oL5wT
	 Lwk+ShVALh8PBhz4zLRbhj7H8u+7TMffylcfsJjMKf2HU5MHF7Sl02SdDJ5nw1TQPD
	 bHJ+jxuj9WhfGrVnKgBxYL6PQashl7UmTN4ZFfedgm32fNxP1NgF32wQma5+9uhEg8
	 5tSji9+ezJ4uQzwgj00aINh2ufAKBJN9wpSzwVcYjIBQnKl36M3Xv1Jvse54WoUXpv
	 XRy9X9ClG5QVw==
Date: Mon, 11 Aug 2025 11:04:26 -0600
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org, axboe@kernel.dk,
	joshi.k@samsung.com
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being iterated
Message-ID: <aJoimodJJqodW7Kl@kbusch-mbp>
References: <20250808155826.1864803-1-kbusch@meta.com>
 <20250808155826.1864803-3-kbusch@meta.com>
 <20250810140747.GB4262@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250810140747.GB4262@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250811_100430_479506_61DB700B 
X-CRM114-Status: GOOD (  15.67  )
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

On Sun, Aug 10, 2025 at 04:07:47PM +0200, Christoph Hellwig wrote:
> On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> > +static struct blk_map_iter blk_rq_map_iter(struct request *rq)
> > +{
> > +	struct bio *bio = rq->bio;
> > +
> > +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> > +		return (struct blk_map_iter) {
> > +			.bvec = &rq->special_vec,
> > +			.iter = {
> > +				.bi_size = rq->special_vec.bv_len,
> > +			}
> > +		};
> 
> These large struct returns generate really horrible code if they aren't
> inlined (although that might happen here).  I also find them not very
> nice to read.  Any reason to just pass a pointer and initialize the
> needed fields?

I initially set out to make a macro, inpsired by other block iterator
setups like "bvec_iter_bvec", but I thought the extra cases to handle
was better implemented as an inline function. I am definitely counting
on this being inlined to produce good code, so I should have annotated
that. No problem with switching to take a pointer, but I doubt the
resulting assembly is better either way.

