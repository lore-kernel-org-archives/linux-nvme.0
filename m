Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BEEC19F2A
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Aug 2022 03:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+0oJJsRtZoSbz2Jy7SgiYFuIyaBdLEXe8ci5lOmK3LU=; b=05SnlPJXJyupa1irfzkC1ufg4A
	L8CpgYu0h4OutcJSRHSm8Y/fzU3RAc84mEx4LO8dcHTVLRDa5jw9hxBOQaNgUjVl65stOBmkhS5P2
	Se6oNROEBnCC6/R++VXcnuVhXyB4SyfeSNk1uswh5s28yV/yCKnIOH4npfn9v49jAS2mipXhRCt0d
	Sgbf7+QhbBzCk9eMU1nAh47nxgQ908lD4mlvDgsydxcmdY94X2sG+D2b/F86ki5vbsqy03MMm1+bQ
	6O+0bypMdM9sg8OYnzqJ1yj+X70TRTVc40AKhL7xf34rnpmOo/IXTX9DyVc9l9Sgd9tAORmOdTvfS
	2wRSz80A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKt0G-008Kne-70; Mon, 08 Aug 2022 03:00:28 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oKsIM-007ulc-4f
	for linux-nvme@lists.infradead.org; Mon, 08 Aug 2022 02:15:07 +0000
Received: from dread.disaster.area (pa49-181-193-158.pa.nsw.optusnet.com.au [49.181.193.158])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 1420762D0BA;
	Mon,  8 Aug 2022 12:15:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1oKsIH-00ATVq-0V; Mon, 08 Aug 2022 12:15:01 +1000
Date: Mon, 8 Aug 2022 12:15:01 +1000
From: Dave Chinner <david@fromorbit.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: Keith Busch <kbusch@fb.com>, linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Kernel Team <Kernel-team@fb.com>, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv3 2/7] file: add ops to dma map bvec
Message-ID: <20220808021501.GH3861211@dread.disaster.area>
References: <20220805162444.3985535-1-kbusch@fb.com>
 <20220805162444.3985535-3-kbusch@fb.com>
 <20220808002124.GG3861211@dread.disaster.area>
 <YvBjRfy4XzzBajTX@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvBjRfy4XzzBajTX@casper.infradead.org>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62f071a6
	a=SeswVvpAPK2RnNNwqI8AaA==:117 a=SeswVvpAPK2RnNNwqI8AaA==:17
	a=kj9zAlcOel0A:10 a=biHskzXt2R4A:10 a=7-415B0cAAAA:8
	a=8EX0so7LDa7W9hh0J8wA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220807_191506_376833_9AB45A47 
X-CRM114-Status: GOOD (  27.29  )
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

On Mon, Aug 08, 2022 at 02:13:41AM +0100, Matthew Wilcox wrote:
> On Mon, Aug 08, 2022 at 10:21:24AM +1000, Dave Chinner wrote:
> > > +#ifdef CONFIG_HAS_DMA
> > > +	void *(*dma_map)(struct file *, struct bio_vec *, int);
> > > +	void (*dma_unmap)(struct file *, void *);
> > > +#endif
> > 
> > This just smells wrong. Using a block layer specific construct as a
> > primary file operation parameter shouts "layering violation" to me.
> 
> A bio_vec is also used for networking; it's in disguise as an skb_frag,
> but it's there.

Which is just as awful. Just because it's done somewhere else
doesn't make it right.

> > What we really need is a callout that returns the bdevs that the
> > struct file is mapped to (one, or many), so the caller can then map
> > the memory addresses to the block devices itself. The caller then
> > needs to do an {file, offset, len} -> {bdev, sector, count}
> > translation so the io_uring code can then use the correct bdev and
> > dma mappings for the file offset that the user is doing IO to/from.
> 
> I don't even know if what you're proposing is possible.  Consider a
> network filesystem which might transparently be moved from one network
> interface to another.  I don't even know if the filesystem would know
> which network device is going to be used for the IO at the time of
> IO submission.

Sure, but nobody is suggesting we support direct DMA buffer mapping
and reuse for network devices right now, whereas we have working
code for block devices in front of us.

What I want to see is broad-based generic block device based
filesysetm support, not niche functionality that can only work on a
single type of block device. Network filesystems and devices are a
*long* way from being able to do anything like this, so I don't see
a need to cater for them at this point in time.

When someone has a network device abstraction and network filesystem
that can do direct data placement based on that device abstraction,
then we can talk about the high level interface we should use to
drive it....

> I think a totally different model is needed where we can find out if
> the bvec contains pages which are already mapped to the device, and map
> them if they aren't.  That also handles a DM case where extra devices
> are hot-added to a RAID, for example.

I cannot form a picture of what you are suggesting from such a brief
description. Care to explain in more detail?

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

