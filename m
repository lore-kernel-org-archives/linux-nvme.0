Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B9FCC8303C
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Jul 2025 10:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aIbqbwBgG/lyES8ZapCr+jWLXI49EU1keL2UKBLl4ZQ=; b=eWtORr8RyE80as2ybMFTPBV31g
	AEU3H75gMX1nPkGDE0Ksrc1VAGVbVMSOB6SszTd9i/UZ+23Ts7+fPtiVtdrsA97mH+ChGCySFsurf
	myuggJlwDjZZmn2ITDJsa18YCPBJFDb96wcVJ5uRwvYjGMsh4/AtZc4mRc/qHzLFM0OJBIGLMARvV
	mtceaNKNufNEkvAxoQsAXIYdQfvx3IElfpNh5fyWZ1GALBn4KEpOd2VEO3m9RX32w/CAqOFxyHhUR
	YNQs23l83q+T6XvZ/opBKaxVSdGky5fkPRzan+zLHDSGqyGWPGXKwNQzVuhyHYYqE9QPkwJXnRvz0
	4GdSeRow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ5DO-000000050n2-01OV;
	Tue, 08 Jul 2025 10:06:18 +0000
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZ4t1-00000004vIx-0KrK;
	Tue, 08 Jul 2025 09:45:15 +0000
Date: Tue, 8 Jul 2025 02:45:15 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Christoph Hellwig <hch@infradead.org>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-fsdevel@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	David Wei <dw@davidwei.uk>, Vishal Verma <vishal1.verma@intel.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org
Subject: Re: [RFC 00/12] io_uring dmabuf read/write support
Message-ID: <aGzoqyM06rgXIJst@infradead.org>
References: <cover.1751035820.git.asml.silence@gmail.com>
 <aGaSb5rpLD9uc1IK@infradead.org>
 <f2216c30-6540-4b1a-b798-d9a3f83547b2@gmail.com>
 <aGveLlLDcsyCBKuU@infradead.org>
 <e210595b-d01f-4405-9b5d-a486ddca49ed@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e210595b-d01f-4405-9b5d-a486ddca49ed@gmail.com>
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

On Mon, Jul 07, 2025 at 04:41:23PM +0100, Pavel Begunkov wrote:
> > I mean a reference the actual dma_buf (probably indirect through the file
> > * for it, but listen to the dma_buf experts for that and not me).
> 
> My expectation is that io_uring would pass struct dma_buf to the

io_uring isn't the only user.  We've already had one other use case
coming up for pre-load of media files in mobile very recently.  It's
also a really good interface for P2P transfers of any kind.

> file during registration, so that it can do a bunch of work upfront,
> but iterators will carry sth already pre-attached and pre dma mapped,
> probably in a file specific format hiding details for multi-device
> support, and possibly bundled with the dma-buf pointer if necessary.
> (All modulo move notify which I need to look into first).

I'd expect that the exported passed around the dma_buf, and something
that has access to it then imports it to the file.  This could be
directly forwarded to the device for the initial scrope in your series
where you only support it for block device files.

Now we have two variants:

 1) the file instance returns a cookie for the registration that the
    caller has to pass into every read/write
 2) the file instance tracks said cookie itself and matches it on
    every read/write

1) sounds faster, 2) has more sanity checking and could prevent things
from going wrong.

(all this is based on my limited dma_buf understanding, corrections
always welcome).

> > > But maybe that's fine. It's 40B -> 48B,
> > 
> > Alternatively we could the union point to a struct that has the dma buf
> > pointer and a variable length array of dma_segs. Not sure if that would
> > create a mess in the callers, though.
> 
> Iteration helpers adjust the pointer, so either it needs to store
> the pointer directly in iter or keep the current index. It could rely
> solely on offsets, but that'll be a mess with nested loops (where the
> inner one would walk some kind of sg table).

Yeah.  Maybe just keep is as a separate pointer growing the structure
and see if anyone screams.


