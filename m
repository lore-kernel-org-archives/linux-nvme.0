Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C6ECC87FCA
	for <linux-nvme@archiver.kernel.org>; Sun, 10 Aug 2025 14:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sw0+v1YfKJ3x64IUmMmRvha7O2+ih+ZtS6D9ly0Mn2s=; b=R4Y1FHBbKP3e2VbeSG1/1uaF1Q
	+FnrMgzEeDeejVAiYEtW6tTnu6D+Q/4CR21NoibqAZKLYw4zpmQjPAKaLZvH5jl3T6thiYKTFdW48
	HRoIhl0cXb3PvChUoH6yl2fwyusnyOaNf1vLNQi4fcyU6OTdAwt1wERB7+cc0uSEPnwFOj8KduX3U
	k4uUyXy5fMjxpR3EUHA5aEkhj4yXTFbojBdmzB/8Ymsx/X/eA/RQipHguZAGzPok+niddsSvyK/cn
	Xd4+CvAz/LwPiqHvRoqJSB6oVmlLbZ9yJ5m52GrxdSa1r3gWCCSjDN6lNF93oQHvLLczTcBAlQ+Wu
	4Mi7Lh2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6iK-00000005fbv-1g8e;
	Sun, 10 Aug 2025 14:07:56 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul6iH-00000005fbZ-3s7H
	for linux-nvme@lists.infradead.org;
	Sun, 10 Aug 2025 14:07:55 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id B3E4E68BEB; Sun, 10 Aug 2025 16:07:47 +0200 (CEST)
Date: Sun, 10 Aug 2025 16:07:47 +0200
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, hch@lst.de,
	axboe@kernel.dk, joshi.k@samsung.com,
	Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv5 2/8] blk-mq-dma: provide the bio_vec list being
 iterated
Message-ID: <20250810140747.GB4262@lst.de>
References: <20250808155826.1864803-1-kbusch@meta.com> <20250808155826.1864803-3-kbusch@meta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250808155826.1864803-3-kbusch@meta.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250810_070754_103258_4A9F4610 
X-CRM114-Status: GOOD (  17.57  )
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

On Fri, Aug 08, 2025 at 08:58:20AM -0700, Keith Busch wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> This will make it easier to add different sources of the bvec table,
> like for upcoming integrity support, rather than assume to use the bio's
> bi_io_vec. It also makes iterating "special" payloads more in common
> with iterating normal payloads.

I would call the array a table (or maybe array) and not a list.

> +static struct blk_map_iter blk_rq_map_iter(struct request *rq)
> +{
> +	struct bio *bio = rq->bio;
> +
> +	if (rq->rq_flags & RQF_SPECIAL_PAYLOAD) {
> +		return (struct blk_map_iter) {
> +			.bvec = &rq->special_vec,
> +			.iter = {
> +				.bi_size = rq->special_vec.bv_len,
> +			}
> +		};

These large struct returns generate really horrible code if they aren't
inlined (although that might happen here).  I also find them not very
nice to read.  Any reason to just pass a pointer and initialize the
needed fields?

Also this function probably should be named blk_rq_map_iter_start or
blk_rq_map_iter_init as it only is used for the very first iteration.


