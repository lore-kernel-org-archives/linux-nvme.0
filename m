Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E87F9C433EF
	for <linux-nvme@archiver.kernel.org>; Sat, 23 Jul 2022 05:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yPkHEoIQjPt6lQAAcJNkqCIFlq/qJSZHwhawG3t8F1U=; b=0uw2bDYXmYtD+7TXfEe2dS6bME
	7W9ZhqU845Y5z83Oge9dB69OJCo+Rra2dRrhwfrXm7C758inCLenosLCWvOU2dlGoWay7fr1gSflf
	YzoYz6rtczj3OrEI+UFJu1FLZ4YIKq3CBL8pRdi5whbRx2PSDhsUhlF8eTiwVWn2uuoi4I2N3UJTh
	fpTOsyxEC+7arP2Q0N/FWmuIHYhBz/D6aefIclUulKY1xpodJUSETO35zJJoKZ9Q1Ily8Nh/INh6S
	iXZBd3Ug42+q68eIy1osdddkIggahR+kmDHMS7AIBP00bRYAl8LrD/NOVaPjHI5hazeyLrZYQcTIH
	+BcNtURw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF7IR-00FrnV-2R; Sat, 23 Jul 2022 05:03:23 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF7IO-00FrlL-00
	for linux-nvme@lists.infradead.org; Sat, 23 Jul 2022 05:03:21 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 78724B82BDE;
	Sat, 23 Jul 2022 05:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A452C341C0;
	Sat, 23 Jul 2022 05:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658552596;
	bh=AaXFZrwKTUU6UrRXrK94Z+zja72i1JjD3maZa+2WSDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NiPTZKSntRLpsWC2wnEE/9s5Ls/ZV/qrKlqVIc1zO4K13INz/0pAB23jjh+OIe7Tb
	 aVLUcjYx/E1f93YFKBHh6aF95V6SekpqSSQIbeSA/e+2vU4E6KJs/geUKC57+cZBXQ
	 Xp0Aim38hl+Kp2FRQpOR+J/blPWy9OQ6nTQM+X0KCptWqjbOA8fba8Qmo+qSyHIcCB
	 WkqPesCM9h8o31anSVs3tyFkotxcc5XlUjsHc23KYfW73nxG8qicIVJsNUGp+yChFd
	 As/bA1MVnE3ZuwU4WizlJnw19tLqcMIZTcW6iJ1zOTW3+sWC/V3DbMrhHxjq6rTm5t
	 C0YYwut8nyrIw==
Date: Fri, 22 Jul 2022 22:03:15 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
	pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YtuBE8EZbATU495P@magnolia>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
 <YtrkJgwOmCGqPO3E@magnolia>
 <YtromC4cR5a0mog8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtromC4cR5a0mog8@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_220320_355639_5EA77654 
X-CRM114-Status: GOOD (  31.21  )
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

On Fri, Jul 22, 2022 at 06:12:40PM +0000, Eric Biggers wrote:
> On Fri, Jul 22, 2022 at 10:53:42AM -0700, Darrick J. Wong wrote:
> > On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> > > [+f2fs list and maintainers]
> > > 
> > > On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > > > From: Keith Busch <kbusch@kernel.org>
> > > > 
> > > > Use the address alignment requirements from the block_device for direct
> > > > io instead of requiring addresses be aligned to the block size.
> > > > 
> > > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > > ---
> > > >  fs/iomap/direct-io.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > > index 370c3241618a..5d098adba443 100644
> > > > --- a/fs/iomap/direct-io.c
> > > > +++ b/fs/iomap/direct-io.c
> > > > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > > >  	struct inode *inode = iter->inode;
> > > >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> > > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > > >  	loff_t length = iomap_length(iter);
> > > >  	loff_t pos = iter->pos;
> > > >  	unsigned int bio_opf;
> > > > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > > >  	size_t copied = 0;
> > > >  	size_t orig_count;
> > > >  
> > > > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > > > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > > > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> > 
> > How does this change intersect with "make statx() return DIO alignment
> > information" ?  Will the new STATX_DIOALIGN implementations have to be
> > adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?
> > 
> > I'm guessing the answer is yes, but I haven't seen any patches on the
> > list to do that, but more and more these days email behaves like a flood
> > of UDP traffic... :(
> > 
> 
> Yes.  I haven't done that in the STATX_DIOALIGN patchset yet because I've been
> basing it on upstream, which doesn't yet have this iomap patch.  I haven't been
> expecting STATX_DIOALIGN to make 5.20, given that it's a new UAPI that needs
> time to be properly reviewed, plus I've just been busy with other things.  So
> I've been planning to make the above change after this patch lands upstream.

<nod> Ok, I'm looking forward to it.  Thank you for your work on statx! :)

--D

> - Eric

