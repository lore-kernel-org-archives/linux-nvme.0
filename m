Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F348E7717F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 16:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DzzV61XwastlTTMvvo2MQirkjlXA1mkmbx6BJJgKAtU=; b=0dKtuxRhjm82y6nks8fRZ8FHH9
	rBIx7q/CK8F/FXoXTyFQj+RNVnFVruQmK7CIA3z8ZVGFKwh6fPx1kO2Y/gzux81Rx7n8qGKS6CHvo
	ms1LVjMup7xrxuM1NgVRYennSBiEtipGK5uy6f2qZIUGAFOgmD0XgIRNST/bU4PJ5BmCc6nE0iy6o
	dPaeu4Gh6bnpIPUjIieeb6ZjG70G5AI/ootso3Gx/o8HFV+2CHAiWS14DIHk9T8CtSxTOW0VJnZLE
	d6p1DUev+UAC9LzVfFn348lbjUP8gFo0Mx25tcFnq9qpyz7PGr4g/O38G50s7UmEavzcbm5+jm+Fi
	lZHwAeBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNE5D-0000000Acds-2mpa;
	Mon, 16 Dec 2024 16:36:35 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNE4T-0000000AcUD-49oj
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 16:35:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id CE24FA4189C;
	Mon, 16 Dec 2024 16:33:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1ACC4CED0;
	Mon, 16 Dec 2024 16:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734366948;
	bh=3iPcEokKl82QATys2srvtgnVQ5QzbIcdVKpEDugtwig=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEW+Y9+sQ5098kCykYnXiLOe2KDPYltyUC0lwNaCTjZN5DVDEkdz0kwpD9Jz7lOXK
	 7ChbYBvtZ5ihCZnl5W1bGI5EAdi87AbxVLQ576FWnHdGKGCIVmA63uLmdJm3laYXpM
	 oNkiXxSv8BTKtUKkUKcKPJfx/LoQ4fjjL0n8AQiB/XK3Odj4o/isMZJhQP7eq5fl9i
	 T9nm7jQDuEDaygqccErIx0sg6sDOQJ8b+zDPuxHmdXwSuCcSw/UboMVgyCrAfikUZB
	 UPJrccNonuV7AH+V6BCGZsmFDghCt5NpIa39eC6pNF0gEpwncs2RceIqISRpz9ssmB
	 xgGSmSjObj05w==
Date: Mon, 16 Dec 2024 22:05:44 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v4 17/18] nvmet: New NVMe PCI endpoint target driver
Message-ID: <Z2BW4CjdE1p50AhC@vaman>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
 <Z1xoAj9c9oWhqZoV@ryzen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1xoAj9c9oWhqZoV@ryzen>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_083550_159363_96E7E2EA 
X-CRM114-Status: GOOD (  36.99  )
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

Hi Niklas,

On 13-12-24, 17:59, Niklas Cassel wrote:
> Hello Vinod,
> 
> I am a bit confused about the usage of the dmaengine API, and I hope that you
> could help make me slightly less confused :)

Sure thing!

> If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
> mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
> dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.
> 
> I really wish that we would remove this mutex, to get better performance.
> 
> 
> If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
> that dmaengine_prep_slave_single() (which will call
> device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
> dma_async_tx_descriptor for each function call.
> 
> I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
> call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
> the descriptor to the tail of a list.
> 
> I can also see that dw_edma_done_interrupt() will automatically start the
> transfer of the next descriptor (using vchan_next_desc()).
> 
> So this looks like it is supposed to be asynchronous... however, if we simply
> remove the mutex, we get IOMMU errors, most likely because the DMA writes to
> an incorrect address.
> 
> It looks like this is because dmaengine_prep_slave_single() really requires
> dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
> in the sconf that we are supplying to dmaengine_slave_config().)
> 
> (i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)
> 
> So while this API is supposed to be async, to me it looks like it can only
> be used in a synchronous manner... But that seems like a really weird design.
> 
> Am I missing something obvious here?

Yes, I feel nvme being treated as slave transfer, which it might not be.
This API was designed for peripherals like i2c/spi etc where we have a
hardware address to read/write to. So the dma_slave_config would pass on
the transfer details for the peripheral like address, width of fifo,
depth etc and these are setup config, so call once for a channel and then
prepare the descriptor, submit... and repeat of prepare and submit ...

I suspect since you are passing an address which keep changing in the
dma_slave_config, you need to guard that and prep_slave_single() call,
as while preparing the descriptor driver would lookup what was setup for
the configuration.

I suggest then use the prep_memcpy() API instead and pass on source and
destination, no need to lock the calls...

> If the dmaengine_prep_slave_single() instead took a sconfig as a parameter,
> then it seems like it would be possible to use this API asynchronously.
> 
> There does seem to be other drivers holding a mutex around
> dmaengine_slave_config() + dmaengine_prep_slave_single()... but it feels like
> this should be avoidable (at least for dw-edma), if
> dmaengine_prep_slave_single() simply took an sconf.
> 
> What am I missing? :)
> 
> 
> Kind regards,
> Niklas
> 
> 
> On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> > +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> > +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> > +{
> > +	struct pci_epf *epf = nvme_epf->epf;
> > +	struct dma_async_tx_descriptor *desc;
> > +	struct dma_slave_config sconf = {};
> > +	struct device *dev = &epf->dev;
> > +	struct device *dma_dev;
> > +	struct dma_chan *chan;
> > +	dma_cookie_t cookie;
> > +	dma_addr_t dma_addr;
> > +	struct mutex *lock;
> > +	int ret;
> > +
> > +	switch (dir) {
> > +	case DMA_FROM_DEVICE:
> > +		lock = &nvme_epf->dma_rx_lock;
> > +		chan = nvme_epf->dma_rx_chan;
> > +		sconf.direction = DMA_DEV_TO_MEM;
> > +		sconf.src_addr = seg->pci_addr;
> > +		break;
> > +	case DMA_TO_DEVICE:
> > +		lock = &nvme_epf->dma_tx_lock;
> > +		chan = nvme_epf->dma_tx_chan;
> > +		sconf.direction = DMA_MEM_TO_DEV;
> > +		sconf.dst_addr = seg->pci_addr;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	mutex_lock(lock);
> > +
> > +	dma_dev = dmaengine_get_dma_device(chan);
> > +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> > +	ret = dma_mapping_error(dma_dev, dma_addr);
> > +	if (ret)
> > +		goto unlock;
> > +
> > +	ret = dmaengine_slave_config(chan, &sconf);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to configure DMA channel\n");
> > +		goto unmap;
> > +	}
> > +
> > +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> > +					   sconf.direction, DMA_CTRL_ACK);
> > +	if (!desc) {
> > +		dev_err(dev, "Failed to prepare DMA\n");
> > +		ret = -EIO;
> > +		goto unmap;
> > +	}
> > +
> > +	cookie = dmaengine_submit(desc);
> > +	ret = dma_submit_error(cookie);
> > +	if (ret) {
> > +		dev_err(dev, "DMA submit failed %d\n", ret);
> > +		goto unmap;
> > +	}
> > +
> > +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> > +		dev_err(dev, "DMA transfer failed\n");
> > +		ret = -EIO;
> > +	}
> > +
> > +	dmaengine_terminate_sync(chan);
> > +
> > +unmap:
> > +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> > +
> > +unlock:
> > +	mutex_unlock(lock);
> > +
> > +	return ret;
> > +}

-- 
~Vinod

