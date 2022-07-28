Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8410C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 02:35:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mAckjg+E6dMrqWkXQdRzj5mY6ksj2NPdZDAIWa7ytJc=; b=UgzGX+r/WDz0nxLnhz7BMQwIcl
	dO6eWaY+ZdxR1uJGE5PIIscBZE7O1bsciO1wb8N40Yr7/k+5wuHTEbEuGft2dyj6Cokj78gs+0tSi
	+TDH9qSS0uxUahNOa9nhs+tiCBBrDocb1fOIWMemV/TYsvYR2WIh3uiEeWzTWfCSLYDP75bYa8JhR
	UGgULj5S5gRksuIOjxav12/CQDK0kV0EkSjxC9XfWmHyYuTb661hsnVYO8Wusk1j0jMk8NOu3Vh4h
	Mae0TEhV9EE68IIIp4wlb8BZF9u0uby/LI9Lttc/xlKb3DDjQBvJhWhCkevuRlM0aYczao85S1nId
	X/YeSeqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtNK-002wd3-Ej; Thu, 28 Jul 2022 02:35:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtNJ-002waq-Ak
	for linux-nvme@bombadil.infradead.org; Thu, 28 Jul 2022 02:35:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mAckjg+E6dMrqWkXQdRzj5mY6ksj2NPdZDAIWa7ytJc=; b=p+TQRj+1YTwJZ+e2JZjC9XTd0J
	+6hC9OfLjfaK57io9yzd1xksfmE4x2eDyfYsXi2QyncUTANoIO0H8ESW/q/9BaCJrA6Dh5K2OPBZ6
	RQftdCIJQ7+UDnRMpw5vO7i2LNzpG+/HDISEhhP5dugTIRxXsGejXXIxq7nlKuGsAhnJFBxu83S7C
	5bieIBcKXgcg6EABZFGd9zmD5q6qLMPkBbM5VxgVmOswODLySXo1DIJyizHM0Dnz8rmhXG7x2bKxG
	gjAmcZozTOKRTDaFXPMBgsndnIMHmQaVby5TYupbyHvly6Mu+ZRdSRLQECiShi0fuVpTgly2JYvsi
	YhlWknxw==;
Received: from mail105.syd.optusnet.com.au ([211.29.132.249])
	by desiato.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGtN6-000uRy-Lh
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 02:35:40 +0000
Received: from dread.disaster.area (pa49-195-20-138.pa.nsw.optusnet.com.au [49.195.20.138])
	by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 25C0D10C8868;
	Thu, 28 Jul 2022 12:35:13 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
	(envelope-from <david@fromorbit.com>)
	id 1oGtMl-0069Ji-VP; Thu, 28 Jul 2022 12:35:11 +1000
Date: Thu, 28 Jul 2022 12:35:11 +1000
From: Dave Chinner <david@fromorbit.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <20220728023511.GX3600936@dread.disaster.area>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
 <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
 <20220727223232.GV3600936@dread.disaster.area>
 <YuHDeRImQPuuV2Mr@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuHDeRImQPuuV2Mr@kbusch-mbp.dhcp.thefacebook.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.4 cv=VuxAv86n c=1 sm=1 tr=0 ts=62e1f5e2
	a=cxZHBGNDieHvTKNp/pucQQ==:117 a=cxZHBGNDieHvTKNp/pucQQ==:17
	a=kj9zAlcOel0A:10 a=RgO8CyIxsXoA:10 a=7-415B0cAAAA:8
	a=DxEnDgycP0rwEceSJA4A:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_033536_432183_D7090314 
X-CRM114-Status: GOOD (  33.52  )
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

On Wed, Jul 27, 2022 at 05:00:09PM -0600, Keith Busch wrote:
> On Thu, Jul 28, 2022 at 08:32:32AM +1000, Dave Chinner wrote:
> > On Wed, Jul 27, 2022 at 09:04:25AM -0600, Keith Busch wrote:
> > > On Wed, Jul 27, 2022 at 03:04:56PM +0100, Al Viro wrote:
> > > > On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> > > > > On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > > > > > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > > > > > 
> > > > > > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > > > > > +		bdev = I_BDEV(file->f_mapping->host);
> > > > > > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > > > > > +		bdev = file->f_inode->i_sb->s_bdev;
> > > > > > 
> > > > > > *blink*
> > > > > > 
> > > > > > Just what's the intended use of the second case here?
> > > > > 
> > > > > ??
> > > > > 
> > > > > The use case is same as the first's: dma map the user addresses to the backing
> > > > > storage. There's two cases here because getting the block_device for a regular
> > > > > filesystem file is different than a raw block device.
> > > > 
> > > > Excuse me, but "file on some filesystem + block number on underlying device"
> > > > makes no sense as an API...
> > > 
> > > Sorry if I'm misunderstanding your concern here.
> > > 
> > > The API is a file descriptor + index range of registered buffers (which is a
> > > pre-existing io_uring API). The file descriptor can come from opening either a
> > > raw block device (ex: /dev/nvme0n1), or any regular file on a mounted
> > > filesystem using nvme as a backing store.
> > 
> > That's fundamentally flawed. Filesystems can have multiple block
> > devices backing them that the VFS doesn't actually know about (e.g.
> > btrfs, XFS, etc). Further, some of these filesystems can spread
> > indiivdual file data across mutliple block devices i.e. the backing
> > bdev changes as file offset changes....
> > 
> > Filesystems might not even have a block device (NFS, CIFS, etc) -
> > what happens if you call this function on a file belonging to such a
> > filesystem?
> 
> The block_device driver has to opt-in to this feature. If a multi-device block
> driver wants to opt-in to this, then it would be responsible to handle
> translating that driver's specific cookie to whatever representation the
> drivers it stacks atop require. Otherwise, the cookie threaded through the bio
> is an opque value: nothing between io_uring and the block_device driver need to
> decode it.

I'm not talking about "multi-device" block devices like we build
with DM or MD to present a single stacked block device to the
filesystem. I'm talking about the fact that both btrfs and XFS
support multiple *independent* block devices in the one filesystem.

i.e.:

# mkfs.xfs -r rtdev=/dev/nvme0n1 -l logdev=/dev/nvme1n1,size=2000m /dev/nvme2n1
meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=22893287 blks
         =                       sectsz=512   attr=2, projid32bit=1
         =                       crc=1        finobt=1, sparse=1, rmapbt=0
         =                       reflink=0    bigtime=1 inobtcount=1 nrext64=0
data     =                       bsize=4096   blocks=91573146, imaxpct=25
         =                       sunit=0      swidth=0 blks
naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
log      =/dev/nvme1n1           bsize=4096   blocks=512000, version=2
         =                       sectsz=512   sunit=0 blks, lazy-count=1
realtime =/dev/nvme0n1           extsz=4096   blocks=91573146, rtextents=91573146
#

This builds an XFS filesystem which can write file data to either
/dev/nvme0n1 or /dev/nvme2n1, and journal IO will get sent to a
third block dev (/dev/nvme1n1).

So, which block device do we map for the DMA buffers that contain
the file data for any given file in that filesystem? There is no
guarantee that is is sb->s_bdev, because it only points at one of
the two block devices that can contain file data.

Btrfs is similar, but it might stripe data across /dev/nvme0n1,
/dev/nvme1n1 and /dev/nvme2n1 for a single file writes (and hence
reads) and so needs separate DMA mappings for each block device just
to do IO direct to/from one file....

Indeed, for XFS there's no requirement that the block devices have
the same capabilities or even storage types - the rtdev could be
spinning disks, the logdev an nvme SSD, and the datadev is pmem. If
XFs has to do something special, it queries the bdev it needs to
operate on (e.g. DAX mappings are only allowed on pmem based
devices).

Hence it is invalid to assume that sb->s_bdev points at the actual
block device the data for any given regular file is stored on. It is
also invalid to assume the characteristics of the device in
sb->s_bdev are common for all files in the filesystem.

IOWs, the only way you can make something like this work via
filesystem mapping infrastructure to translate file offset to
to a {dev, dev_offset} tuple to tell you what persistently mapped
device buffers you need to use for IO to the given file {offset,len}
range that IO needs to be done on....

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com

