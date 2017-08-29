From: jthumshirn@suse.de (Johannes Thumshirn)
Date: Tue, 29 Aug 2017 15:59:23 +0200
Subject: [PATCH for-4.13] nvme-pci: use dma memory for the host memory
 buffer descriptors
In-Reply-To: <20170828084718.29007-1-hch@lst.de>
References: <20170828084718.29007-1-hch@lst.de>
Message-ID: <20170829135923.GF9310@linux-x5ow.site>

On Mon, Aug 28, 2017@10:47:18AM +0200, Christoph Hellwig wrote:
> -	descs = kcalloc(max_entries, sizeof(*descs), GFP_KERNEL);
> +	descs = dma_zalloc_coherent(dev->dev, max_entries * sizeof(*descs),
> +			&descs_dma, GFP_KERNEL);

[...]

> -	kfree(descs);
> +	dma_free_coherent(dev->dev, max_entries * sizeof(*dev->host_mem_descs),
> +			descs, descs_dma);

If the patch isn't super urgent, I'd prefere the sizeof() arguments being
aligned, i.e. either sizeof(*descs) _or_ sizeof(*dev->host_mem_descs) but not
both. It's rather confusing for the reader. Maybe just cache the max_entries *
sizeof(*dev->host_mem_descs) value?

Other than that it looks good to me,
Reviewed-by: Johannes Thumshirn <jthumshirn at suse.de>

-- 
Johannes Thumshirn                                          Storage
jthumshirn at suse.de                                +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
Key fingerprint = EC38 9CAB C2C4 F25D 8600 D0D0 0393 969D 2D76 0850
