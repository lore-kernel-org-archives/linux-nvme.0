From: keith.busch@intel.com (Keith Busch)
Date: Mon, 22 May 2017 03:22:30 -0400
Subject: [PATCH 4/4] nvme-pci: implement host memory buffer support
In-Reply-To: <20170520131357.15929-5-hch@lst.de>
References: <20170520131357.15929-1-hch@lst.de>
 <20170520131357.15929-5-hch@lst.de>
Message-ID: <20170522072229.GI7850@localhost.localdomain>

On Sat, May 20, 2017@03:13:57PM +0200, Christoph Hellwig wrote:
> +	for (size = 0; size < preferred; size += chunk_size) {
> +		u32 len = min_t(u64, chunk_size, preferred - size);
> +		dma_addr_t dma_addr;
> +
> +		bufs[i] = dma_alloc_attrs(dev->dev, len, &dma_addr, GFP_KERNEL,
> +				DMA_ATTR_NO_KERNEL_MAPPING | DMA_ATTR_NO_WARN);
> +		if (!bufs[i])
> +			break;
> +
> +		descs[i].addr = cpu_to_le64(dma_addr);
> +		descs[i].size = cpu_to_le32(len / dev->ctrl.page_size);
> +		i++;
> +	}
> +
> +	if (!size || (min && size < min)) {
> +		dev_warn(dev->ctrl.device,
> +			"failed to allocate host memory buffer.\n");
> +		goto out_free_bufs;
> +	}
> +
> +	dev_info(dev->ctrl.device,
> +		"allocated %lld MiB host memory buffer.\n", size / 1024 / 1024);
> +	dev->nr_host_mem_descs = i;
> +	dev->host_mem_size = size;
> +	dev->host_mem_descs = descs;
> +	dev->host_mem_desc_bufs = bufs;
> +	return 0;
> +
> +out_free_bufs:
> +	while (--i >= 0) {
> +		struct nvme_host_mem_buf_desc *desc = &dev->host_mem_descs[i];

I think you want to use the local desc's variable since
dev->host_mem_descs isn't set if you goto this out_free_bufs label.
