From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 15 Jun 2016 03:48:00 -0700
Subject: [PATCH] NVMe:Support for Host Memory Buffer(HMB)
In-Reply-To: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
References: <1465565964-7167-1-git-send-email-a.dawn@samsung.com>
Message-ID: <20160615104800.GC32253@infradead.org>

> +static unsigned int  set_max_hmb = 1<<9;
> +module_param(set_max_hmb, uint, 0444);
> +MODULE_PARM_DESC(set_max_hmb, "set max size of Host Memory Buffer supported by host in units of MB");

no need for the set prefix, also there is a double white space above.

Moreso I think the limit needs to be relative to the available memory
in the system.

> +static unsigned int  set_hmb_chunk = 1<<10;
> +module_param(set_hmb_chunk, uint, 0444);
> +MODULE_PARM_DESC(set_hmb_chunk, "set chunk size of Host Memory Buffer in discriptor list in KB");

Why would the user care about a chunk size?

Also all the CMB code should be in pci.c, nothing of it applies for
Fabrics.

> +static int nvme_set_hmb_feature(struct nvme_ctrl *dev, u32 hmb_enable, u64 hmb_size)

Plese keep your line length below 80 characters.


> +int nvme_get_hmbcap(struct nvme_ctrl *dev)
> +{
> +	u64 max_hmb = set_max_hmb << 10;
> +
> +	if (!set_max_hmb || !set_hmb_chunk)
> +		return -EINVAL;
> +
> +	if (!dev->hmb.host_mem_pre)
> +		return -EINVAL;
> +
> +	/* Is Min Host buffer size too high */
> +	if (dev->hmb.host_mem_min > max_hmb) {
> +		dev->hmb.host_mem_pre = 0;
> +		dev->hmb.host_mem_min = 0;
> +		return -EINVAL;
> +	}
> +	/* Is Preffered  Host buffer size too high? set it to set_max_hmb */
> +	if (dev->hmb.host_mem_pre > max_hmb)
> +		dev->hmb.host_mem_pre = max_hmb;

FYI, we really should print a message to the kernel log that we're
using X MB size for the host buffer so that people know where all
their memory goes.  Probably a sysfs file as well.

We'll also need to think about the kdump kernel which has very little
memory available.

> +
> +int nvme_setup_hmb(struct nvme_ctrl *dev)
> +{
> +	struct nvme_features feat;
> +	struct hmb_descriptor *desc_list;
> +	struct hmb_descriptor_info *desc_info;
> +	u64 hmb_chunk_size, hmb_allocated, hmb_pre, max_desc_nent;
> +	u32 page_size, page_shift = 0, nents = 0, offset;
> +	int status;
> +
> +	page_size = dev->page_size;
> +	while (page_size >>= 1)
> +		page_shift++;

This should probably use ilog2 if it's needed at all.

> +	status = nvme_get_hmbcap(dev);
> +	if (status) {
> +		if (dev->hmb.flags & NVME_HMB_SET_MR) {
> +			dev->hmb.flags &= ~(NVME_HMB_SET_MR);

no need for the braces.

> +			(sizeof(struct hmb_descriptor)*max_desc_nent) + 0x10;

Whitespace damage (and magic values..)

> +		/* check 16 byte allignment */
> +		offset = dev->hmb.hmb_desc_info_list.dma_addr & 0xf;
> +		if (offset)
> +			offset = (0x10 - offset);

dma_alloc_coherent gurantees cache line alinments.

> +		desc_list = dev->hmb.hmb_desc_info_list.vaddr + offset;
> +
> +		desc_info = (struct hmb_descriptor_info *)kmalloc(
> +				sizeof(struct hmb_descriptor_info)*max_desc_nent,
> +				GFP_ATOMIC);

Should use kmalloc_aray. No need for the cast of the return value.
And why the GFP_ATOMIC allocation

> +		hmb_allocated = 0;
> +		while (hmb_allocated < hmb_pre) {
> +			/* adjust chunk size if it crosses boundary */
> +			if (hmb_chunk_size > (hmb_pre - hmb_allocated))
> +				hmb_chunk_size = (hmb_pre - hmb_allocated);
> +			/* allocate 1 page extra for page alligned */

dma coherent allocations are always page aligned, see
Documentation/DMA-API-HOWTO.txt.

> +			desc_info[nents].size = hmb_chunk_size + dev->page_size;
> +			desc_info[nents].vaddr = dma_alloc_coherent(dev->dev,
> +						desc_info[nents].size,
> +						&desc_info[nents].dma_addr,
> +						GFP_KERNEL);

Given that the hose will never access this memory it sounds like this
should use dma_alloc_attrs with the DMA_ATTR_NON_CONSISTENT and
DMA_ATTR_NO_KERNEL_MAPPING flags.  ARM SOC users will thank you..

> +		if (hmb_allocated < (dev->hmb.host_mem_min << 10)
> +			|| hmb_allocated > (dev->hmb.host_mem_pre << 10)) {

Please run the code throgh checkpatch.pl..
