Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EDDDC04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 22:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HAYXI6GfYcA78w483eLPdrHY7Q5nvphPXMQKU3NQNtM=; b=EdbkjxbnhrhKtuG54HHHU97aja
	sqAJAqpoaYQb6t+1DaVC9AEHrrvyuEAeHKg9KK9eQFcTMC++1YLKkxso8yUiDVS9UaTK+Htr10qL9
	rYURtfQwCX+3Spcz+j2ZVy+ybP1mQyES4qxeDFXbaB3NAU+gCosynv/wmeRGmCDIVQAqXjaUVFAi5
	gIfZtZdOn8ZCS+0nZ3utajNOekcycWnd4dpvSFa7MsNJHPbKv0vwVgHUR0SQ5s/d8G2g0nMdcYYiG
	bHIXXquG0HYzhGiiSVqAAKCpba3xiusN8owhqFGyHO+1psCly3F4QOwXD/X2ZyWklZe01ggee57U1
	Ybq8lLCA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGpaB-0012LI-5b; Wed, 27 Jul 2022 22:32:47 +0000
Received: from mail104.syd.optusnet.com.au ([211.29.132.246])
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGpa8-0012He-5c
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 22:32:45 +0000
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
	by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 0562262CC03;
	Thu, 28 Jul 2022 08:32:34 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1oGpZw-0065Ed-SD; Thu, 28 Jul 2022 08:32:32 +1000
Date: Thu, 28 Jul 2022 08:32:32 +1000
From: Dave Chinner <david@fromorbit.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <20220727223232.GV3600936@dread.disaster.area>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
 <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=OJNEYQWB c=1 sm=1 tr=0 ts=62e1bd07
	a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
	a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
	a=jTGfvSW0_HNO3Awiv3YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_153244_393506_1402B3AE 
X-CRM114-Status: GOOD (  23.50  )
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

On Wed, Jul 27, 2022 at 09:04:25AM -0600, Keith Busch wrote:
> On Wed, Jul 27, 2022 at 03:04:56PM +0100, Al Viro wrote:
> > On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> > > On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > > > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > > > 
> > > > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > > > +		bdev = I_BDEV(file->f_mapping->host);
> > > > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > > > +		bdev = file->f_inode->i_sb->s_bdev;
> > > > 
> > > > *blink*
> > > > 
> > > > Just what's the intended use of the second case here?
> > > 
> > > ??
> > > 
> > > The use case is same as the first's: dma map the user addresses to the backing
> > > storage. There's two cases here because getting the block_device for a regular
> > > filesystem file is different than a raw block device.
> > 
> > Excuse me, but "file on some filesystem + block number on underlying device"
> > makes no sense as an API...
> 
> Sorry if I'm misunderstanding your concern here.
> 
> The API is a file descriptor + index range of registered buffers (which is a
> pre-existing io_uring API). The file descriptor can come from opening either a
> raw block device (ex: /dev/nvme0n1), or any regular file on a mounted
> filesystem using nvme as a backing store.

That's fundamentally flawed. Filesystems can have multiple block
devices backing them that the VFS doesn't actually know about (e.g.
btrfs, XFS, etc). Further, some of these filesystems can spread
indiivdual file data across mutliple block devices i.e. the backing
bdev changes as file offset changes....

Filesystems might not even have a block device (NFS, CIFS, etc) -
what happens if you call this function on a file belonging to such a
filesystem?

> You don't need to know about specific block numbers. You can use the result
> with any offset in the underlying block device.

Sure, but you how exactly do you know what block device the file
offset maps to?

We have entire layers like fs/iomap or bufferheads for this - their
entire purpose in life is to efficiently manage the translation
between {file, file_offset} and {dev, dev_offset} for the purposes
of IO and data access...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

