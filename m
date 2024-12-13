Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54785E7717F
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Dec 2024 17:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ObDH0B7fGrgPBv3+kjL1RQC+oy+sKjpm2EdcBUb09aw=; b=C37Il83j5xgarK7te8c467nq/S
	yruSucI0k/D+nENZy+0s+uMosRltLJ/DYQs/2sB2jisMmC/evCebS8++ZUJ2D7Vl2X2Y7WUaJcJQX
	Uf/nypAF0J3DaZ2/wsfpLXRVK6MxZ01Dxh1aGlx42NYP7V3tBaVSC2QckpV/MFlTSVKfeHC3GeqTs
	YOCaREc17qxe0On8RJJLs2yw93go85nTwPCHGR99wVyYF6G2cREBpXgA4V5IvMnrVt2OoILgWFpO2
	G7pkhhektbb6qpYMrYuFiQJ7Hw995lVZImiAUwzkpGC8xEFHksBSnbMB97tFtZwzpLSOUDyUPK30R
	fDMbhL9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tM91A-00000004VM4-2APM;
	Fri, 13 Dec 2024 16:59:56 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tM918-00000004VLh-0OnM
	for linux-nvme@lists.infradead.org;
	Fri, 13 Dec 2024 16:59:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BD88E5C6C85;
	Fri, 13 Dec 2024 16:59:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E16C4CED0;
	Fri, 13 Dec 2024 16:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734109192;
	bh=EgRgareuCzSN3yzJcQ10JMjJTrJnUNwakzXNQVNF43I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tkp+YNm+kwF8Hd//xHdCKjVA3d9b/puF8XL+KCbeDSp+jy6VcPaCCvlLU7WyeTlC+
	 RuiCnZcqZ+onoL4+wgTvJFwSn/1hEIkk89gP8Ls1RZP/gsUQVLBI7eemhRf+fwoXkA
	 3lvU1E/j4d/TULv8+VySY9b8+6ofNM2826F5Rwzj1YIdVSR/HqSduA2fTDdM/SS2aB
	 oqYzJ0Wq8YyBYdDs5yq4sq+2vT7o3l9MsA8y9Mb6stWd+T3f/8ccjVDTRlvFgl9Mwf
	 zLibm5w19vJ4J8Z7kewHQDELn17E7vI+P+4yhuX/5v29WrjEfrZFCWZs4VYCRPMpb2
	 lmlH9l205pFPA==
Date: Fri, 13 Dec 2024 17:59:46 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
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
Message-ID: <Z1xoAj9c9oWhqZoV@ryzen>
References: <20241212113440.352958-1-dlemoal@kernel.org>
 <20241212113440.352958-18-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241212113440.352958-18-dlemoal@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241213_085954_217285_85441AEE 
X-CRM114-Status: GOOD (  23.21  )
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

Hello Vinod,

I am a bit confused about the usage of the dmaengine API, and I hope that you
could help make me slightly less confused :)

If you look at the nvmet_pciep_epf_dma_transfer() function below, it takes a
mutex around the dmaengine_slave_config(), dmaengine_prep_slave_single(),
dmaengine_submit(), dma_sync_wait(), and dmaengine_terminate_sync() calls.

I really wish that we would remove this mutex, to get better performance.


If I look at e.g. the drivers/dma/dw-edma/dw-edma-core.c driver, I can see
that dmaengine_prep_slave_single() (which will call
device_prep_slave_sg(.., .., 1, .., .., ..)) allocates a new
dma_async_tx_descriptor for each function call.

I can see that device_prep_slave_sg() (dw_edma_device_prep_slave_sg()) will
call dw_edma_device_transfer() which will call vchan_tx_prep(), which adds
the descriptor to the tail of a list.

I can also see that dw_edma_done_interrupt() will automatically start the
transfer of the next descriptor (using vchan_next_desc()).

So this looks like it is supposed to be asynchronous... however, if we simply
remove the mutex, we get IOMMU errors, most likely because the DMA writes to
an incorrect address.

It looks like this is because dmaengine_prep_slave_single() really requires
dmaengine_slave_config() for each transfer. (Since we are supplying a src_addr
in the sconf that we are supplying to dmaengine_slave_config().)

(i.e. we can't call dmaengine_slave_config() while a DMA transfer is active.)

So while this API is supposed to be async, to me it looks like it can only
be used in a synchronous manner... But that seems like a really weird design.

Am I missing something obvious here?


If the dmaengine_prep_slave_single() instead took a sconfig as a parameter,
then it seems like it would be possible to use this API asynchronously.

There does seem to be other drivers holding a mutex around
dmaengine_slave_config() + dmaengine_prep_slave_single()... but it feels like
this should be avoidable (at least for dw-edma), if
dmaengine_prep_slave_single() simply took an sconf.

What am I missing? :)


Kind regards,
Niklas


On Thu, Dec 12, 2024 at 08:34:39PM +0900, Damien Le Moal wrote:
> +static int nvmet_pciep_epf_dma_transfer(struct nvmet_pciep_epf *nvme_epf,
> +		struct nvmet_pciep_segment *seg, enum dma_data_direction dir)
> +{
> +	struct pci_epf *epf = nvme_epf->epf;
> +	struct dma_async_tx_descriptor *desc;
> +	struct dma_slave_config sconf = {};
> +	struct device *dev = &epf->dev;
> +	struct device *dma_dev;
> +	struct dma_chan *chan;
> +	dma_cookie_t cookie;
> +	dma_addr_t dma_addr;
> +	struct mutex *lock;
> +	int ret;
> +
> +	switch (dir) {
> +	case DMA_FROM_DEVICE:
> +		lock = &nvme_epf->dma_rx_lock;
> +		chan = nvme_epf->dma_rx_chan;
> +		sconf.direction = DMA_DEV_TO_MEM;
> +		sconf.src_addr = seg->pci_addr;
> +		break;
> +	case DMA_TO_DEVICE:
> +		lock = &nvme_epf->dma_tx_lock;
> +		chan = nvme_epf->dma_tx_chan;
> +		sconf.direction = DMA_MEM_TO_DEV;
> +		sconf.dst_addr = seg->pci_addr;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	mutex_lock(lock);
> +
> +	dma_dev = dmaengine_get_dma_device(chan);
> +	dma_addr = dma_map_single(dma_dev, seg->buf, seg->length, dir);
> +	ret = dma_mapping_error(dma_dev, dma_addr);
> +	if (ret)
> +		goto unlock;
> +
> +	ret = dmaengine_slave_config(chan, &sconf);
> +	if (ret) {
> +		dev_err(dev, "Failed to configure DMA channel\n");
> +		goto unmap;
> +	}
> +
> +	desc = dmaengine_prep_slave_single(chan, dma_addr, seg->length,
> +					   sconf.direction, DMA_CTRL_ACK);
> +	if (!desc) {
> +		dev_err(dev, "Failed to prepare DMA\n");
> +		ret = -EIO;
> +		goto unmap;
> +	}
> +
> +	cookie = dmaengine_submit(desc);
> +	ret = dma_submit_error(cookie);
> +	if (ret) {
> +		dev_err(dev, "DMA submit failed %d\n", ret);
> +		goto unmap;
> +	}
> +
> +	if (dma_sync_wait(chan, cookie) != DMA_COMPLETE) {
> +		dev_err(dev, "DMA transfer failed\n");
> +		ret = -EIO;
> +	}
> +
> +	dmaengine_terminate_sync(chan);
> +
> +unmap:
> +	dma_unmap_single(dma_dev, dma_addr, seg->length, dir);
> +
> +unlock:
> +	mutex_unlock(lock);
> +
> +	return ret;
> +}

