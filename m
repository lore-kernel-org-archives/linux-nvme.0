Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBDB2C04A68
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Jul 2022 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E/xPB2mlHE49JZM6uNPImpp7PFnQSbk0nL9Ow9JoeAI=; b=F+eqhXpQ6kizOjA7Vp6yRy6GdN
	84LHVPxorecoySCtFBsHrfzqxgSBey06/4DYr5arC24e/I4776n8wyOMkv2IEseKBwjJw8E7FeIx2
	r01FT0M8xbpkdTKIdPZoU7bSdDvpdpq0tDJEDlHi5uVG+X5a4G9zTmm9t14K+GD2RUDZXJmA+LJqd
	QioJ+S5OUCEMVK2L8jC0Tj+JhEMnz/oDq3++PLBBQCnGatxXaVvqi40qmnmDoyWnXGTwAyiFNDycY
	NcZ8JJQkve+fuqxJX4nqErSP8wVylRzg1YMQ6/XGKTDykm5av5ms3PYcGTKxqSEwtDIp4rgGgtZ1z
	F8WH+J/Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3WM-009fFM-PC; Thu, 28 Jul 2022 13:25:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oH3WJ-009fDV-Dm
	for linux-nvme@lists.infradead.org; Thu, 28 Jul 2022 13:25:45 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 14B7A61D26;
	Thu, 28 Jul 2022 13:25:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C213AC433D6;
	Thu, 28 Jul 2022 13:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1659014741;
	bh=SIh451UOcr5P1ZCc5zO+DXTL5bn6jrzBhDakMU5uaXk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=d4fyPdHKmYH+9jSIi/OFSrp+usiba4BARaXzUEdw/Vg6F51YzPcr+GlXTj4J428uW
	 Vc5AdT3NPuKTnbs+tcvGw4jKh4x1G/qNx0ZXk4D+R2fFiKD9jV6x58uUZuZw0UgDtp
	 r9Ne4++h5myKt/d2wpYAhv/ulTKK6MZrgvBF88siYvLycPng7h8vf33oTTUltOd6dT
	 fXu19t8l4X6Ngn07OLOq1EEL0ZEXlM3YVFhHkGtwo/Zzw6rjyyjWqiRImgEaZDrqxy
	 mVm1vZYYi+JjZVBGHYvIFKaSFYBNt5p6TObsbNCMRFowbSqK5EOEAJAgI2qlSDAo4v
	 6OgN3S6YuuVVw==
Date: Thu, 28 Jul 2022 07:25:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuKOUh6MJGGFuIm/@kbusch-mbp.dhcp.thefacebook.com>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
 <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
 <20220727223232.GV3600936@dread.disaster.area>
 <YuHDeRImQPuuV2Mr@kbusch-mbp.dhcp.thefacebook.com>
 <20220728023511.GX3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728023511.GX3600936@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220728_062543_639260_3EE731EF 
X-CRM114-Status: GOOD (  28.05  )
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

On Thu, Jul 28, 2022 at 12:35:11PM +1000, Dave Chinner wrote:
> On Wed, Jul 27, 2022 at 05:00:09PM -0600, Keith Busch wrote:
> > The block_device driver has to opt-in to this feature. If a multi-device block
> > driver wants to opt-in to this, then it would be responsible to handle
> > translating that driver's specific cookie to whatever representation the
> > drivers it stacks atop require. Otherwise, the cookie threaded through the bio
> > is an opque value: nothing between io_uring and the block_device driver need to
> > decode it.
> 
> I'm not talking about "multi-device" block devices like we build
> with DM or MD to present a single stacked block device to the
> filesystem. I'm talking about the fact that both btrfs and XFS
> support multiple *independent* block devices in the one filesystem.
> 
> i.e.:
> 
> # mkfs.xfs -r rtdev=/dev/nvme0n1 -l logdev=/dev/nvme1n1,size=2000m /dev/nvme2n1
> meta-data=/dev/nvme2n1           isize=512    agcount=4, agsize=22893287 blks
>          =                       sectsz=512   attr=2, projid32bit=1
>          =                       crc=1        finobt=1, sparse=1, rmapbt=0
>          =                       reflink=0    bigtime=1 inobtcount=1 nrext64=0
> data     =                       bsize=4096   blocks=91573146, imaxpct=25
>          =                       sunit=0      swidth=0 blks
> naming   =version 2              bsize=4096   ascii-ci=0, ftype=1
> log      =/dev/nvme1n1           bsize=4096   blocks=512000, version=2
>          =                       sectsz=512   sunit=0 blks, lazy-count=1
> realtime =/dev/nvme0n1           extsz=4096   blocks=91573146, rtextents=91573146
> #
> 
> This builds an XFS filesystem which can write file data to either
> /dev/nvme0n1 or /dev/nvme2n1, and journal IO will get sent to a
> third block dev (/dev/nvme1n1).
> 
> So, which block device do we map for the DMA buffers that contain
> the file data for any given file in that filesystem? There is no
> guarantee that is is sb->s_bdev, because it only points at one of
> the two block devices that can contain file data.
> 
> Btrfs is similar, but it might stripe data across /dev/nvme0n1,
> /dev/nvme1n1 and /dev/nvme2n1 for a single file writes (and hence
> reads) and so needs separate DMA mappings for each block device just
> to do IO direct to/from one file....
> 
> Indeed, for XFS there's no requirement that the block devices have
> the same capabilities or even storage types - the rtdev could be
> spinning disks, the logdev an nvme SSD, and the datadev is pmem. If
> XFs has to do something special, it queries the bdev it needs to
> operate on (e.g. DAX mappings are only allowed on pmem based
> devices).
> 
> Hence it is invalid to assume that sb->s_bdev points at the actual
> block device the data for any given regular file is stored on. It is
> also invalid to assume the characteristics of the device in
> sb->s_bdev are common for all files in the filesystem.
> 
> IOWs, the only way you can make something like this work via
> filesystem mapping infrastructure to translate file offset to
> to a {dev, dev_offset} tuple to tell you what persistently mapped
> device buffers you need to use for IO to the given file {offset,len}
> range that IO needs to be done on....

Thank you for the explanation. I understand now, sorry for my previous
misunderstanding.

I may consider just initially supporting direct raw block devices if I can't
find a viable solution quick enough.

