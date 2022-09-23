Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17297C6FA90
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Sep 2022 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2DdeVd3Vc2InoDjFb6lBXalNzTVoSGEubdgSPrYIVJQ=; b=TdIf4KMFRHaU356t/rsxHxQ/KY
	3zZWRTwDl5n9ahHDoSuRxDKgS8YQD0Sfcedl2Mqybrab7tjSmoS6/TyXQ9+Nr1qgL3oU0u/jDNdFn
	I/9xoW1NNrOwK1IETn5GaAqyaN37XuHkKPRHdbG2Q1XIcNJDXy0XEvUfPYfxnQzVD4xWl2QOFe3rX
	UnXbALidXMlb8DeDAarNzSOayZAC+8a5h3sjaq078yPKgUCeY6qjdgBNdQCE/Pc9nKtVaHqTFt4fK
	cbk1e9agfL5fCAO+lhZwmCJhflbrJ/u6UkcC/e9g9qzv8JA50uMUGJua3i0XxN7seOJ25/nCHZzzN
	c96pfKbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkcf-004ojN-Gr; Fri, 23 Sep 2022 15:29:49 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1obkcd-004oie-6j
	for linux-nvme@lists.infradead.org; Fri, 23 Sep 2022 15:29:48 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9479867373; Fri, 23 Sep 2022 17:29:41 +0200 (CEST)
Date: Fri, 23 Sep 2022 17:29:41 +0200
From: Christoph Hellwig <hch@lst.de>
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: Christoph Hellwig <hch@lst.de>, axboe@kernel.dk, kbusch@kernel.org,
	asml.silence@gmail.com, io-uring@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, Anuj Gupta <anuj20.g@samsung.com>
Subject: Re: [PATCH for-next v7 4/5] block: add helper to map bvec iterator
 for passthrough
Message-ID: <20220923152941.GA21275@lst.de>
References: <20220909102136.3020-1-joshi.k@samsung.com> <CGME20220909103147epcas5p2a83ec151333bcb1d2abb8c7536789bfd@epcas5p2.samsung.com> <20220909102136.3020-5-joshi.k@samsung.com> <20220920120802.GC2809@lst.de> <20220922152331.GA24701@test-zns>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922152331.GA24701@test-zns>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220923_082947_405811_CD174058 
X-CRM114-Status: GOOD (  22.28  )
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

On Thu, Sep 22, 2022 at 08:53:31PM +0530, Kanchan Joshi wrote:
>> blk_rq_map_user_iov really should be able to detect that it is called
>> on a bvec iter and just do the right thing rather than needing different
>> helpers.
>
> I too explored that possibility, but found that it does not. It maps the
> user-pages into bio either directly or by doing that copy (in certain odd
> conditions) but does not know how to deal with existing bvec.

What do you mean with existing bvec?  We allocate a brand new bio here
that we want to map the next chunk of the iov_iter to, and that
is exactly what blk_rq_map_user_iov does.  What blk_rq_map_user_iov
currently does not do is to implement this mapping efficiently
for ITER_BVEC iters, but that is something that could and should
be fixed.

> And it really felt cleaner to me write a new function rather than 
> overloading the blk_rq_map_user_iov with multiple if/else canals.

No.  The whole point of the iov_iter is to support this "overload".

> But iov_iter_gap_alignment does not work on bvec iters. Line #1274 below

So we'll need to fix it.

> 1264 unsigned long iov_iter_gap_alignment(const struct iov_iter *i)
> 1265 {
> 1266         unsigned long res = 0;
> 1267         unsigned long v = 0;
> 1268         size_t size = i->count;
> 1269         unsigned k;
> 1270
> 1271         if (iter_is_ubuf(i))
> 1272                 return 0;
> 1273
> 1274         if (WARN_ON(!iter_is_iovec(i)))
> 1275                 return ~0U;
>
> Do you see a way to overcome this. Or maybe this can be revisted as we
> are not missing a lot?

We just need to implement the equivalent functionality for bvecs.  It
isn't really hard, it just wasn't required so far.

