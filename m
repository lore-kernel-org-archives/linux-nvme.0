Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DD2AC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 17:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Uxng6bKCwV+3WFR5Qlo4h/csnyoaQJYkWW63EVrbAyw=; b=wBfVLrqVbzeEfQJrLJDqslw5Fu
	k0o6PamNZw5WEYtBdjoYVFoExoS6fEN1cK1k4d9VA/MQ25HvYIephtW8mFOkudoO8u2GWHCx4054/
	ENaNKjx2CAuCDCFayHO9s+oFM6R8vCgfcEiuLCa5BOPWmuQ8tPPWDiABUh8uSRH7EnEriTd9s52Mo
	hqhwovEwT7P6NMrpcfPgCbwIPuW+qj/a/juPJPzMRf9iImf3MbMo06+0nV1U8cJgeN+hOpOCh6egM
	NhneV7bmAfLkEgp1MsSuTiwX3cuK44SVxJwcYD3pihRJYfzedqMpkedUrxp/Nih9jyqF/uG4gqXFq
	3C07n8gw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEwqT-008cYB-7t; Fri, 22 Jul 2022 17:53:49 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEwqQ-008cVC-S5
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 17:53:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 68F24B829D7;
	Fri, 22 Jul 2022 17:53:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14D11C341C6;
	Fri, 22 Jul 2022 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658512423;
	bh=aH7ipXW19B/cULTLHxU4tydKYD6QhKFE7T4q2uxNrD4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ReHgVOJpZKkP8HvxXgI8IsZJv0mIyKP0Mjwfjkhr5FHHBqffXTErE4bbmZgLLCYP6
	 T+AE/FUOtdZbf4fdoggWfrm1qgbi1RlTjVyOjI9Z8n6fzYkt1v0RMuPcTKmY5UGldb
	 0w0gyYORBFfJbzFD1SC7Q8HepbsRIsZP48nbunzpuz14/9fQ8xa/ToiWWAl03lPRjl
	 boz3BJp2x6s0EwT4/FOr/qSpDj6+P/DUYCgt0uRcxuQAd97BvrRkcjYj27IASzCiVo
	 8OmtMEd1bmqXw17QzW/EfL5y20ycJKL4DAc6ySKI5JQatsDZDy13YoHtxWrLLV3RVI
	 CIAGt0syvJzcw==
Date: Fri, 22 Jul 2022 10:53:42 -0700
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
Message-ID: <YtrkJgwOmCGqPO3E@magnolia>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtpTYSNUCwPelNgL@sol.localdomain>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_105347_214135_1F80451E 
X-CRM114-Status: GOOD (  35.99  )
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

On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> [+f2fs list and maintainers]
> 
> On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > Use the address alignment requirements from the block_device for direct
> > io instead of requiring addresses be aligned to the block size.
> > 
> > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  fs/iomap/direct-io.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 370c3241618a..5d098adba443 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	struct inode *inode = iter->inode;
> >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> >  	loff_t length = iomap_length(iter);
> >  	loff_t pos = iter->pos;
> >  	unsigned int bio_opf;
> > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> >  	size_t copied = 0;
> >  	size_t orig_count;
> >  
> > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))

How does this change intersect with "make statx() return DIO alignment
information" ?  Will the new STATX_DIOALIGN implementations have to be
adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?

I'm guessing the answer is yes, but I haven't seen any patches on the
list to do that, but more and more these days email behaves like a flood
of UDP traffic... :(

--D

> >  		return -EINVAL;
> >  
> >  	if (iomap->type == IOMAP_UNWRITTEN) {
> 
> I noticed that this patch is going to break the following logic in
> f2fs_should_use_dio() in fs/f2fs/file.c:
> 
> 	/*
> 	 * Direct I/O not aligned to the disk's logical_block_size will be
> 	 * attempted, but will fail with -EINVAL.
> 	 *
> 	 * f2fs additionally requires that direct I/O be aligned to the
> 	 * filesystem block size, which is often a stricter requirement.
> 	 * However, f2fs traditionally falls back to buffered I/O on requests
> 	 * that are logical_block_size-aligned but not fs-block aligned.
> 	 *
> 	 * The below logic implements this behavior.
> 	 */
> 	align = iocb->ki_pos | iov_iter_alignment(iter);
> 	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
> 	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
> 		return false;
> 
> 	return true;
> 
> So, f2fs assumes that __iomap_dio_rw() returns an error if the I/O isn't logical
> block aligned.  This patch changes that.  The result is that DIO will sometimes
> proceed in cases where the I/O doesn't have the fs block alignment required by
> f2fs for all DIO.
> 
> Does anyone have any thoughts about what f2fs should be doing here?  I think
> it's weird that f2fs has different behaviors for different degrees of
> misalignment: fail with EINVAL if not logical block aligned, else fallback to
> buffered I/O if not fs block aligned.  I think it should be one convention or
> the other.  Any opinions about which one it should be?
> 
> (Note: if you blame the above code, it was written by me.  But I was just
> preserving the existing behavior; I don't know the original motivation.)
> 
> - Eric

