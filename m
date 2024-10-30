Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40BD1D6B6D6
	for <linux-nvme@archiver.kernel.org>; Wed, 30 Oct 2024 20:37:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gTJsHJvk5bs6OnI6mmb8WXIXL+a9mVWWL3CpxThzrFM=; b=obeaerSPFZ/EtbSiuQkE8JYbtk
	yzyBR9iuQWXNwsLnvO+mpSX3tvy+x/13pIJiLH76Xa3CCYASKDp6f0NBHoV9cYrQwYDqAvWhDqN8k
	Z7Ihu43mWsfhmySPd4fqaAQoMuYUuy4/gM7pOAR8v2A6NJ+0UH+lxvavjODq8ncz6Iqq6Ejz77NbP
	igeBvPH4ERvL2MJkwihodKqLcYc7onDhnTTlbPsZ75UHXtXBzp4kDwn1PS/t2RKHjrPQofkmHC/+v
	vLTifWVzYfeVYm5SxmulUUmgctclX3NuYudenj3CL+I8ZDxht/m1uvHzqf+euKc47x+FodhkWpWgg
	nCFA2J4w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FRW-00000001gfl-3e3E;
	Wed, 30 Oct 2024 20:37:26 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t6FRT-00000001gf3-3tA9
	for linux-nvme@lists.infradead.org;
	Wed, 30 Oct 2024 20:37:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 0A46F5C4D75;
	Wed, 30 Oct 2024 20:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFB76C4CECE;
	Wed, 30 Oct 2024 20:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730320642;
	bh=PrJ+6LIqFra5zqIEIDGYKJDXKAfwJPRoggLObenh7h4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KKhDA2ygEUVS6ERioFoB4scqZ9gcxJJRhuLv+hCDw3RnLJ4nTzPW2pOtwsOwRB2RM
	 I2GEtJEavoIE0hlbtXrzHBo/bs8lOkaWKr9VCNs9L3VS3dCTkxFJhKZ+TTWXVpwTAw
	 H+Ja8fOIYdTnFipRPT8JbOOtXYMMrO2BdnhqCLT4RNIKIWGagSJabin8jFUsgVRTv1
	 n7Rjcet4rMiD7dLL1myojyToyhviipQONn1XERVa2wHp43t3CE/REUGMMKtn42wo5F
	 rCJxZRV3AcWguygA8JA2nMKwTuoFEcE6kE/rywpkGIqq59eCECeZYGXtYN2iFR/yr3
	 YlNAtHnspw7aQ==
Date: Wed, 30 Oct 2024 14:37:19 -0600
From: Keith Busch <kbusch@kernel.org>
To: Bart Van Assche <bvanassche@acm.org>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@meta.com>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org, io-uring@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
	javier.gonz@samsung.com
Subject: Re: [PATCHv10 4/9] block: allow ability to limit partition write
 hints
Message-ID: <ZyKY_xdxcM2aSMow@kbusch-mbp.dhcp.thefacebook.com>
References: <20241029151922.459139-1-kbusch@meta.com>
 <20241029151922.459139-5-kbusch@meta.com>
 <a1ff3560-4072-4ecf-8501-e353b1c98bf0@acm.org>
 <20241030044658.GA32344@lst.de>
 <ZyKTACiLUsCEcJ-R@kbusch-mbp.dhcp.thefacebook.com>
 <7f63ba9b-856b-4ca5-b864-de1b8f87d658@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f63ba9b-856b-4ca5-b864-de1b8f87d658@acm.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_133724_036918_339392A4 
X-CRM114-Status: GOOD (  21.11  )
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

On Wed, Oct 30, 2024 at 01:26:38PM -0700, Bart Van Assche wrote:
> On 10/30/24 1:11 PM, Keith Busch wrote:
> > On Wed, Oct 30, 2024 at 05:46:58AM +0100, Christoph Hellwig wrote:
> > > On Tue, Oct 29, 2024 at 10:25:11AM -0700, Bart Van Assche wrote:
> > > > > +}
> > > > 
> > > > bitmap_copy() is not atomic. Shouldn't the bitmap_copy() call be
> > > > serialized against the code that tests bits in bdev->write_hint_mask?
> > > 
> > > It needs something.  I actually pointed that out last round, but forgot
> > > about it again this time :)
> > 
> > I disagree. Whether we serialize it or not, writes in flight will either
> > think it can write or it won't. There's no point adding any overhead to
> > the IO path for this as you can't stop ending up with inflight writes
> > using the tag you're trying to turn off.
> 
> Shouldn't the request queue be frozen while this write_hint_mask bitmap
> is modified, just like the request queue is frozen while queue limits
> are updated? This change wouldn't add any additional overhead to the I/O
> path.

The partitions don't have a queue. If we need to freeze, then changing
one partition's available hints harms IO to other partitions.

Also, block direct IO creates the bio before it freezes. Freezing would
only get writes using the hint you're trying to disable queue up after
all the checks have been done, so you still can't stop making inflight
writes with freeze.

But if by "not atomic", if you're just saying we need a barrier on the
bitmap_copy, like smp_mb__after_atomic(), then yeah, I see that's
probably appropriate here.

