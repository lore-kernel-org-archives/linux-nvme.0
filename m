Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97748CD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 12:57:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BmJ9Xymxb1grPg7JOpGoiTsi7Q3hTKH2JwMsAoVhd1o=; b=lY/jmAKKmIgmupq9j5lmTpZQlh
	NnmiPz9jl8fpRMd5rQEa75d9T4mryEu51NMTtruFk6fh2P9jtgBBWzi64srNpm03kmitNw2rPLOfx
	WcGeEfcYgkKL8pMrc72RHa7vuFOANNyqQY9pa9e6sIhKnxQf0LUT8Fa7GKiJzSuSmDq9Xbt1QOV9p
	P7kC1S6oQVYzZwjy5C8SyZt5hm61rx0Ryd53nx32S7Zldo3zqRFxjhzTQW2F3UD067xmDUwbWy/eX
	eRHDL5vfVgLzcdT3IqtGLEPn1c/zIZ3/zEjpYzjftXyOaZJy08HtKLwgmbBgQgCOXQypaR2FXbrH5
	stDhAE7A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxX6-0000000FjFL-3tvk;
	Mon, 18 May 2026 12:57:20 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxX4-0000000FjDl-1tDr
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 12:57:19 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id E839E68D05; Mon, 18 May 2026 14:57:13 +0200 (CEST)
Date: Mon, 18 May 2026 14:57:13 +0200
From: Christoph Hellwig <hch@lst.de>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sumit Semwal <sumit.semwal@linaro.org>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, io-uring@vger.kernel.org,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Nitesh Shetty <nj.shetty@samsung.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Anuj Gupta <anuj20.g@samsung.com>,
	Tushar Gohad <tushar.gohad@intel.com>,
	William Power <william.power@intel.com>,
	Phil Cayton <phil.cayton@intel.com>,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260518125713.GC5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com> <20260513081929.GD5477@lst.de> <24833f76-2289-4859-86d1-9215b11a1258@gmail.com> <df697a76-c700-4908-ac08-a47ad07e0796@amd.com> <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4561c621-817c-46be-8ff0-0b557f6c819d@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055718_652638_D8C80FA0 
X-CRM114-Status: GOOD (  21.35  )
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

On Mon, May 18, 2026 at 01:40:18PM +0100, Pavel Begunkov wrote:
>> When that is really a performance critical path then you can use the likely() and unlikely() macros to give the compiler the hint which one to prefer.
>
> That might be more penalising than placing them in the right order,
> and it might be fine as it's new and all that, but it's not a clear
> cut as it's definitely not created to be a slow path.

Yes.  Whatever the caller is using at a given time is the fast path here,
and dynamic branch prediction in modern cpus handles this really well.

> TBH, not sure
> why we're bike shedding such things, is it somewhere in the code
> style?

It makes reading the code annoying, so it better have a good reason.
Now for a single conditional it's not much of an issue, but these
things tend to pile up and then start to get really annoying.
Always write your code the most straight forward way unless you
have a good reason not to.


>> What could be useful is to have the true path for the more common and the false path for the less common case for documentation purposes, but in that case I would expected some code comments as well.
> What kind of comment are you thinking about? A "this is not a likely
> path" type of comment before each mention of the flag is usually not
> very useful.

Indeed.  It's also not true here.  If the workload uses dmabufs, the
path obviously is very likely.


