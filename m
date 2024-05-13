Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9476AC25B10
	for <linux-nvme@archiver.kernel.org>; Mon, 13 May 2024 14:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QZg/dFAqcpICRZmyqfGKuFoyUvD/5vej42ebKc5BnIk=; b=u2+Wv1exoqnDPYXxSwP/JGSjVG
	eD3/jzQ1nAHZtUQTSsCbeOLH91wz+53w2RKt4KQRiriISrB16J5I5BB3/iWarxLSvp1RXyIOjiYlJ
	F1QmhPK8BgiMp50WSAOe6S4pkPwE1Hph/JbL9elrVdcJ7akX0u+dnIeXzyMtFxW5s3d/L23VQohK4
	BWQBsj6BiOq2RZzExGIGRr1OOf11yWFeLaycKBKxWScTVrIobpqz1T6oI/z8tjLGjdneYvLBoBcRc
	HNOLHgh/UVi96ZiH+FDcjlOCkzepj3XQ3LOuDfScAvF6/SJwCqoisrLuSJMZCU2R0OJ8G7no0hhrM
	UtSrbaYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6WjY-0000000DCYR-09wP;
	Mon, 13 May 2024 14:32:56 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6WjV-0000000DCY4-1dap;
	Mon, 13 May 2024 14:32:53 +0000
Date: Mon, 13 May 2024 07:32:53 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, hare@kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	Pankaj Raghav <p.raghav@samsung.com>,
	Pankaj Raghav <pankydev8@gmail.com>
Subject: Re: [PATCH 5/5] nvme: enable logical block size > PAGE_SIZE
Message-ID: <ZkIklQU088QYlONS@bombadil.infradead.org>
References: <20240510102906.51844-1-hare@kernel.org>
 <20240510102906.51844-6-hare@kernel.org>
 <Zj_6vDMwyb2O6ztI@bombadil.infradead.org>
 <Zj__oIGiY8xzrwnb@casper.infradead.org>
 <ZkAEhFLVD9gSk0y0@bombadil.infradead.org>
 <ZkAszpvBkb5_UUiH@bombadil.infradead.org>
 <f58dc322-b7d9-487c-854f-c7df953c6519@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f58dc322-b7d9-487c-854f-c7df953c6519@suse.de>
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

On Mon, May 13, 2024 at 03:43:38PM +0200, Hannes Reinecke wrote:
> On 5/12/24 04:43, Luis Chamberlain wrote:
> > On Sat, May 11, 2024 at 04:51:32PM -0700, Luis Chamberlain wrote:
> > > On Sun, May 12, 2024 at 12:30:40AM +0100, Matthew Wilcox wrote:
> > > > On Sat, May 11, 2024 at 04:09:48PM -0700, Luis Chamberlain wrote:
> > > > > We can't just do this, we need to consider the actual nvme cap (test it,
> > > > > and if it crashes and below what the page cache supports, then we have
> > > > > to go below) and so to make the enablment easier. So we could just move
> > > > > this to helper [0]. Then when the bdev cache patch goes through the
> > > > > check for CONFIG_BUFFER_HEAD can be removed, if this goes first.
> > > > > 
> > > > > We crash if we go above 1 MiB today, we should be able to go up to 2
> > > > > MiB but that requires some review to see what stupid thing is getting
> > > > > in the way.
> > > > > 
> > > > > [0] https://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git/commit/?h=20240408-lbs-scsi-kludge&id=1f7f4dce548cc11872e977939a872b107c68ad53
> > > > 
> > > > This is overengineered garbage.  What's the crash?
> > > 
> > > I had only tested it with iomap, I had not tested it with buffer-heads,
> > > and so it would require re-testing. It's Saturday 5pm, I should be doing
> > > something else other than being on my computer.
> > 
> > It crashes because we forgot two things in this series below, so the
> > change below its us to enable to *at least* boot up to 64k LBA format on
> > NVMe.
> > 
> > One can reproduce this with kdevops with:
> > 
> > make defconfig-lbs-xfs-bdev-nvme
> > make bringup
> > make linux
> > 
> > I've added another defconfig which bumps the LBA format up to 512 KiB to
> > see if bootup blows up, that has another defconfig:
> > 
> > make lbs-xfs-bdev-large-nvme
> > make bringup
> > make linux
> > 
> > That at least booted. Note that the above defconfigs use this thread's
> > message ID, so it applies this series on top of the min order branch.
> > The patch below is just needed.
> > 
> > I'll try next going above 512 KiB.
> > diff --git a/fs/buffer.c b/fs/buffer.c
> > index 4f73d23c2c46..fa88e300a946 100644
> > --- a/fs/buffer.c
> > +++ b/fs/buffer.c
> > @@ -2360,8 +2360,6 @@ int block_read_full_folio(struct folio *folio, get_block_t *get_block)
> >   	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
> >   		limit = inode->i_sb->s_maxbytes;
> > -	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> > -
> >   	head = folio_create_buffers(folio, inode, 0);
> >   	blocksize = head->b_size;
> > diff --git a/fs/mpage.c b/fs/mpage.c
> > index e3732686e65f..e124c924b2e7 100644
> > --- a/fs/mpage.c
> > +++ b/fs/mpage.c
> > @@ -178,7 +178,6 @@ static struct bio *do_mpage_readpage(struct mpage_readpage_args *args)
> >   	gfp_t gfp = mapping_gfp_constraint(folio->mapping, GFP_KERNEL);
> >   	/* MAX_BUF_PER_PAGE, for example */
> > -	VM_BUG_ON_FOLIO(folio_test_large(folio), folio);
> >   	if (args->is_readahead) {
> >   		opf |= REQ_RAHEAD;
> > 
> Thanks. Will be including that in the next round.

I gave it a spin with the above changes, results:

https://github.com/linux-kdevops/kdevops/commit/f2641efe7d2037892e0477fdc8daf66af59c1f01
https://github.com/linux-kdevops/kdevops-results-archive/commit/c3ac880e909a30aa2f9b24231d0f7297dfdf4e8e

  Luis

