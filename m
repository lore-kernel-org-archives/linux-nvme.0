Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A22BBCDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 15:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q/qXqqPm/uQ1Cz4K1A6ud21RqtjKXaSkYKAScSM016Y=; b=dcGBLW7YmZOUnFQmYuM2ZcO13Z
	IOIxJ3VIrPrIeZJ357mCH3fN1v3BNl+NP03WE873NVpOIxDZigvQrulXarv/hdQDi7dkuXfBEU4Ng
	4GC6D711BCTRQ74+Fw+xMetY2MHvz71I5oyf+zdbDDLwf4qoow3Fl9JhWHKmSxPRr4lPi/Gq8jvOc
	pMLbZ8I8udoJbJXxSSrvQhGNCchUfsb3i9BMxVyD0jRbegxy1X6PSMcbOLuuN+wRdSHfAK7uLBAb3
	XMXWY7/TDPy1f5kpVIENGnBVoAMwQKmI7qbppuk+IhGcDcuC1trDhGe/0mk49RCQOqIo6rwAjeZ8+
	a0HGtJ4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbgND-000000057h9-35nv;
	Mon, 22 Jun 2026 15:15:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbgNC-000000057h3-1zpx
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 15:15:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id EA36343688;
	Mon, 22 Jun 2026 15:15:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C41F1F000E9;
	Mon, 22 Jun 2026 15:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782141341;
	bh=q/qXqqPm/uQ1Cz4K1A6ud21RqtjKXaSkYKAScSM016Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ug8mhIPznn3c2WKQsIwVC+GsUowVVqbcbUfTMTOsg5vfEYXqBwSBLRDHL0F/qbCW3
	 rkv1WiKjaORv7TwbqVmFKs55hX+TRWQoe2EyJBYZhRoEvAZwrC51A/xdkpelpca04V
	 /9SvwjHb/IM6j84IsSCVRjftPCHw8agp9xxV3vtEvn9NPP1O6Dl9pOI3keE4koFcjX
	 jknazLc5KYxJNl7fUsB6x8JgI0BtHcZIxCkMryRwWSLe3kek93sHGDRNyOwMNxMmms
	 OXtKKD0fQmv/en78Wd4KK6dDqjC/Z7f0hnXsZDYoZC56L+FjGEFRagxt8lykFu9Q8P
	 XOW1iK4fCS03w==
Date: Mon, 22 Jun 2026 09:15:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: David Epping <david.epping@missinglinkelectronics.com>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajlRnLI8OdaUVOZp@kbusch-mbp>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlNFpz5977PzLvb@ubuntu-server>
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

On Mon, Jun 22, 2026 at 04:56:22PM +0200, David Epping wrote:
> On Mon, Jun 22, 2026 at 08:35:42AM -0600, Keith Busch wrote:
> > On Mon, Jun 22, 2026 at 04:15:42PM +0200, David Epping wrote:
> > > @@ -306,6 +306,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > >  	c.common.nsid = cpu_to_le32(cmd.nsid);
> > >  	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
> > >  	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
> > > +	c.common.dptr.prp1 = cpu_to_le64(cmd.addr);
> > 
> > This is not correct: the user space virtual address isn't the device
> > DMA'able address. The driver already handles mapping the user address to
> > kernel space, then to dma, then sets the PRP accordingly.
> 
> To clarify, the ioctl struct addr field is not filled with a memory buffer
> address by the userspace, but a PCIe mapped BAR address plus offset.
> It is obtained by the userspace application operating the FPGA vfio device
> by reading from PCI config space via VFIO_PCI_CONFIG_REGION_INDEX.
> So it is the address Linux assigned to that BAR (plus offset).

The driver and block layer should already handle PCIe addresses. You're
supposed to mmap it to user space first though, and pass that address in
instead. And you'd also need to set cmd.data_len to a non-zero value so
the driver doesn't skip setting up the data pointers.

Note, creating IO queues from user space, while not explicitly prevented
today, is not supported. The driver doesn't know you've done this so the
queue isn't properly handled on a controller reset.

