Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B713CD37B6
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:12:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TpAYosl9slccEP2FBB7SSfbQm6lJiZx763AlF73vs64=; b=AeFhEblumRY2oOxPjjHT8fF0Kr
	bFV8jdggskoAIJPURMb4GvKvYhJBtgvwt3p+peOlXW5fGskkEDv3FKYQUap9jSwdsOfpB8JHB5Jbf
	NdQDD3KeYplGPOsiYIJJsvq5MHHGBUG4sewPXAQ8Sq0jrWEC1qkvWBk3Te6+Rgoz7L/u5kDFrdnN7
	4a+rvDofrfq4H6o9AUhNKBJc4PyroOiwHl1sftti3z9h5/lDCoIKAVQ3HKB7XNlGcD8Pr0xwumofu
	FZVpJsMqpihGAaeNEsuwOOldMyQPwxAAcKVKq5TETkL8HAGOHPCCoPawje/S1WuZv6DKFje13Slep
	Sb+Zoiog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4hv-00000001hO0-2bl3;
	Wed, 13 May 2026 08:12:43 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4ht-00000001hNM-3AZT
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:12:43 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id C4F8068BEB; Wed, 13 May 2026 10:12:38 +0200 (CEST)
Date: Wed, 13 May 2026 10:12:38 +0200
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
Subject: Re: [PATCH v3 03/10] block: move bvec init into __bio_clone
Message-ID: <20260513081238.GC5477@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43a91f54d61d3329316e40c69ace781b4d35fe0b.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_011241_941023_445C3C5D 
X-CRM114-Status: GOOD (  13.51  )
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

On Wed, Apr 29, 2026 at 04:25:49PM +0100, Pavel Begunkov wrote:
> To quote Cristoph: "Historically __bio_clone itself does not clone the

It's Christoph.

> payload, just the bio. But we got rid of the callers that want to clone
> a bio but not the payload long time ago". So let's move ->bi_io_vec
> assignment into __bio_clone(), so we have a single point where it's set.

but this he-said, she-said is totally irrelevant.

Please state here why this is useful/important, which matters for anyone
trying to understand the code in the future.


