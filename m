Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A07ACD4F3C
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2026 12:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rQgx3EHg/j1A6oSAAl3ca5ZUOXCGoWaoM7uAkfkD37A=; b=ccs6E+3PhbUsSqgnu0FSACpbLE
	SgGPnXTOkkdLfGVgUaeq2ORbY+CAm/IYHJR9RPLfAe5lujg9eQwa3LBl//jsPo/2uGRalz0NKQr/B
	j5y2OFyGJtj4KlXxOJbduJYd9HPY2FQkq1S/gcqIafwtaN9R19NrrkeNUgWcMzonTjdnNPkjvc/CF
	ISEt5SD31GxgMpKrzUYhiUVN6gcPhjUZ8WUKtcYt1RxmadDtc2Ggl9NdNPTLbhV/ZrMB9z5zX4dBV
	sKTh7+cYsklBTIYwSHwB+2Pp5XD31QhNEjsBLt2fHyoi77xRBQdzE1RjGKGut35p2GtczC1C3yuLo
	NRaRg0eQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUa-0000000FiAM-3T9z;
	Mon, 18 May 2026 12:54:44 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wOxUY-0000000Fi9a-3rnD
	for linux-nvme@lists.infradead.org;
	Mon, 18 May 2026 12:54:44 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 003E768D09; Mon, 18 May 2026 14:54:39 +0200 (CEST)
Date: Mon, 18 May 2026 14:54:39 +0200
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
Subject: Re: [PATCH v3 04/10] block: introduce dma map backed bio type
Message-ID: <20260518125439.GB5754@lst.de>
References: <cover.1777475843.git.asml.silence@gmail.com> <646ecd6fde8d9e146cb051efb514deb27ce3883e.1777475843.git.asml.silence@gmail.com> <20260513081929.GD5477@lst.de> <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24833f76-2289-4859-86d1-9215b11a1258@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260518_055443_102245_B17242F1 
X-CRM114-Status: GOOD (  13.92  )
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

On Mon, May 18, 2026 at 11:29:54AM +0100, Pavel Begunkov wrote:
> On 5/13/26 09:19, Christoph Hellwig wrote:
>>> +	if (!bio_flagged(bio_src, BIO_DMABUF_MAP)) {
>>> +		bio->bi_io_vec = bio_src->bi_io_vec;
>>> +	} else {
>>> +		bio->dmabuf_map = bio_src->dmabuf_map;
>>> +		bio_set_flag(bio, BIO_DMABUF_MAP);
>>> +	}
>>
>> This is backwards, please avoid pointless negations:
>
> I can flip it, but compilers tend to prefer the true branch. E.g. this

What kind of compiler optimization do you expect from code where
both sides of the conditional assign different arms of the same union
and just propagate the bit that was set?

