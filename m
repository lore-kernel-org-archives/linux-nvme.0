Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27296C433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Mar 2022 08:35:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xdOWka+QPZUbntZxx9NP4CCMiaK9jn1nokbLWMIEjQQ=; b=4Yc2JdKwUfeL+Al8mmYUi9QHkl
	6GgvBJKL3fykQYN4YA9NQeaK463GsckCgdpQ2VQQlY3mwSTt1obFZLC/K6LrWtc9Y7SVYxboUZuQu
	WoAY7b8C9/KzsAtecRyckidFvXZYFpvFRUZwT6Ca0tEy9YnzLvgPVXKiXUqAeNOWp8Voo3+k8nncH
	P2jfQw8e94a/fvTAKPoiYkOTniBJsyYemfRyKp0quObkT1T9ZzlpShrm3st4Ux3dfVo5x/19ARjQU
	1DRcIwDIzwbo7XUFI+aXdgWVg5QXrlhJwyxpQX5Hfi8lWs/57bmLvoGri2m2OoiJyJPJt+hUbztyh
	K1qeqb4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nSEGt-00Bw3d-E1; Thu, 10 Mar 2022 08:35:43 +0000
Received: from verein.lst.de ([213.95.11.211])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nSEGJ-00Bvn9-4B
 for linux-nvme@lists.infradead.org; Thu, 10 Mar 2022 08:35:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 38BFF68AFE; Thu, 10 Mar 2022 09:35:04 +0100 (CET)
Date: Thu, 10 Mar 2022 09:35:03 +0100
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: axboe@kernel.dk, hch@lst.de, kbusch@kernel.org, asml.silence@gmail.com,
 io-uring@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-block@vger.kernel.org, sbates@raithlin.com,
 logang@deltatee.com, pankydev8@gmail.com, javier@javigon.com,
 mcgrof@kernel.org, a.manzanares@samsung.com, joshiiitr@gmail.com,
 anuj20.g@samsung.com
Subject: Re: [PATCH 11/17] block: factor out helper for bio allocation from
 cache
Message-ID: <20220310083503.GE26614@lst.de>
References: <20220308152105.309618-1-joshi.k@samsung.com>
 <CGME20220308152716epcas5p3d38d2372c184259f1a10c969f7e4396f@epcas5p3.samsung.com>
 <20220308152105.309618-12-joshi.k@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308152105.309618-12-joshi.k@samsung.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220310_003507_349196_CB815F5B 
X-CRM114-Status: GOOD (  10.93  )
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

On Tue, Mar 08, 2022 at 08:50:59PM +0530, Kanchan Joshi wrote:
> +struct bio *bio_alloc_kiocb(struct kiocb *kiocb, unsigned short nr_vecs,
> +			    struct bio_set *bs)
> +{
> +	if (!(kiocb->ki_flags & IOCB_ALLOC_CACHE))
> +		return bio_alloc_bioset(GFP_KERNEL, nr_vecs, bs);
> +
> +	return bio_from_cache(nr_vecs, bs);
> +}
>  EXPORT_SYMBOL_GPL(bio_alloc_kiocb);

If we go down this route we might want to just kill the bio_alloc_kiocb
wrapper.

