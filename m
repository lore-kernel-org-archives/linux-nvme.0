From: keith.busch@intel.com (Keith Busch)
Date: Mon, 9 Oct 2017 12:03:00 -0600
Subject: [PATCH V6] nvme-pci: add SGL support
In-Reply-To: <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
References: <1507232903-9532-1-git-send-email-ckulkarnilinux@gmail.com>
 <1507232903-9532-2-git-send-email-ckulkarnilinux@gmail.com>
Message-ID: <20171009180300.GD19329@localhost.localdomain>

On Thu, Oct 05, 2017@12:48:23PM -0700, Chaitanya Kulkarni wrote:
> +	iod_list(req)[0] = sg_list;
> +	iod->first_dma = sgl_dma;
> +
> +	if (entries <= SGES_PER_PAGE) {
> +		nvme_pci_sgl_set_last_seg(&cmd->dptr.sgl, sgl_dma, entries);
> +
> +		for (i = 0; i < entries; i++) {
> +			nvme_pci_sgl_set_data(&sg_list[i], sg);
> +			length -= sg_dma_len(sg);
> +			sg = sg_next(sg);
> +		}
> +
> +		WARN_ON(length > 0);
> +		return BLK_STS_OK;
> +	}
> +
> +	nvme_pci_sgl_set_seg(&cmd->dptr.sgl, sgl_dma);
> +
> +	do {
> +		if (i == SGES_PER_PAGE) {
> +			struct nvme_sgl_desc *old_sg_desc = sg_list;
> +			struct nvme_sgl_desc *link = &old_sg_desc[i - 1];
> +
> +			sg_list = dma_pool_alloc(pool, GFP_ATOMIC, &sgl_dma);
> +			if (!sg_list)
> +				return BLK_STS_RESOURCE;
> +
> +			i = 0;
> +			iod_list(req)[iod->npages++] = sg_list;
> +			sg_list[i++] = *link;
> +
> +			if (entries < SGES_PER_PAGE)
> +				nvme_pci_sgl_set_last_seg(link, sgl_dma, entries);
> +			else
> +				nvme_pci_sgl_set_seg(link, sgl_dma);
> +		}
> +
> +		nvme_pci_sgl_set_data(&sg_list[i], sg);
> +
> +		length -= sg_dma_len(sg);
> +		sg = sg_next(sg);
> +		entries--;
> +	} while (length > 0);

There's two loops here doing essentially the same thing, but I don't
think the single segment needs to have a special case.
