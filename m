Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD066C433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O6a7G0rC7oK4k4QOxo3d9XwzcUBpWHoAKkMYU+KOBww=; b=hBl2WHUzaoyD+pumYIfGznVL2J
	lWYpn4T2cCaDhnqKJV0FWH9nISkBX6Z9fKYmbqH+l1aA2E+XprFeAG7nUEbYorFP6Xfuv3WulFGrY
	/iTEvVEpJwRmGt+n+F1Q7Huj/GVqCa4RuZ3NzC0qE4NglvgvOGGEZWr31X9FDdBF1Yw12O9N9bKjR
	bvoCElL/PlG0tYO4cimJXl0em+Fx8383175R/eyxRhbG/371yZuasrxVxc6eddYZb1iAP13P5tXJi
	HObDQmL2qGktlG8Qon6eKLMBBfsxCbFM750W7UqostDvtxf1k4uXhNCsohRT1HErn18EV2mZBf4of
	Eg4DI0kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEzE0-00AIkH-DI; Fri, 22 Jul 2022 20:26:16 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEzDw-00AIG7-Up
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 20:26:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id AB304B82A67;
	Fri, 22 Jul 2022 20:26:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E25AC341C6;
	Fri, 22 Jul 2022 20:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658521569;
	bh=RILw0uE1mWJCjhuqX2I6i5ZV032oKPt55YY35g+nvcQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LRvT/YJPlOqWf54hNkYLdAPh9Jj56TaUDOudq/KxMOS+ueqM4OtQqAwe9vJEvfMOv
	 XGssMm8KKx/MYT2tRvKLh32wfsodyD1M9Zs/fXwwB9ECqMSyed04jotHQ6cXsuMdIL
	 rikEdz7baEYtl1jcF4wCOCiwF8uk0sfUDNbxGq8GupY49/Ox0lGML6UhwznoEMhx0L
	 S6LiJ09teEXmFnqnySzPySrVrvoGDG/qJqVd/mlFTG25Bhsnlq+Bgohvu+nB8fSiK7
	 MCMqlA6t7p7mUtBlI66WzIhHVy1Q/QHncEgxAneKImThjapRs7SUdon6vqsDNkeUfK
	 jlA8ocedtHbrg==
Date: Fri, 22 Jul 2022 14:26:05 -0600
From: Keith Busch <kbusch@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
	pankydev8@gmail.com, linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YtsH3RvJ86CZVMgN@kbusch-mbp.dhcp.thefacebook.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
 <Ytq3qwTBTRRxBfXv@kbusch-mbp.dhcp.thefacebook.com>
 <Ytrl/1YEg9M0fb+i@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytrl/1YEg9M0fb+i@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_132613_342003_5661E013 
X-CRM114-Status: GOOD (  52.20  )
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

On Fri, Jul 22, 2022 at 06:01:35PM +0000, Eric Biggers wrote:
> On Fri, Jul 22, 2022 at 08:43:55AM -0600, Keith Busch wrote:
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
> > > >  		return -EINVAL;
> > > >  
> > > >  	if (iomap->type == IOMAP_UNWRITTEN) {
> > > 
> > > I noticed that this patch is going to break the following logic in
> > > f2fs_should_use_dio() in fs/f2fs/file.c:
> > > 
> > > 	/*
> > > 	 * Direct I/O not aligned to the disk's logical_block_size will be
> > > 	 * attempted, but will fail with -EINVAL.
> > > 	 *
> > > 	 * f2fs additionally requires that direct I/O be aligned to the
> > > 	 * filesystem block size, which is often a stricter requirement.
> > > 	 * However, f2fs traditionally falls back to buffered I/O on requests
> > > 	 * that are logical_block_size-aligned but not fs-block aligned.
> > > 	 *
> > > 	 * The below logic implements this behavior.
> > > 	 */
> > > 	align = iocb->ki_pos | iov_iter_alignment(iter);
> > > 	if (!IS_ALIGNED(align, i_blocksize(inode)) &&
> > > 	    IS_ALIGNED(align, bdev_logical_block_size(inode->i_sb->s_bdev)))
> > > 		return false;
> > > 
> > > 	return true;
> > > 
> > > So, f2fs assumes that __iomap_dio_rw() returns an error if the I/O isn't logical
> > > block aligned.  This patch changes that.  The result is that DIO will sometimes
> > > proceed in cases where the I/O doesn't have the fs block alignment required by
> > > f2fs for all DIO.
> > > 
> > > Does anyone have any thoughts about what f2fs should be doing here?  I think
> > > it's weird that f2fs has different behaviors for different degrees of
> > > misalignment: fail with EINVAL if not logical block aligned, else fallback to
> > > buffered I/O if not fs block aligned.  I think it should be one convention or
> > > the other.  Any opinions about which one it should be?
> > 
> > It looks like f2fs just falls back to buffered IO for this condition without
> > reaching the new code in iomap_dio_bio_iter().
> 
> No.  It's a bit subtle, so read the code and what I'm saying carefully.  f2fs
> only supports 4K aligned DIO and normally falls back to buffered I/O; however,
> for DIO that is *very* misaligned (not even LBS aligned) it returns EINVAL
> instead.  And it relies on __iomap_dio_rw() returning that EINVAL.

Okay, I understand the code flow now.

I tested f2fs direct io with every possible alignment, and it is successful for
all hardware dma supported alignments and continues to return EINVAL for
unaligned. Is the concern that it's now returning success in scenarios that
used to fail? Or is there some other 4k f2fs constraint that I haven't found
yet?
 
> Relying on __iomap_dio_rw() in that way is definitely a bad design on f2fs's
> part (and I messed that up when switching f2fs from fs/direct-io.c to iomap).
> The obvious fix is to just have f2fs do the LBS alignment check itself.
>
> But I think that f2fs shouldn't have different behavior for different levels of
> misalignment in the first place, so I was wondering if anyone had any thoughts
> on which behavior (EINVAL or fallback to buffered I/O) should be standardized on
> in all cases, at least for f2fs.  There was some discussion about this sort of
> thing for ext4 several years ago on the thread
> https://lore.kernel.org/linux-ext4/1461472078-20104-1-git-send-email-tytso@mit.edu/T/#u,
> but it didn't really reach a conclusion.  I'm wondering if the f2fs maintainers
> have any thoughts about why the f2fs behavior is as it is.  I.e. is it just
> accidental, or are there specific reasons...
> 
> - Eric

