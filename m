Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C63C25B10
	for <linux-nvme@archiver.kernel.org>; Sat, 11 May 2024 00:29:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DJAmC6X+ki/esVxsFu4o4VfWy+PbSYfqoU9JXEww8yk=; b=me3qu35OtOq1DJ2mziilgQeNGk
	l48DMKaxzNIS8ZjuE3f3HTd9VYIMHyb3CRADjsqECO0YTeBNScNumjXRK0USCxgcphgkudRIA6xxJ
	gy8LDAnCb4eO8KIDEoNt9QD5XH72qIWA05gGSxNyeFcfuF/AdHms8hA6BdcsmvnSmzX7eCujVoA3B
	QAw+4rzEbF9hiuDYpBepXe6AlY0FJjgbM+b0rUI+iGnLuw41vsMF4x0CBWllPGe41R2zqG3l6nNyV
	g3fAxBL3Rrsze0JgbZU2oqV+5FUK+sRNzo0dnOu/FTUEmk8Hfm4dxGiV7nTsgHlTgPrwgkSpv9mOu
	G3vqT4nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5acI-00000006tpW-389f;
	Sat, 11 May 2024 00:29:34 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5acF-00000006tod-0Qz8
	for linux-nvme@lists.infradead.org;
	Sat, 11 May 2024 00:29:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id A5240CE1EB2;
	Sat, 11 May 2024 00:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94130C113CC;
	Sat, 11 May 2024 00:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715387365;
	bh=bdRi+6matqRZbi/xJQZwe4Ya7aYEDYxEQeziyhSYZRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UMmTwToIHlonxZ/TKLyB+sF6vmFl3o+TW9mVg99JL+gyK5YP/Jrkus0xPKcnh+NZk
	 IJ7usPoPWnuLuQfuculUVXvmUHasGtC/kh6eIn9yVa8q8MloLOUwIQnsX/yV3pgvxO
	 7jd1DFvzVwy1YT3D/URy5f9sGHH6c6vLHRkND9G5YUFuesu8lx7u6rnfACzTbzCpDO
	 QaWGiufc/4S8iJ6z3j6MC345saGahDNGm4DrKu9IKvAcCUUd4LMsKV8UpXedEpPmV1
	 wxeigYXbGMXnm5YVdwPWY8MtzBmWynRq/+nCvMCEFPNdMAhmcE2H7n5nfnUzc1yTk8
	 ygTlZ3oB4r2vg==
Date: Fri, 10 May 2024 18:29:23 -0600
From: Keith Busch <kbusch@kernel.org>
To: Ming Lei <ming.lei@redhat.com>
Cc: Keith Busch <kbusch@meta.com>, linux-nvme@lists.infradead.org,
	hch@lst.de
Subject: Re: [PATCHv2] nvme-pci: allow unmanaged interrupts
Message-ID: <Zj6745UDnwX1BteO@kbusch-mbp.dhcp.thefacebook.com>
References: <20240510174645.3987951-1-kbusch@meta.com>
 <Zj6yDtRzl68zspQY@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zj6yDtRzl68zspQY@fedora>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_172931_346730_F97725D2 
X-CRM114-Status: GOOD (  13.29  )
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

On Sat, May 11, 2024 at 07:47:26AM +0800, Ming Lei wrote:
> On Fri, May 10, 2024 at 10:46:45AM -0700, Keith Busch wrote:
> >  		map->queue_offset = qoff;
> > -		if (i != HCTX_TYPE_POLL && offset)
> > +		if (managed_irqs && i != HCTX_TYPE_POLL && offset)
> >  			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
> >  		else
> >  			blk_mq_map_queues(map);
> 
> Now the queue mapping is built with nothing from irq affinity which is
> setup from userspace, and performance could be pretty bad.

This just decouples the sw from the irq mappings. Every cpu still has a
blk-mq hctx, there's just no connection to the completing CPU if you
enable this.

Everyone expects nvme performance will suffer. IO latency and CPU
efficieny are not everyone's top priority, so allowing people to
optimize for something else seems like a reasonable request.
 
> Is there any benefit to use unmanaged irq in this way?

The immediate desire is more predictable scheduling on a subset of CPUs
by steering hardware interrupts somewhere else. It's the same reason
RDMA undid managed interrupts.

  231243c82793428 ("Revert "mlx5: move affinity hints assignments to generic code")

Yes, the kernel's managed interrupts are the best choice for optimizing
interaction with that device, but it's not free, and maybe you want to
exchange that optimization for something else.

