Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67B82E7717F
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Dec 2024 16:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsJ5qvTQQC13ElY8OsMlGIHZ2r0i5zCUJ1z1COjgGFo=; b=N9rv+9Wm2sn/F9GPowYVNk7iDu
	gWGGokydMdhh3rJQaIj6p/iuxPUxcGvbeACR/Xa5tr4xrn0fdLYtfN31SEvR9sJInQJTR+Rt4gwrF
	DqB31M9FrdZKpsTogoyaDSlhgI9Y+sV8bMLk03gGAbuN/CtsKq2ErU5xW/xL97yAQ522EEvEqpe/K
	sNdAB8Ch7q2WspUmbLL9WHrvesg+z5yy6A/Hp4a83NY9t/EI6facGNDAer5tjRciViGHQNdhyecuK
	lgauo5U4Z2PeZFPj18OTUMrD/UrQh8mKDm5Z7Ir5YabHHDangLIOX45BfG081yZ10CCBbO4B60mEF
	QW6Jcg9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNaWU-0000000ECR8-0uGw;
	Tue, 17 Dec 2024 16:34:14 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNZzJ-0000000E3rR-2Yrz
	for linux-nvme@lists.infradead.org;
	Tue, 17 Dec 2024 15:59:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D36C2A40E68;
	Tue, 17 Dec 2024 15:58:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82389C4CED3;
	Tue, 17 Dec 2024 15:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451196;
	bh=nUX3IOEY4L2Iqp2QUUWu5H20jVTxoMFhA3GkwcXLnhg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WHzmDWaM2j/ZV9zsCUxKZLD6mjf0yTBhZWcYb80Lue8StkqOjHZYpyABFXE0Vxvck
	 AgCYHlzQB6XheRvb4ihjf7JYc4o3atvFmfGut2n/9SgAO5Mmheo+8RoUkMqYJuNs/F
	 WwN2GC1QPW0KkXP1jA+UvnQeK638/vHZlzWJvlSRVvhaW4ZrrgIhzIjSw2ITVKCF4P
	 Uvc1OaKJp71bl6z/t/S7FljJTTOxF/eiDxki+wIWZ4t5yBNBoFrK02GUQE8/4EXugD
	 Yr+Odgoj8bklqWJu6BS9L47P0ZyfACSe781efgERbFDA+GTV74Q/IK/N2xQKKHSjEZ
	 VebpBwAUngNPg==
Date: Tue, 17 Dec 2024 16:59:50 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2Gf9lv6hLROjM8e@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
 <Z2BW4CjdE1p50AhC@vaman>
 <4d20c4f6-3c89-4287-aa0c-326ff9997904@kernel.org>
 <Z2ELpuC+ltp5wDay@vaman>
 <20241217062144.g7jjnkziuen3qsm6@thinkpad>
 <20241217090129.6dodrgi4tn7l3cod@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241217090129.6dodrgi4tn7l3cod@thinkpad>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241217_075957_775659_5A36D7B4 
X-CRM114-Status: GOOD (  50.42  )
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

On Tue, Dec 17, 2024 at 02:31:29PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Dec 17, 2024 at 11:51:44AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Dec 17, 2024 at 10:57:02AM +0530, Vinod Koul wrote:
> > > On 16-12-24, 11:12, Damien Le Moal wrote:
> > > > On 2024/12/16 8:35, Vinod Koul wrote:
> > > > > Hi Niklas,
> > > > > 
> > > > > On 13-12-24, 17:59, Niklas Cassel wrote:
> > > > >> Hello Vinod,
> > > > >>
> > > > >> I am a bit confused about the usage of the dmaengine API, and I hope that you
> > > > >> could help make me slightly less confused :)
> > > > > 
> > > > > Sure thing!
> > > > > 
> > > > >> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> > > > >> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> > > > >> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> > > > >>
> > > > >> I really wish that we would remove this mutex, to get better performance.
> > > > >>
> > > > >>
> > > > >> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> > > > >> that dmaengine_prep_slave_single() (which will call
> > > > >> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> > > > >> dma_async_tx_descriptor for each function call.
> > > > >>
> > > > >> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> > > > >> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> > > > >> the descriptor to the tail of a list.
> > > > >>
> > > > >> I can also see that dw_edma_done_interrupt() will automatically start the
> > > > >> transfer of the next descriptor (using vchan_next_desc()).
> > > > >>
> > > > >> So this looks like it is supposed to be asynchronous... however, if we simply
> > > > >> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> > > > >> an incorrect address.
> > > > >>
> > > > >> It looks like this is because dmaengine_prep_slave_single() really requires
> > > > >> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> > > > >> in the sconf that we are supplying to dmaengine_slave_config().)
> > > > >>
> > > > >> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> > > > >>
> > > > >> So while this API is supposed to be async, to me it looks like it can only
> > > > >> be used in a synchronous manner... But that seems like a really weird design.
> > > > >>
> > > > >> Am I missing something obvious here?
> > > > > 
> > > > > Yes, I feel nvme being treated as slave transfer, which it might not be.
> > > > > This API was designed for peripherals like i2c/spi etc where we have a
> > > > > hardware address to read/write to. So the dma_slave_config would pass on
> > > > > the transfer details for the peripheral like address, width of fifo,
> > > > > depth etc and these are setup config, so call once for a channel and then
> > > > > prepare the descriptor, submit... and repeat of prepare and submit ...
> > > > > 
> > > > > I suspect since you are passing an address which keep changing in the
> > > > > dma_slave_config, you need to guard that and prep_slave_single() call,
> > > > > as while preparing the descriptor driver would lookup what was setup for
> > > > > the configuration.
> > > > > 
> > > > > I suggest then use the prep_memcpy() API instead and pass on source and
> > > > > destination, no need to lock the calls...
> > > > 
> > > > Vinod,
> > > > 
> > > > Thank you for the information. However, I think we can use this only if the DMA
> > > > controller driver implements the device_prep_dma_memcpy operation, no ?
> > > > In our case, the DWC EDMA driver does not seem to implement this.
> > > 
> > > It should be added in that case.
> > > 
> > > Before that, the bigger question is, should nvme be slave transfer or
> > > memcpy.. Was driver support the reason why the slave transfer was used here...?
> > > 
> > > As i said, slave is for peripherals which have a static fifo to
> > > send/receive data from, nvme sounds like a memory transfer to me, is
> > > that a right assumption?
> > > 
> > 
> > My understanding is that DMA_MEMCPY is for local DDR transfer i.e., src and dst
> > are local addresses. And DMA_SLAVE is for transfer between remote and local
> > addresses. I haven't looked into the NVMe EPF driver yet, but it should do
> > the transfer between remote and local addresses. This is similar to MHI EPF
> > driver as well.
> > 
> 
> I had an offline discussion with Vinod and he clarified that the DMA_SLAVE
> implementation is supposed to be used by clients with fixed FIFO. That's why
> 'struct dma_slave_config' has options to configure maxburst, addr_width,
> port_window_size etc... So these are not applicable for our usecase where we
> would be just carrying out transfer between remote and local DDR.
> 
> So we should be implementing prep_memcpy() in dw-edma driver and use DMA_MEMCPY
> in client drivers.
> 
> @Niklas: Since you asked this question, are you volunteering to implement
> prep_memcpy() in dw-edma driver? ;)

I did implement something that seems to be working.

It would be nice if you could help testing it using your MHI EPF driver.
(You need to convert it to use _prep_memcpy() in order to be able to test.)


Kind regards,
Niklas

