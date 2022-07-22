Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBEFC43334
	for <linux-nvme@archiver.kernel.org>; Fri, 22 Jul 2022 18:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5iPBleV2UrfDaZPMMg4QczBWZh05BtXe3QutunZ70qE=; b=rSlgMkJ+oJjfdKS4x6QtXD7SFZ
	0shXKKN8CC8xoE7r2LbT5FxvrYtfBJqQ7kxLkPEg7yzfIctvfHFH3VlNazPZBavjKQ19Ksg7HmImw
	ZOll1S+hZAlrmEYR60qGGh3Of6OYKXuI7HY/vBVWduKAVk5WJt009MPE5VStlaeRCZ18NgJYQFA/u
	rca7JsQ498xwtocIs8hbxTkMWEUvbInTLrwc62DwulwV1n2ZoQST3m9FVFJXHG+SUNgBxTxfw9DiX
	Dxhie4CorZpy9vJL8edcWhFRiW2cNv8KHNUsac4R7wn/WtXe/vMCWyhSV/gTxwTDfYPa2hKd/Lscq
	uEePfk3g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEx8n-008nNv-PX; Fri, 22 Jul 2022 18:12:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oEx8l-008nMM-FP
	for linux-nvme@lists.infradead.org; Fri, 22 Jul 2022 18:12:44 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id ACB51622E2;
	Fri, 22 Jul 2022 18:12:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3060C341C7;
	Fri, 22 Jul 2022 18:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658513562;
	bh=SXPNOONZxoOFfrmPhLGGVYznyVMyiqiQEmogruZ0f5k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BDmaxFrpcwMbt5VIMHUiAVjCWcU4o7lcqAfQ5IgmvUvBYcnYCHkaixWZo4y6wPZUp
	 JbLzrfPnOGqWMO4KBF8PNKiyZKfXAyk7ejCOIi42se9wOgWRTvj/MOn/z76bu4Vugf
	 edPq0KXLmyeXgP7SoxA4OQrENNzK5dn6qcrXy5hGovzBrXl5Ajd3ajkiN/pRSiqFpi
	 bpiblTmMpLOHY792no6R7uCY5jtaB/ZZd5LvGkdzd6WXPw8auWKDbkfb9bS5nQv/Eg
	 oiiuSkLzAJhQz/VsCfdc7CwantT0+epSWV2z+Zwph7rIi8+EU0Szzp5eiMRUu3CSxL
	 IKSLzxZpxe1pg==
Date: Fri, 22 Jul 2022 18:12:40 +0000
From: Eric Biggers <ebiggers@kernel.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Keith Busch <kbusch@fb.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
	bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
	pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>,
	linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCHv6 11/11] iomap: add support for dma aligned direct-io
Message-ID: <YtromC4cR5a0mog8@gmail.com>
References: <20220610195830.3574005-1-kbusch@fb.com>
 <20220610195830.3574005-12-kbusch@fb.com>
 <YtpTYSNUCwPelNgL@sol.localdomain>
 <YtrkJgwOmCGqPO3E@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YtrkJgwOmCGqPO3E@magnolia>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220722_111243_607237_EA9A0625 
X-CRM114-Status: GOOD (  27.75  )
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

On Fri, Jul 22, 2022 at 10:53:42AM -0700, Darrick J. Wong wrote:
> On Fri, Jul 22, 2022 at 12:36:01AM -0700, Eric Biggers wrote:
> > [+f2fs list and maintainers]
> > 
> > On Fri, Jun 10, 2022 at 12:58:30PM -0700, Keith Busch wrote:
> > > From: Keith Busch <kbusch@kernel.org>
> > > 
> > > Use the address alignment requirements from the block_device for direct
> > > io instead of requiring addresses be aligned to the block size.
> > > 
> > > Signed-off-by: Keith Busch <kbusch@kernel.org>
> > > Reviewed-by: Christoph Hellwig <hch@lst.de>
> > > ---
> > >  fs/iomap/direct-io.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > > index 370c3241618a..5d098adba443 100644
> > > --- a/fs/iomap/direct-io.c
> > > +++ b/fs/iomap/direct-io.c
> > > @@ -242,7 +242,6 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	struct inode *inode = iter->inode;
> > >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> > >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> > > -	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > >  	loff_t length = iomap_length(iter);
> > >  	loff_t pos = iter->pos;
> > >  	unsigned int bio_opf;
> > > @@ -253,7 +252,8 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
> > >  	size_t copied = 0;
> > >  	size_t orig_count;
> > >  
> > > -	if ((pos | length | align) & ((1 << blkbits) - 1))
> > > +	if ((pos | length) & ((1 << blkbits) - 1) ||
> > > +	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
> 
> How does this change intersect with "make statx() return DIO alignment
> information" ?  Will the new STATX_DIOALIGN implementations have to be
> adjusted to set stx_dio_mem_align = bdev_dma_alignment(...)?
> 
> I'm guessing the answer is yes, but I haven't seen any patches on the
> list to do that, but more and more these days email behaves like a flood
> of UDP traffic... :(
> 

Yes.  I haven't done that in the STATX_DIOALIGN patchset yet because I've been
basing it on upstream, which doesn't yet have this iomap patch.  I haven't been
expecting STATX_DIOALIGN to make 5.20, given that it's a new UAPI that needs
time to be properly reviewed, plus I've just been busy with other things.  So
I've been planning to make the above change after this patch lands upstream.

- Eric

