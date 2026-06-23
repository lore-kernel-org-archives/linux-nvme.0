Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90DFCDB46F
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jun 2026 10:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/fZOTZgTHJCoYhu4atJHL4E1aOX5/o5VZzpB0pdfWvQ=; b=jhs0C3DUyn6nPXh8g2DejDsBaw
	SuxVQ0oFhFeJuwv84FFxbtSaX96r4Plp3vzRakKpfTj1E6esVNjQIRkjhp83CN2jQ/66j7CgaDeKW
	0/5eVCmZAvY050cCpb5Sbfbx/XZAkEDA0wZ9QOCsGEdJhFo45b4XdZUSTB9AFW2GLhRf47erL+Tqg
	g1cMx78MLHvlSRUXPU6uZSJeGvIZN8Goq/yU1DiJDjLWdBC4o/DobI4rrhvR6OLejtNRSZtek372g
	4TIhzkAO8uqAUXb5G6tYZ11NTJi0daWfXs/1IFlLpMd9Nj1os6+9j0TcSJNgkeq3zbSkTzG2GNN9i
	WpyJDj2w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbySi-0000000666K-3jEB;
	Tue, 23 Jun 2026 10:34:36 +0000
Received: from smtp.missinglinkelectronics.com ([162.55.135.183])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbySg-0000000665r-1OGX
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jun 2026 10:34:35 +0000
Received: from ubuntu-server (ppp-88-217-75-1.dynamic.mnet-online.de [88.217.75.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: david)
	by smtp.missinglinkelectronics.com (Postfix) with ESMTPSA id 1B4DB203A6;
	Tue, 23 Jun 2026 12:34:31 +0200 (CEST)
Date: Tue, 23 Jun 2026 12:34:29 +0200
From: David Epping <david.epping@missinglinkelectronics.com>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Leon Romanovsky <leon@kernel.org>,
	Joachim Foerster <joachim.foerster@missinglinkelectronics.com>
Subject: Re: [PATCH RFC] nvme-ioctl: propagate PRP1 from ioctl to admin cmd
Message-ID: <ajphNQIpfIRYZg_H@ubuntu-server>
References: <ajlDjpjK_clMrnwx@ubuntu-server>
 <ajlIPlEv_zBfTMVG@kbusch-mbp>
 <ajlNFpz5977PzLvb@ubuntu-server>
 <ajlRnLI8OdaUVOZp@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ajlRnLI8OdaUVOZp@kbusch-mbp>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260623_033434_541288_144B7D8E 
X-CRM114-Status: GOOD (  25.23  )
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

On Mon, Jun 22, 2026 at 09:15:40AM -0600, Keith Busch wrote:
> On Mon, Jun 22, 2026 at 04:56:22PM +0200, David Epping wrote:
> > On Mon, Jun 22, 2026 at 08:35:42AM -0600, Keith Busch wrote:
> > > On Mon, Jun 22, 2026 at 04:15:42PM +0200, David Epping wrote:
> > > > @@ -306,6 +306,7 @@ static int nvme_user_cmd(struct nvme_ctrl *ctrl, struct nvme_ns *ns,
> > > >  	c.common.nsid = cpu_to_le32(cmd.nsid);
> > > >  	c.common.cdw2[0] = cpu_to_le32(cmd.cdw2);
> > > >  	c.common.cdw2[1] = cpu_to_le32(cmd.cdw3);
> > > > +	c.common.dptr.prp1 = cpu_to_le64(cmd.addr);
> > > 
> > > This is not correct: the user space virtual address isn't the device
> > > DMA'able address. The driver already handles mapping the user address to
> > > kernel space, then to dma, then sets the PRP accordingly.
> > 
> > To clarify, the ioctl struct addr field is not filled with a memory buffer
> > address by the userspace, but a PCIe mapped BAR address plus offset.
> > It is obtained by the userspace application operating the FPGA vfio device
> > by reading from PCI config space via VFIO_PCI_CONFIG_REGION_INDEX.
> > So it is the address Linux assigned to that BAR (plus offset).
> 
> The driver and block layer should already handle PCIe addresses. You're
> supposed to mmap it to user space first though, and pass that address in
> instead. And you'd also need to set cmd.data_len to a non-zero value so
> the driver doesn't skip setting up the data pointers.
> 
> Note, creating IO queues from user space, while not explicitly prevented
> today, is not supported. The driver doesn't know you've done this so the
> queue isn't properly handled on a controller reset.
> 

Hi Keith, I understand that creating IO queues from user space is not
supported by the current driver. That's why we created patches for that a
couple of years ago and ported them to new Kernels since.

My question is, and maybe I should have put this in my initial email
explicitely, is there interest in having such functionality in the upstream
Linux in-Kernel NVMe driver? An interface and mechanism to request and
manage IO queues that are not used by the Linux NVMe driver to perform IO,
but handed to a separate entity for this purpose.

Of course an upstream implementation would have to take many more things
into account, like the reset you mentioned, and IOMMU setup, and much more.
But that's only worth looking at if there is upstream interest in it.

Thanks for your feedback, David

