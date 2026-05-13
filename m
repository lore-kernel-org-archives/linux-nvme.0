Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53E62CD37B6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:39:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HtbjjdblYVCQSSsHtyD2EOjh8artnGA87YWBZEdF5jE=; b=WhUuuvaKRRJQfZKkSEdwnTdGSQ
	9AbqOgmHpr+F7TLCuONzGlFXc2mDf9pi0LXmg6/rDg+AutJd48sxK7tKBd3MwMLGRu35xJgj+r9Qb
	Nuzcg2mydBHGGBkozzgL1NQDP0i0gE++6IhF2pnUxNCRm5bSQAw0mHzP7AN843KlO30CK3CqnK9iO
	d728Si65eBVLT4s2FPHphiHs2yt5QjJ5tStcY8FN3wegw9CjmUUEfWxe2HmrG79gpqAGWGEHp/I2T
	XP2dOeV5vuBagt42M+NOcVPRI2AdhQbEy5JP5Tr98INYqhxizBZ458XNjZtDWZIYkwvz7hM2EXH2M
	sxFhvkSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN586-00000001lZY-2KgA;
	Wed, 13 May 2026 08:39:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN585-00000001lZG-3D3r
	for linux-nvme@bombadil.infradead.org;
	Wed, 13 May 2026 08:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HtbjjdblYVCQSSsHtyD2EOjh8artnGA87YWBZEdF5jE=; b=ir60aw4B+xqYL3/GKWVi5RLMpw
	c7XbEt51HMXgrL34z4KNkvL+pp1xVsSxFYKHg8vnUo8J3C1UtLZhMzyxUj85xk/WdEKNlWf9zQj+j
	LZlZ9hqdYG4bkg/nkjHaMg9ckj/nOVtmjgOkHvp6c2hLWmQqrUe3mcQZgNT/16XBpHQtAzo7r5Z9y
	BLPKQB87fw0cbRdW6J7y4f88+0/4MDswKiDGP/4kBKN3UZjJDvqK41R+rtR/ptVt6UScm8NhlffS4
	Ohjisf8p8E+hdYkOzylLo0tacUhRXV0BjrZxSjcM72enejNvIwJiiXngTF22EvFFm2vSzp2p7NckC
	0CdatVBg==;
Received: from verein.lst.de ([213.95.11.211])
	by desiato.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN582-0000000GrPh-0zB5
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:39:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 9330B68C4E; Wed, 13 May 2026 10:39:37 +0200 (CEST)
Date: Wed, 13 May 2026 10:39:37 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
	io-uring@vger.kernel.org, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260513083937.GD6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_093942_700003_444D0B54 
X-CRM114-Status: GOOD (  11.30  )
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

> +	union {
> +		struct bio_vec		*bi_io_vec;
> +		/* Driver specific dma map, present only with BIO_DMABUF_MAP */
> +		struct io_dmabuf_map	*dmabuf_map;
> +	};

... and please add the bi_ prefix we're using for all (well except for
one oddity) fields in struct bio.

