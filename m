Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F25BCD4851
	for <linux-nvme@archiver.kernel.org>; Tue, 19 May 2026 09:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ysebMCv5w7OBEWv/ZVYe4q+y43+dD+Gm1U2+xBhH9hI=; b=XjZb3qJ+Bt2mAJ2Hukvd2QlL1E
	iNJyq8AYBZQ9RNxZXZXliAhCkWaFnHIUImd5CIWzJnGiYd2OvewWSwtw8K0EYgIYZtsLj3A1ahPTY
	ah3TfiFY3x3aezy0GUa37PeIOvEZfLhgsz7LBkKkhXZm5WRwvehJMETb3mP9etE9ltFGXyIIGUmip
	6fGy1RKCEvbjq2KtfNcYe7e2KFnjDHinTexXSmPVYJbWc3cH9HL52buAZhs9fea6kLZ5L2WozEFhF
	Y4KV49uwIwYGS3eyP2YFDQSX+YnzizuCnQ+RVQxT2SXqqmHra6HZ0wd8dYDtL4Y9zd/6RGxli1R+V
	x+sRswGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGhu-00000000uwy-39qS;
	Tue, 19 May 2026 09:25:46 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPGhr-00000000uvB-3bsy
	for linux-nvme@lists.infradead.org;
	Tue, 19 May 2026 09:25:45 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4A1F868C4E; Tue, 19 May 2026 11:25:38 +0200 (CEST)
Date: Tue, 19 May 2026 11:25:38 +0200
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
Message-ID: <20260519092538.GA19935@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <c61e6d928f86f4cb253ae350272e6039faefd3a6.1777475843.git.asml.silence@gmail.com> <20260513082431.GA6461@lst.de> <ebf41920-5852-428f-b98a-e0f44c8f3315@gmail.com> <20260518125326.GA5754@lst.de> <ea47051e-697f-4017-a514-be6ef7c110e9@gmail.com> <20260519065653.GB8173@lst.de> <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9933142a-4ce2-4219-9574-73da30edd74e@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260519_022544_053999_B116C2B0 
X-CRM114-Status: GOOD (  21.34  )
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

On Tue, May 19, 2026 at 08:55:32AM +0100, Pavel Begunkov wrote:
> On 5/19/26 07:56, Christoph Hellwig wrote:
>> On Mon, May 18, 2026 at 03:23:53PM +0100, Pavel Begunkov wrote:
>>> To be fair, it's not that dma-buf specific. This lib/ code only
>>> does some resv locking, fence waiting and queuing fences,
>>
>> But all the dma resv/fence stuff is pretty tied into the dma-buf
>> ecosystem.  I don't think it would really apply to something not
>> doing DMA at all.
>
> The point is that those can be separated to reuse the rest.

Are you actually doing this right now?  If so please share what you
have, otherwise let's keep the dma-buf bits together and move things
if new abstractions emerge.

>> But none of that really sits in the current lib/ code anyway?
>
> It's about naming. E.g. passing a DMABUF_ITER that doesn't have a
> dma-buf would be confusing, and then it'll need renaming at all
> layers to support the use case.

Again, if you concretely are doing this right now, find a good
name and place based on those abstractions.  If not let's ignore
it and move it if needed.

>> drivers/dma-buf is a pretty natural place for it, I could not thing
>
> _If_ there is no dma mappings, drivers/dma-buf would definitely
> be an awkward spot.

Yes.  But that's not the case right now.  And from looking at the
handwaiving for ublk/fuse probably not anytime soon, but maybe I'm
mistaken on the latter.


