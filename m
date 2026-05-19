Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B26CD4F54
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FqC/pq2ruIeDK/7zUEWdRi+U7XrUn4PcVEGHi+HaQw4=; b=si0t2h9J+DW0BmM3CXw8rwjiQg
	2XjxSy9iSXJWOGHbYVJk6xqvMdKaGvSoT/kO+xOacdEcKjRO1p3c2kxhm0mJo5r9zJOj5ChPC3k0W
	7Ks1fK60l6ndnHjfU3G2vR/ycomIzrxWdNQZkVWEsoj9wc8x0UH8Hk9yc+rBK64GV1Vcmf/v8wQTN
	uS94papvMUirqEnDNs4c1SFRh5ikput3l3FC/KMAWCFrs+5b3BguaRXcWrFeR5uvcyCYnnaJfLLYz
	VrKmh/ti6+edxeC5TnAm2sWz/BUeyCHoKlK+YR2TSOWCPbl1sR6ywED2Eyiqg+Nvzn0qp9UZahCED
	F48klHrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPENz-00000000QF3-3bk3;
	Tue, 19 May 2026 06:57:03 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPENx-00000000QEA-1m51
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 06:57:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id F393168AFE; Tue, 19 May 2026 08:56:53 +0200 (CEST)
Date: Tue, 19 May 2026 08:56:53 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
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
Message-ID: <20260519065653.GB8173@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com> <20260513082431.GA6461@lst.de> <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com> <20260518125326.GA5754@lst.de> <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_235701_605697_712B418A 
X-CRM114-Status: GOOD (  23.33  )
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

On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
> To be fair, it's not that dma-buf specific. This lib/ code only
> does some resv locking, fence waiting and queuing fences,

But all the dma resv/fence stuff is pretty tied into the dma-buf
ecosystem.  I don't think it would really apply to something not
doing DMA at all.

> otherwise
> all the attaching is done by the driver behind callbacks. Switching
> it to some memfd could be pretty simple. But The main thing it'd
> need to share is iterator handling like forwarding in the block
> layer, and it should be fine as it's already passed as a completely
> opaque object with no knowledge about pages / dma / etc. for the
> middle layers.

But none of that really sits in the current lib/ code anyway?

>> lib/ is most certainly the wrong place for something that absolutely
>> is not library functionality but directly interacts with a few
>> subsystems.
>
> It only interacts with dma-buf, and even for dma-buf attachments
> are created by the driver. Block, nvme, io_uring are users, either
> using the helpers or implementing callbacks.
>
> Ok. Let's assume for the argument's sake it's not dma-buf
> specific, if not lib/, where would you put it? I was also
> assuming that dma-buf being under drivers/ is rather a relic
> of the past rather than the desired location, hmm?

drivers/dma-buf is a pretty natural place for it, I could not thing
where else you'd place dma-buffers.  I'm not sure how hmm has anything
to do with it.

>
>
> -- 
> Pavel Begunkov
---end quoted text---

