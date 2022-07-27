Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AD63C04A68
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Jul 2022 23:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g1Xkr1NCCL9IoCOUj+6KUAUpDos7uBabk7N4so2q2ls=; b=qzt69KAm5mhGT4FOohaMW+Xg7x
	Y7wFrpWM5uFzzbKxauS+MbHeRAl9FoxsMuPcThZqHwMiTUY1/nUZUxEsNH3w9C6c99ei/OCY4izW7
	hR1Pd6IvpPeliG1aQFr6ho6KQzEmwH1MAFISRykkw/SBl8G97WcIqHHuuq9ZMv1CiFPwlEVYmCESV
	0o2zvJwSlgFi8Rnd2ukM73PVuYYbS1xUCtyhVoTT3fryHI/DBmfsZj2Icm00XPWIZduetdjstbRF2
	Bxsgi70LU7nE23OI9corpzHJ0NlhrjljZpmexrcrWNDQQne5f3N0QhyqGTPp2Gq2QpGcRbmkGxEk2
	4vzeggGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGq0o-001FlC-9X; Wed, 27 Jul 2022 23:00:18 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oGq0l-001Fid-TL
	for linux-nvme@lists.infradead.org; Wed, 27 Jul 2022 23:00:17 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 4639BB821B6;
	Wed, 27 Jul 2022 23:00:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43851C433C1;
	Wed, 27 Jul 2022 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1658962813;
	bh=veOAnZxvbOBddmDqvdKGF+NNLNl9hODsSly+sqndRGU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OSgcGmrf5akuzXrwbRYiJXLWazzuUN1l6feWZdmAyRxR0iKaikoaJ+2bCuDcevafF
	 TpvVPiOyKX+aopVz26vJJFMDc2lbTtC9dcllju50CnnUDYzI3n/o5t8FAEhZ/3o9c2
	 DHC9ZNdYuY7noqXNgPLL+7r4k+vaAMH7q363aqGrVe8m/PBYafExN4+pHk/5Zm8QPR
	 giHc0GP83YefYg+niewL0v1TT+MRQVhkX1OmcHkqQnpUMvcTPHb+LDQ6DOrgtuLHsb
	 lHtRk/zOarXCIsqPvUaf/hBH8zMzWzpJCxPBLN1kz71C2voFgivlNsmMUkWYNkNCRy
	 wF/uGo04iDjKQ==
Date: Wed, 27 Jul 2022 17:00:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Keith Busch <kbusch@fb.com>,
	linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	io-uring@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	axboe@kernel.dk, hch@lst.de
Subject: Re: [PATCH 4/5] io_uring: add support for dma pre-mapping
Message-ID: <YuHDeRImQPuuV2Mr@kbusch-mbp.dhcp.thefacebook.com>
References: <20220726173814.2264573-1-kbusch@fb.com>
 <20220726173814.2264573-5-kbusch@fb.com>
 <YuB09cZh7rmd260c@ZenIV>
 <YuFEhQuFtyWcw7rL@kbusch-mbp.dhcp.thefacebook.com>
 <YuFGCO7M29fr3bVB@ZenIV>
 <YuFT+UYxd2QtDPe5@kbusch-mbp.dhcp.thefacebook.com>
 <20220727223232.GV3600936@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220727223232.GV3600936@dread.disaster.area>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220727_160016_269889_AEB6796F 
X-CRM114-Status: GOOD (  26.50  )
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

On Thu, Jul 28, 2022 at 08:32:32AM +1000, Dave Chinner wrote:
> On Wed, Jul 27, 2022 at 09:04:25AM -0600, Keith Busch wrote:
> > On Wed, Jul 27, 2022 at 03:04:56PM +0100, Al Viro wrote:
> > > On Wed, Jul 27, 2022 at 07:58:29AM -0600, Keith Busch wrote:
> > > > On Wed, Jul 27, 2022 at 12:12:53AM +0100, Al Viro wrote:
> > > > > On Tue, Jul 26, 2022 at 10:38:13AM -0700, Keith Busch wrote:
> > > > > 
> > > > > > +	if (S_ISBLK(file_inode(file)->i_mode))
> > > > > > +		bdev = I_BDEV(file->f_mapping->host);
> > > > > > +	else if (S_ISREG(file_inode(file)->i_mode))
> > > > > > +		bdev = file->f_inode->i_sb->s_bdev;
> > > > > 
> > > > > *blink*
> > > > > 
> > > > > Just what's the intended use of the second case here?
> > > > 
> > > > ??
> > > > 
> > > > The use case is same as the first's: dma map the user addresses to the backing
> > > > storage. There's two cases here because getting the block_device for a regular
> > > > filesystem file is different than a raw block device.
> > > 
> > > Excuse me, but "file on some filesystem + block number on underlying device"
> > > makes no sense as an API...
> > 
> > Sorry if I'm misunderstanding your concern here.
> > 
> > The API is a file descriptor + index range of registered buffers (which is a
> > pre-existing io_uring API). The file descriptor can come from opening either a
> > raw block device (ex: /dev/nvme0n1), or any regular file on a mounted
> > filesystem using nvme as a backing store.
> 
> That's fundamentally flawed. Filesystems can have multiple block
> devices backing them that the VFS doesn't actually know about (e.g.
> btrfs, XFS, etc). Further, some of these filesystems can spread
> indiivdual file data across mutliple block devices i.e. the backing
> bdev changes as file offset changes....
> 
> Filesystems might not even have a block device (NFS, CIFS, etc) -
> what happens if you call this function on a file belonging to such a
> filesystem?

The block_device driver has to opt-in to this feature. If a multi-device block
driver wants to opt-in to this, then it would be responsible to handle
translating that driver's specific cookie to whatever representation the
drivers it stacks atop require. Otherwise, the cookie threaded through the bio
is an opque value: nothing between io_uring and the block_device driver need to
decode it.

If the block_device doesn't support providing this cookie, then io_uring just
falls back to the existing less optimal methond, and all will continue to work
as it does today.

