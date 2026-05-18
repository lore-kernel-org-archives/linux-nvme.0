Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94E21CD4F52
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 12:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HFSqkQe9ULSxi6P3bSdXC3LzKrL5tGeCFoYnuIX6K4A=; b=WUXQYY0gqmcau9Hkq+9BvOhmG6
	Df/6603g53l3/vW6FE2dBcRBqNXhMfUdHKaKzJ2rke5zpqefu8xiua9pi9zOKQco99ar86AKHChj3
	QZX5arBtJY9rligmg46rgSgDgxlA+Bp6ZJ/Q/YUxU/x6LfA6Ebj59oCo6P4SMVJBAuwkLmUZTP3DU
	6Nzty9H7iVNWMPw6izYQCt9atRSowIY+m0g8znG52hv8Z/7wzjnqP5B6gcoLebTGhE/usbAskXVJg
	YaXzc8zA3QKN4CLS0uzZ4Z0BiZb+D5vS4hbyVStvx2Ag+NJWaocq2vJINmpAWdhJFKc1afjosCFwX
	YmeRlZSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxTT-0000000Fhx3-2cAN;
	Mon, 18 May 2026 12:53:35 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxTQ-0000000Fhw6-3M1G
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 12:53:34 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 8BE4068D05; Mon, 18 May 2026 14:53:26 +0200 (CEST)
Date: Mon, 18 May 2026 14:53:26 +0200
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
Message-ID: <20260518125326.GA5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com> <20260513082431.GA6461@lst.de> <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055332_977089_7DDB3BF6 
X-CRM114-Status: GOOD (  20.69  )
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

On Mon, May 18, 2026 at 11:14:09AM +0100, Pavel Begunkov wrote:
>> This is about dma-buf based I/O.  So I'd expect it to be named dma-buf-io
>> and no io-dmabuf, and live in drivers/dma-buf and not the unrelated lib/.
>> But I'd like to hear from the dma-buf maintainers about that.
>
> Looking at what Ming is saying, it'd make more sense to keep some of the
> parts like iterator and the file op more flexible and not automatically
> imply dma-buf even if it's the main and for now the only medium. I.e.
> ublk/fuse can use a similar interface for mapping buffers to the server
> even without dma mappings.
>
> I don't know how the API should look like, maybe passing memfd, and dma-buf
> supports mmap, but I think it's better to call the op something like
> "register_buffer" instead and keep all it in lib/ for the same reasons.

Let's get the current version landed.  If we come up with some kind of
non-dma dmabuf in the future we can refactor it and move it around.
I'm a little skeptic we'll be able to share code as long as dmabuf
is allergic to physical addresses, though.

lib/ is most certainly the wrong place for something that absolutely
is not library functionality but directly interacts with a few
subsystems.

