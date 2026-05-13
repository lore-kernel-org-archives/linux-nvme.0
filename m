Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 339B6CD4F24
	for <linux-nvme@archiver.kernel.org>; Wed, 13 May 2026 08:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wEjwrapJBwi9Jo1imi3ZcyN1XeChzDjnP4NKlS63InA=; b=EPVsTZO4Dt2FRSWQhsyEfQXqtn
	IoviGkPkEChRkuKPhiKGP1wBstf9cBeO3BCp8bXqGVXpAkVp5Bf3IYMivE3HoFi+nIZjZiCgm54Gt
	TGTJMC4s33U/vq9HYMmE3lfROb1H/bEkuQvd7oydcBf5VHEnlMHWefuPj+c6v5Fw/1YJgaw37lCBs
	tsSZrJ2zv3W8owa9J7dw/4QrFlQCReNrxwsQ3llsW+moEUpIfaqGq6cpQEF7aLLSHI5nPv7YlMk2C
	CfQOO91fqKcoI3D1CZyuuSZcohmmCeXy55XLNSf2N5orFyKz3+8x1IVxsDRznxkhWxUhwBchxueJ6
	pjYUlCsA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4tS-00000001jHm-1OYu;
	Wed, 13 May 2026 08:24:38 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wN4tQ-00000001jH3-0xts
	for linux-nvme@lists.infradead.org;
	Wed, 13 May 2026 08:24:37 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7BA0668C4E; Wed, 13 May 2026 10:24:31 +0200 (CEST)
Date: Wed, 13 May 2026 10:24:31 +0200
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
Subject: Re: [PATCH v3 05/10] lib: add dmabuf token infrastructure
Message-ID: <20260513082431.GA6461@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260513_012436_412300_CB77695A 
X-CRM114-Status: GOOD (  11.63  )
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

Naming and placement:

This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
But I'd like to hear from the dma-buf maintainers about that.

Config option:  as this unconditionally when DMA_SHARED_BUFFER is enabled,
why does it need a separate config option?

Interface:  io_dmabuf_token_create / ->create_dmabuf_token filling
in a structure allocated by the caller feels odd.  My gut feeling
would be to move most of io_dmabuf_token_create into a helper called
by ->create_dmabuf_token so that the token is allocated in the
driver data structure and returned from create_dmabuf_token.


